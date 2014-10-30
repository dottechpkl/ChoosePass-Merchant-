//
//  PayoutViewController_iPhone.m
//  ChoosePass
//
//  Created by Dottechnologies on 7/22/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import "PayoutViewController_iPhone.h"
#import "NSObject+SBJSON.h"
#import "XMLReader.h"
#import "AppDelegate.h"

@interface PayoutViewController_iPhone ()
{
    NSString *checkStr;
}
@end

@implementation PayoutViewController_iPhone
@synthesize merchantId_payout;

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
    bankName_txtfield.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    bankName_txtfield.userInteractionEnabled=NO;
    accountNumber_txtfield.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    accountNumber_txtfield.userInteractionEnabled=NO;
    routingNumber_txtfield.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    routingNumber_txtfield.userInteractionEnabled=NO;
 //   payoutSchedule_txtfield.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    nextPayout.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    accountOwned.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    subscribers.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    passesSold.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    averageAddedSales.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    mostPopularPass.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    nextPayout_lbl.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    accountOwned_lbl.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    subscribers_lbl.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    passesSold_lbl.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    averageAddedSales_lbl.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    mostPopularPass_lbl.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    nextPayout.userInteractionEnabled=NO;
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getDetailsforPayout];
}

-(IBAction)saveAction:(id)sender
{
    [self saveDetailsforPayout];
}

#pragma mark -----------textfield Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    [theTextField resignFirstResponder];
    return YES;
}

-(void)saveDetailsforPayout
{
    if([GlobalInstances checkNetwork]==FALSE)
    {
        [GlobalInstances showAlertMessage:nil withMessage:@"There was a problem connecting to the server"];
    }
    else
    {
        checkStr=@"1";
        [appdelRef showProgress:@"Please wait..."];
        self.view.userInteractionEnabled = NO;
        
        NSString *key=[[GlobalInstances sharedInstance]getValueFromUserDefaults:@"MobileKey"];
        
        NSDictionary *dic=@{@"mobileKey": key,@"merchantId":merchantId_payout,@"userType":@"merchant",@"bankName":bankName_txtfield.text,@"accountNumber":accountNumber_txtfield.text,@"routingNumber":routingNumber_txtfield.text,@"dtPayout":@""};
        
        NSString *jsonString = [dic JSONRepresentation];
        
         NSString *xml = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><update_merchant_payout_detail xmlns=\"urn:passwebservices\"><data>%@</data></update_merchant_payout_detail></soap:Body></soap:Envelope>",jsonString];
        
        [self webServiceCallWithHeadder:xml];
    }
}

-(void)getDetailsforPayout
{
    if([GlobalInstances checkNetwork]==FALSE)
    {
        [GlobalInstances showAlertMessage:nil withMessage:@"There was a problem connecting to the server"];
    }
    else
    {
        [appdelRef showProgress:@"Please wait..."];
        self.view.userInteractionEnabled = NO;
        
        checkStr=@"2";
        
        NSString *key=[[GlobalInstances sharedInstance]getValueFromUserDefaults:@"MobileKey"];
        
        NSDictionary *dic=@{@"szMobileKey": key,@"merchantId":merchantId_payout,@"userType":@"merchant"};
        
        NSString *jsonString = [dic JSONRepresentation];
        
        NSString *xml = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><get_merchant_payout xmlns=\"urn:passwebservices\"><data>%@</data></get_merchant_payout></soap:Body></soap:Envelope>",jsonString];
        
        [self webServiceCallWithHeadder:xml];
    }
}

-(void)webServiceCallWithHeadder:(NSString*)xml
{
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",urlWebService]];
    
    request = [[ASIFormDataRequest alloc]initWithURL:url];
    
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
    if([checkStr isEqualToString:@"1"])
    {
        NSDictionary* json_string = [[[[dict objectForKey:@"SOAP-ENV:Envelope"] objectForKey:@"SOAP-ENV:Body"] objectForKey:@"ns1:update_merchant_payout_detailResponse"]objectForKey:@"return"];
        NSString *str=[json_string valueForKey:@"text"];
        
        NSRange r;
        while ((r = [str rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
            str = [str stringByReplacingCharactersInRange:r withString:@""];
        
        
        NSDictionary *arr =
        [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding:NSISOLatin1StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: nil];
        
        NSString *response=[[arr valueForKey:@"site_response"]valueForKey:@"response"];
        NSString *message=[[arr valueForKey:@"site_message"]valueForKey:@"message"];
        
        if([response isEqualToString:@"SUCCESS"])
        {
            [GlobalInstances showAlertMessage:response withMessage:message];
        }
        else
        {
            [GlobalInstances showAlertMessage:response withMessage:message];
        }
    }
    else
    {
        NSDictionary* json_string = [[[[dict objectForKey:@"SOAP-ENV:Envelope"] objectForKey:@"SOAP-ENV:Body"] objectForKey:@"ns1:get_merchant_payoutResponse"]objectForKey:@"return"];
        NSString *str=[json_string valueForKey:@"text"];
        
        NSRange r;
        while ((r = [str rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
            str = [str stringByReplacingCharactersInRange:r withString:@""];
        
        
        NSDictionary *arr =
        [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding:NSISOLatin1StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: nil];
        
        NSString *response=[[[arr valueForKey:@"payout_list"]valueForKey:@"site_response"]valueForKey:@"response"];

        
        if([response isEqualToString:@"SUCCESS"])
        {
            bankName_txtfield.text=[[arr valueForKey:@"payout_list"]valueForKey:@"bank_name"];
            accountNumber_txtfield.text=[[arr valueForKey:@"payout_list"]valueForKey:@"account_number"];
            routingNumber_txtfield.text=[[arr valueForKey:@"payout_list"]valueForKey:@"routing_number"];
            //payoutSchedule_txtfield.text=[[arr valueForKey:@"payout_list"]valueForKey:@"payout_date"];
            mostPopularPass_lbl.text=[[arr valueForKey:@"payout_list"]valueForKey:@"szPopularPass"];
            subscribers_lbl.text=[[[arr valueForKey:@"payout_list"]valueForKey:@"totalPassSubscribed"]stringValue];
        }
        else
        {
            [GlobalInstances showAlertMessage:response withMessage:@"Please try Again"];
        }
    }
}

-(IBAction)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)contactTeam:(id)sender
{
    
}

-(IBAction)btnAction:(id)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
