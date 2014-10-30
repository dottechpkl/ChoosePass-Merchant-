//
//  LocationViewController_iPhone.m
//  ChoosePass
//
//  Created by Dottechnologies on 7/21/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import "LocationViewController_iPhone.h"
#import "AppDelegate.h"
#import "NSObject+SBJSON.h"
#import "XMLReader.h"
#import "LocationCell.h"
#import "LocationDetailViewController_iPhone.h"

@interface LocationViewController_iPhone ()
@end

@implementation LocationViewController_iPhone
@synthesize merchantId_location;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    topLabel.textColor=[UIColor whiteColor];
    topLabel.font=[UIFont fontWithName:@"Brisko Sans" size:16];
    table.backgroundColor=[UIColor clearColor];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getLocationDetail];
}

-(void)getLocationDetail
{
    if([GlobalInstances checkNetwork]==FALSE)
    {
        [GlobalInstances showAlertMessage:nil withMessage:@"There was a problem connecting to the server"];
    }
    else
    {
        [appdelRef showProgress:@"Please wait..."];
        self.view.userInteractionEnabled = NO;
        NSString *mobilekey=[[GlobalInstances sharedInstance]getValueFromUserDefaults:@"MobileKey"];
        
        NSDictionary *dic1=@{@"mobileKey":mobilekey,@"merchantId":merchantId_location,@"userType":@"merchant"};
        NSString *str=[dic1 JSONRepresentation];

        NSString *xml=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><get_merchant_location_by_mobile_key xmlns=\"urn:passwebservices\"><data>%@</data></get_merchant_location_by_mobile_key></soap:Body></soap:Envelope>",str];
        
        [self webServiceCallWithHeadder:xml];

    }
}

-(void)webServiceCallWithHeadder:(NSString*)xml
{
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",urlWebService]];
    
    request = [[ASIFormDataRequest alloc] initWithURL:url];
    
    request.delegate = self;
    
    [request addRequestHeader:@"Content-Type" value:@"text/xml"];
    
    [request appendPostData: [xml dataUsingEncoding:NSISOLatin1StringEncoding]];
    [request setDidFinishSelector:@selector(requestDidFinish:)];
    
    [request setDidFailSelector:@selector(requestDidFail:)];
    
    [request startAsynchronous];
    
}
-(void)requestDidFail:(ASIHTTPRequest*)request
{
    [appdelRef hideProgress];
    self.view.userInteractionEnabled = YES;
    [GlobalInstances showAlertMessage:@"Connection Failed." withMessage:@"Please try again"];
    return;
}
-(void)requestDidFinish:(ASIHTTPRequest*)request1
{
    [appdelRef hideProgress];
    self.view.userInteractionEnabled = YES;
    NSDictionary *dict = [XMLReader dictionaryForXMLString:request1.responseString error:nil];
    
    NSDictionary* json_string = [[[[dict objectForKey:@"SOAP-ENV:Envelope"] objectForKey:@"SOAP-ENV:Body"] objectForKey:@"ns1:get_merchant_location_by_mobile_keyResponse"]objectForKey:@"return"];
    NSString *str=[json_string valueForKey:@"text"];
    
    NSRange r;
    while ((r = [str rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        str = [str stringByReplacingCharactersInRange:r withString:@""];
    
    
    NSDictionary *arr =
    [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding:NSISOLatin1StringEncoding]
                                    options: NSJSONReadingMutableContainers
                                      error: nil];
    
    NSString *response=[[arr valueForKey:@"site_response"]valueForKey:@"response"];
    
    NSArray *merlocation=[arr objectForKey:@"merchant_location"];

    NSString *str1=[merlocation objectAtIndex:0];
    
    if ([response isEqualToString:@"SUCCESS"])
    {
        if([str1 isKindOfClass:[NSString class]]==YES)
        {
            if([str1 isEqualToString:@"No Record Found"])
            {
                [GlobalInstances showAlertMessage:response withMessage:[merlocation objectAtIndex:0]];
            }
        }
        else
        {
            locnickname=[[NSMutableArray alloc]init];
            locid=[[NSMutableArray alloc]init];
            zipcode=[[NSMutableArray alloc]init];

            for (NSDictionary *dic in merlocation)
            {
                locidstr=[dic objectForKey:@"id"];
                zipcodestr=[dic objectForKey:@"szZipCode"];
                locnicknamestr=[dic objectForKey:@"szLocationNickName"];
                [locnickname addObject:locnicknamestr];
                [locid addObject:locidstr];
                [zipcode addObject:zipcodestr];
            }
             [table reloadData];
        }
    }
    else
    {
        [GlobalInstances showAlertMessage:response withMessage:@"No Record found"];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return locnickname.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSArray *nib;
    if (cell==nil)
    {
        nib=[[NSBundle mainBundle]loadNibNamed:@"LocationCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    if (indexPath.row % 2!=0)
    {
        cell.img.image=[UIImage imageNamed:@"lightOrange.png"];
    }
    else
    {
        cell.img.image=[UIImage imageNamed:@"darkOrange.png"];
    }
    cell.label.text=[locnickname objectAtIndex:indexPath.row];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LocationDetailViewController_iPhone *detail=[[LocationDetailViewController_iPhone alloc]initWithNibName:[GlobalInstances xibNameForName:@"LocationDetailViewController"] bundle:nil];
    detail.passlocid=[locid objectAtIndex:indexPath.row];
    detail.passlocnickname=[locnickname objectAtIndex:indexPath.row];
    detail.passzipcode=[zipcode objectAtIndex:indexPath.row];
    detail.update=@"Yes";
    detail.checkWebservce=@"1";
    detail.merchantId_locationdetail=merchantId_location;
    [self.navigationController pushViewController:detail animated:YES];
}

-(IBAction)addloc:(id)sender
{
    LocationDetailViewController_iPhone *detail=[[LocationDetailViewController_iPhone alloc]initWithNibName:[GlobalInstances xibNameForName:@"LocationDetailViewController"] bundle:nil];
    detail.merchantId_locationdetail=merchantId_location;
    [self.navigationController pushViewController:detail animated:YES];
}
-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

 - (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
