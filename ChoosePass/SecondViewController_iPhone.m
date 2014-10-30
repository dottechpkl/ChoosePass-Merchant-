//
//  SecondViewController_iPhone.m
//  ChoosePass
//
//  Created by Dottechnologies on 6/10/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import "SecondViewController_iPhone.h"
#import "UsePassViewController_iPhone.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSObject+SBJSON.h"
#import "XMLReader.h"
#import "AppDelegate.h"
#import "NSDictionary+userPasses.h"
#import "AdminPassCustomCell.h"
#import "OverlayViewController.h"
#import "MerchantAccountViewController_iPhone.h"
#import "CreateNewPassesView.h"

@interface SecondViewController_iPhone ()

@property(strong,nonatomic)NSString *showPopup;
@end

@implementation SecondViewController_iPhone

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
    
    if(IS_IPHONE_5)
        bottomBtn.frame=CGRectMake(0, 450, 320, 53);
    else
        bottomBtn.frame=CGRectMake(0, 364 , 320, 53);
            
    [bottomBtn setImage:[UIImage imageNamed:@"create_new_pass_white.png"] forState:UIControlStateNormal];
    if(IS_IPHONE_5)
    table.frame=CGRectMake(0, 0, 320, 513);
    else
    table.frame=CGRectMake(0, 0, 320, 515);

    userPass_arr=[[NSMutableArray alloc]init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self performSelectorInBackground:@selector(getData) withObject:nil];
}

#pragma mark-WebService for getting data
-(void)getData
{
    if([GlobalInstances checkNetwork]==FALSE)
    {
        UIAlertView *networkAlert = [[UIAlertView alloc]initWithTitle:nil message:@"There was a problem connecting to the server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [networkAlert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
    }
    else
    {
        [appdelRef showProgress:@"Please wait.."];
        self.view.userInteractionEnabled = NO;
        
            NSString* xml;
            NSString *key=[[GlobalInstances sharedInstance]getValueFromUserDefaults:@"merchant_Id"];
            
            NSDictionary *postDict = [NSDictionary dictionaryWithObjectsAndKeys:key,@"id",nil];
            
            NSString *jsonString = [postDict JSONRepresentation];
            
            xml = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><get_all_passes_by_merchantId xmlns=\"urn:passwebservices\"><data>%@</data></get_all_passes_by_merchantId></soap:Body></soap:Envelope>",jsonString];
        
        [self webServiceCallWithHeadder:xml];
    }
}

-(void)webServiceCallWithHeadder:(NSString*)xml
{
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",urlWebService]];
    
    request = [[ASIFormDataRequest alloc] initWithURL:url];
    
    request.delegate = self;
    
    [request addRequestHeader:@"Content-Type" value:@"text/xml"];
    
    [request appendPostData: [xml dataUsingEncoding:NSUTF8StringEncoding]];
    
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
    
    NSDictionary *dict1 = [XMLReader dictionaryForXMLString:request1.responseString error:nil];
        NSDictionary* json_string= [[[[dict1 objectForKey:@"SOAP-ENV:Envelope"] objectForKey:@"SOAP-ENV:Body"] objectForKey:@"ns1:get_all_passes_by_merchantIdResponse"]objectForKey:@"return"] ;
        NSString *str=[json_string valueForKey:@"text"];
        
        NSRange r;
        while ((r = [str rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        {
            str = [str stringByReplacingCharactersInRange:r withString:@""];
        }
        
        str=[str stringByReplacingOccurrencesOfString:@"\\:" withString:@":"];
        
        (appdelRef).myPassesDictionary=
        [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding:NSUTF8StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: nil];
        NSString *response=[[(appdelRef).myPassesDictionary valueForKey:@"site_response"]valueForKey:@"response"];
        
        NSArray *arr=[(appdelRef).myPassesDictionary  valueForKey:@"merchant_passes"];
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
                for(NSDictionary *dict in arr)
                {
                    [userPass_arr addObject:dict];
                }
                [table performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
            }
        }
        else
        {
            UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:response message:@"Please try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [Alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
        }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 114;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
        return [userPass_arr count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    AdminPassCustomCell * adminCell=(AdminPassCustomCell*)[tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (adminCell == nil)
    {
        NSArray *array=  [[NSBundle mainBundle] loadNibNamed:@"AdminPassCustomCell" owner:self options:nil];
        adminCell=[array objectAtIndex:0];
    }

    NSDictionary *dictionary;
    dictionary=userPass_arr[indexPath.row];
        
    adminCell.topLabel.text = [dictionary szTitle_user];
    adminCell.descLabel.text = [dictionary szShortDesc_user];
    if(![[dictionary fPrice_user]isEqualToString:@"0.00"])
    {
        adminCell.xxLabel.text=[NSString stringWithFormat:@"$%@",[dictionary fPrice_user]];
    }
    
    if(![[dictionary fYearlyPrice_user] isEqualToString:@"0.00"]){
        adminCell.xxLabel.text=[NSString stringWithFormat:@"$%@",[dictionary fYearlyPrice_user]];
    }
    
    if((![[dictionary fPrice_user]isEqualToString:@"0.00"]) && (![[dictionary fYearlyPrice_user] isEqualToString:@"0.00"]))
    {
        adminCell.xxLabel.text=[NSString  stringWithFormat:@"$%@ / $%@",
                                [dictionary fPrice_user],[dictionary fYearlyPrice_user]];
    }
    
    adminCell.SubscribeLabel.text=[NSString stringWithFormat:@"Subscribers: %@",[dictionary valueForKey:@"total_subscription"]];
    
   [adminCell.imageViewAdmin setImageWithURL:[NSURL URLWithString:[dictionary  szUploadImageName_user]] placeholderImage:[UIImage imageNamed:@"frame1.png"]];
    
    if ([tableView1 respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView1 setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if (indexPath.row % 2 == 0)
    {
        [adminCell setBackgroundColor:cell1_color];
    }
    else
    {
        [adminCell setBackgroundColor:cell2_color];
    }
    return adminCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dictionary;
            dictionary=userPass_arr[indexPath.row];
            UsePassViewController_iPhone *usePass=[[UsePassViewController_iPhone alloc]initWithNibName:[GlobalInstances xibNameForName:@"UsePassViewController"] bundle:nil];
    usePass.passId=[dictionary id_user];
    usePass.cleanTitle=[dictionary valueForKey:@"szCleanTitle"];
    [self.navigationController pushViewController:usePass animated:YES];
}


-(IBAction)bottomBtnAction:(id)sender
{
        CGFloat height=[UIScreen mainScreen].bounds.size.height;
        if(height==568)
        {
            CreateNewPassesView *create=[[CreateNewPassesView alloc]initWithNibName:@"CreateNewPassesView" bundle:nil];
            create.update=@"No";
            create.toplabel=@"Add Pass";
            [self.navigationController pushViewController:create animated:YES];
        }
        else
        {
            CreateNewPassesView *create=[[CreateNewPassesView alloc]initWithNibName:@"CreateNewPassesView4" bundle:nil];
            create.update=@"No";
            create.toplabel=@"Add Pass";
            [self.navigationController pushViewController:create animated:YES];
        }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
