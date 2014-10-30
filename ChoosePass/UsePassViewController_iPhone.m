//
//  UsePassViewController_iPhone.m
//  ChoosePass
//
//  Created by Dottechnologies on 6/4/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import "UsePassViewController_iPhone.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSObject+SBJSON.h"
#import "XMLReader.h"
#import "AppDelegate.h"
#import "MainViewController_iPhone.h"


@interface UsePassViewController_iPhone ()
{
    NSString *str_admin;
    int elapsedSeconds;
}
@end

@implementation UsePassViewController_iPhone
@synthesize cleanTitle;
@synthesize showScreen;
@synthesize passId;
@synthesize merchantImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

-(IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    name1Label.font=[UIFont fontWithName:@"Brisko Sans" size:16];
    name2Label.font=[UIFont fontWithName:@"Brisko Sans" size:16];
    nextAvailableLabel.font=[UIFont fontWithName:@"Brisko Sans" size:21];
    offerHighlightLabel.font=[UIFont fontWithName:@"Brisko Sans" size:18];
    offerHighlightLabel.backgroundColor=[UIColor darkGrayColor];
    offerHighlightLabel.alpha=0.6;
    nextAvailableLabel.textColor=[UIColor whiteColor];
    showDescText.editable=NO;
    showDescText.backgroundColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.3];
    profileImage.contentMode = UIViewContentModeScaleAspectFit;
    str_admin=@"getPass";
    labelImage.backgroundColor=[UIColor darkGrayColor];
    labelImage.alpha=0.6;
    
    doneButton.hidden=FALSE;
    [doneButton  setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
    [activateButton setImage:[UIImage imageNamed:@"edit_admin.png"] forState:UIControlStateNormal];
    
    [self performSelectorInBackground:@selector(callWebService) withObject:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - WebService for getting data
-(void)callWebService
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
        NSDictionary *postDict = [NSDictionary dictionaryWithObjectsAndKeys:cleanTitle,@"title",nil];
        NSString *jsonString = [postDict JSONRepresentation];
        
        xml = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><get_pass_detail_by_title xmlns=\"urn:passwebservices\"><data>%@</data></get_pass_detail_by_title></soap:Body></soap:Envelope>",jsonString];
        
        [self webServiceCallWithHeadder:xml];
    }
}

