//
//  MerchantPassViewController_iPhone.m
//  ChoosePass
//
//  Created by Dottechnologies on 6/11/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import "MerchantPassViewController_iPhone.h"
#import "AppDelegate.h"
#import "NSObject+SBJSON.h"
#import "XMLReader.h"
#import "AllMerchantCustomCell.h"
#import "NSDictionary+passesInfo.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FeedBackViewController_iPhone.h"
#import "UsePassViewController_iPhone.h"
#import "CreateNewPassesView.h"

@interface MerchantPassViewController_iPhone ()
{
    NSString *checkWebSevrice;
    
}
@end

@implementation MerchantPassViewController_iPhone
@synthesize getId;
@synthesize getDictionary;
@synthesize merchantName;
//static int flag=0;

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

    [requestNewPass setImage:[UIImage imageNamed:@"add_new_pass.png"] forState:UIControlStateNormal];

    
    topLabel.textColor=[UIColor whiteColor];
    topLabel.text=merchantName;
    topLabel.font=[UIFont fontWithName:@"Brisko Sans" size:16];
    
     // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self performSelectorInBackground:@selector(getPasses) withObject:nil];
}

-(void)getPasses
{
    checkWebSevrice=@"getPasses";
    if([GlobalInstances checkNetwork]==FALSE)
    {
        UIAlertView *networkAlert = [[UIAlertView alloc]initWithTitle:nil message:@"There was a problem connecting to the server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [networkAlert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
    }
    else
    {
        [appdelRef showProgress:@"Please wait.."];
        self.view.userInteractionEnabled = NO;
     
        NSDictionary *postDict = [NSDictionary dictionaryWithObjectsAndKeys:getId,@"id",nil];

        NSString *jsonString = [postDict JSONRepresentation];
        
        NSString* xml = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><get_all_passes_by_merchantId xmlns=\"urn:passwebservices\"><data>%@</data></get_all_passes_by_merchantId></soap:Body></soap:Envelope>",jsonString];
        
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
    if([checkWebSevrice isEqualToString:@"getPasses"])
    {
        NSDictionary *dict1 = [XMLReader dictionaryForXMLString:request1.responseString error:nil];
        NSDictionary* json_string= [[[[dict1 objectForKey:@"SOAP-ENV:Envelope"] objectForKey:@"SOAP-ENV:Body"] objectForKey:@"ns1:get_all_passes_by_merchantIdResponse"]objectForKey:@"return"] ;
        NSString *str=[json_string valueForKey:@"text"];
        
        NSRange r;
        while ((r = [str rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
            str = [str stringByReplacingCharactersInRange:r withString:@""];

        responseDictionary=
        [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding:NSISOLatin1StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: nil];
        NSString *response=[[responseDictionary valueForKey:@"site_response"]valueForKey:@"response"];
        NSArray *arr=[responseDictionary  arr];
        NSString *string =arr[0];
        
        if([response isEqualToString:@"SUCCESS"])
        {
            if([string isKindOfClass:[NSString class]]==YES)
            {
                if([string isEqualToString:@"No Record Found."])
                [GlobalInstances showAlertMessage:response withMessage:string];
                table.hidden=true;
            }
            else
            {
                table.hidden=FALSE;
                [table performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
            }
        }
        else
        {
            UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:response message:@"Please try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [Alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
        }
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 110;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *getArr;

    getArr=[responseDictionary arr];
    return [getArr count];

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    AllMerchantCustomCell *tableViewCell=(AllMerchantCustomCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        NSArray *array;
        if (tableViewCell == nil)
        {
            array=  [[NSBundle mainBundle] loadNibNamed:@"AllMerchantCustomCell" owner:self options:nil];
            tableViewCell=[array objectAtIndex:0];
        }
        
        NSDictionary *dictionary = nil;
        NSArray *arr;
        arr=[responseDictionary arr];
    
        dictionary=arr[indexPath.row];
        
        tableViewCell.merchantName.text=[dictionary Tilte];
        tableViewCell.merchantCompany.text=[dictionary ShortDescription];
        [tableViewCell.merchantImage setImageWithURL:[NSURL URLWithString:[dictionary  UploadImageName]] placeholderImage:[UIImage imageNamed:@"frame1.png"]];
        tableViewCell.viewPassesBtn.hidden=TRUE;
    
        
        if (indexPath.row % 2 == 0)
            [tableViewCell setBackgroundColor:cell1_color];
        else
            [tableViewCell setBackgroundColor:cell2_color];
    
        tableViewCell.delegate=self;
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    return tableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UsePassViewController_iPhone *usePass=[[UsePassViewController_iPhone alloc]initWithNibName:[GlobalInstances xibNameForName:@"UsePassViewController"] bundle:nil];

    NSArray *arr;
    arr=[responseDictionary arr];
    
    NSDictionary *dict=arr [indexPath.row];
    usePass.cleanTitle=[dict CleanTitle];
    usePass.passId=[dict Id];
    usePass.showScreen=@"FromPasses";
    usePass.merchantImage=[getDictionary objectForKey:@"szUploadFileName"];
    [self.navigationController pushViewController:usePass animated:YES];
 }


-(IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)requestNewPass:(id)sender
{
        CGFloat height=[UIScreen mainScreen].bounds.size.height;
        if(height==568)
        {
            CreateNewPassesView *create=[[CreateNewPassesView alloc]initWithNibName:@"CreateNewPassesView" bundle:nil];
            [self.navigationController pushViewController:create animated:YES];
        }
        else
        {
            CreateNewPassesView *create=[[CreateNewPassesView alloc]initWithNibName:@"CreateNewPassesView4" bundle:nil];
            [self.navigationController pushViewController:create animated:YES];
            
        }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