-(void)deleteWebservice
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
        
        NSString *mobilekey=[[GlobalInstances sharedInstance]getValueFromUserDefaults:@"MobileKey"];
        
        NSDictionary *post;
        
        post=@{@"szMobileKey":mobilekey,@"szFlag":@"Merchant",@"idPass":passId};
            
        NSString *jsonstring=[post JSONRepresentation];
        
        NSString *xml=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><delete_passes xmlns=\"urn:passwebservices\"><data>%@</data></delete_passes></soap:Body></soap:Envelope>",jsonstring];
        
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
    
    NSDictionary *dict1 = [XMLReader dictionaryForXMLString:request1.responseString error:nil];
    
    if([str_admin isEqualToString:@"getPass"])
    {
            NSDictionary* json_string= [[[[dict1 objectForKey:@"SOAP-ENV:Envelope"] objectForKey:@"SOAP-ENV:Body"] objectForKey:@"ns1:get_pass_detail_by_titleResponse"]objectForKey:@"return"];
            
            NSString *str1=[json_string valueForKey:@"text"];

            NSRange r;
            while ((r = [str1 rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
                str1 = [str1 stringByReplacingCharactersInRange:r withString:@""];

            responseDictionary=
            [NSJSONSerialization JSONObjectWithData: [str1 dataUsingEncoding:NSISOLatin1StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: nil];
            NSString *response=[[responseDictionary valueForKey:@"site_response"]valueForKey:@"response"];
            
            NSArray *arr=[responseDictionary  valueForKey:@"pass_detail"];
            NSString *string =arr[0];
            if([response isEqualToString:@"SUCCESS"])
            {
                if([string isKindOfClass:[NSString class]]==YES)
                {
                    if([string isEqualToString:@"No Record Found."])
                    {
                        [GlobalInstances showAlertMessage:response withMessage:string];
                         activateButton.enabled=FALSE;
                    }
                }
                else
                {
                    dictionaryPassDetail=arr[0];
                  
                    [profileImage setImageWithURL:[NSURL URLWithString:[dictionaryPassDetail valueForKey:@"szMerchantImage"]] placeholderImage:[UIImage imageNamed:@"frame1.png"]];
                    
                    [backgroundImage setImageWithURL:[NSURL URLWithString:[dictionaryPassDetail valueForKey:@"szUploadImageName"]] placeholderImage:[UIImage imageNamed:@"frame1.png"]];
                    
                    name1Label.text=[dictionaryPassDetail valueForKey:@"szMerchantName"];
                    name2Label.text=[dictionaryPassDetail valueForKey:@"szTilte"];
                    offerHighlightLabel.text=[dictionaryPassDetail valueForKey:@"szOfferHighlight"];
                    showDescText.text=[dictionaryPassDetail valueForKey:@"szShortDescription"];
                    if(![[dictionaryPassDetail valueForKey:@"fPrice"]isEqualToString:@"0.00"]){
                        nextAvailableLabel.text=[NSString  stringWithFormat:@"Price:%@",[dictionaryPassDetail valueForKey:@"fPrice"]];
                    }
                    
                    if(![[dictionaryPassDetail valueForKey:@"fYearlyPrice"] isEqualToString:@"0.00"]){
                        nextAvailableLabel.text=[NSString  stringWithFormat:@"Yearly Price:%@",[dictionaryPassDetail valueForKey:@"fYearlyPrice"]];
                    }
                    
                    if((![[dictionaryPassDetail valueForKey:@"fPrice"]isEqualToString:@"0.00"]) && (![[dictionaryPassDetail valueForKey:@"fYearlyPrice"]isEqualToString:@"0.00"])){
                        nextAvailableLabel.text=[NSString  stringWithFormat:@"Price:%@\nYearly Price:%@",[dictionaryPassDetail valueForKey:@"fPrice"],[dictionaryPassDetail valueForKey:@"fYearlyPrice"]];
                    }
                }
            }
            else
            {
                activateButton.enabled=FALSE;
                UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:response message:@"Please try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [Alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
            }
    }
    else
    {
            NSDictionary* json_string= [[[[dict1 objectForKey:@"SOAP-ENV:Envelope"] objectForKey:@"SOAP-ENV:Body"] objectForKey:@"ns1:delete_passesResponse"]objectForKey:@"return"];
            
            NSString *str1=[json_string valueForKey:@"text"];
            
            NSRange r;
            while ((r = [str1 rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
                str1 = [str1 stringByReplacingCharactersInRange:r withString:@""];

            responseDictionary=
            [NSJSONSerialization JSONObjectWithData: [str1 dataUsingEncoding:NSISOLatin1StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: nil];
            NSString *response=[[responseDictionary valueForKey:@"site_response"]valueForKey:@"response"];
             NSString *message=[[responseDictionary valueForKey:@"site_message"]valueForKey:@"message"];
            if([response isEqualToString:@"SUCCESS"])
            {
                UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:response message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                alertView.delegate=self;
                alertView.tag=2;
                alertView=nil;
            }
            else
            {
                [GlobalInstances showAlertMessage:response withMessage:message];
            }
    }
}

-(IBAction)activateAction:(id)sender
{
        CGFloat height=[UIScreen mainScreen].bounds.size.height;
        if(height==568)
        {
            CreateNewPassesView *create=[[CreateNewPassesView alloc]initWithNibName:@"CreateNewPassesView" bundle:nil];
            create.update=@"Yes";
            create.toplabel=@"Edit Pass";
            create.passoffer=[dictionaryPassDetail objectForKey:@"szOfferHighlight"];
            create.passshort=[dictionaryPassDetail objectForKey:@"szShortDescription"];
            create.imagestr=[dictionaryPassDetail valueForKey:@"szUploadImageName"];
            create.passtitle=[dictionaryPassDetail valueForKey:@"szTilte"];
            create.passlong=[dictionaryPassDetail objectForKey:@"szDescription"];
            create.passuser=[dictionaryPassDetail objectForKey:@"iUserLimit"];
            create.passpromo=[dictionaryPassDetail objectForKey:@"iPromotional"];
            create.passlimitation=[dictionaryPassDetail objectForKey:@"iLimitions"];
            create.passlimit=[dictionaryPassDetail objectForKey:@"iLimitionCount"];
            create.passcountfinal=[dictionaryPassDetail objectForKey:@"iCountFinalExpiry"];
            create.passmonth=[dictionaryPassDetail objectForKey:@"iPeriod"];
            create.passyear=[dictionaryPassDetail objectForKey:@"iYearlyPeriod"];
            create.passmprice=[dictionaryPassDetail objectForKey:@"fPrice"];
            create.passyprice=[dictionaryPassDetail objectForKey:@"fYearlyPrice"];
            create.passid=[dictionaryPassDetail objectForKey:@"id"];
            create.passcategory=[dictionaryPassDetail objectForKey:@"idCategory"];
            create.passmerchant=[dictionaryPassDetail objectForKey:@"idMerchant"];
            create.Activationcount=[dictionaryPassDetail objectForKey:@"packageActivationCount"];
            create.couponNo=[dictionaryPassDetail objectForKey:@"szCouponCode"];
            create.passType=[dictionaryPassDetail objectForKey:@"szPassType"];

            [self.navigationController pushViewController:create animated:YES];
        }
        else
        {
            CreateNewPassesView *create=[[CreateNewPassesView alloc]initWithNibName:@"CreateNewPassesView4" bundle:nil];
            create.update=@"Yes";
            create.toplabel=@"Edit Pass";
            create.passoffer=[dictionaryPassDetail objectForKey:@"szOfferHighlight"];
            create.passshort=[dictionaryPassDetail objectForKey:@"szShortDescription"];
            create.imagestr=[dictionaryPassDetail valueForKey:@"szUploadImageName"];
            create.passtitle=[dictionaryPassDetail valueForKey:@"szTilte"];
            create.passlong=[dictionaryPassDetail objectForKey:@"szDescription"];
            create.passuser=[dictionaryPassDetail objectForKey:@"iUserLimit"];
            create.passpromo=[dictionaryPassDetail objectForKey:@"iPromotional"];
            create.passlimitation=[dictionaryPassDetail objectForKey:@"iLimitions"];
            create.passlimit=[dictionaryPassDetail objectForKey:@"iLimitionCount"];
            create.passcountfinal=[dictionaryPassDetail objectForKey:@"iCountFinalExpiry"];
            create.passmonth=[dictionaryPassDetail objectForKey:@"iPeriod"];
            create.passyear=[dictionaryPassDetail objectForKey:@"iYearlyPeriod"];
            create.passmprice=[dictionaryPassDetail objectForKey:@"fPrice"];
            create.passyprice=[dictionaryPassDetail objectForKey:@"fYearlyPrice"];
            create.passid=[dictionaryPassDetail objectForKey:@"id"];
            create.passcategory=[dictionaryPassDetail objectForKey:@"idCategory"];
            create.passmerchant=[dictionaryPassDetail objectForKey:@"idMerchant"];
            create.Activationcount=[dictionaryPassDetail objectForKey:@"packageActivationCount"];
            create.couponNo=[dictionaryPassDetail objectForKey:@"szCouponCode"];
            create.passType=[dictionaryPassDetail objectForKey:@"szPassType"];

            [self.navigationController pushViewController:create animated:YES];
        }
}

-(IBAction)doneAction:(id)sender
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Confirm!" message:@"Are you sure you wish to delete this Pass?\nPass holders will still be able to use their existing Pass, but will no longer be able to purchase or renew this Pass" delegate:self cancelButtonTitle:@"Yes. Delete." otherButtonTitles:@"Nevermind", nil];
        [alertView show];
        alertView.delegate=self;
        alertView.tag=1;
        alertView=nil;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if(alertView.tag==1)
    {
        if([title isEqualToString:@"Yes. Delete."])
        {
            str_admin=@"deletePass";
            [self deleteWebservice];
        }
    }
    if(alertView.tag==2)
    {
        if([title isEqualToString:@"OK"])
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
