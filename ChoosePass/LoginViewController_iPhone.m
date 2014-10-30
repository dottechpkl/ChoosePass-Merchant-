//
//  LoginViewController_iPhone.m
//  ChoosePass
//
//  Created by Dottechnologies on 5/29/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import "LoginViewController_iPhone.h"
#import "MainViewController_iPhone.h"
#import "AppDelegate.h"
#import "NSObject+SBJSON.h"
#import "XMLReader.h"

@interface LoginViewController_iPhone ()
{
    NSString *service;
}
@end

@implementation LoginViewController_iPhone
static int flag=0;

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
    emailTxtFld.autocapitalizationType=UITextAutocorrectionTypeNo;
    passwordTxrfld.autocapitalizationType=UITextAutocorrectionTypeNo;
    emailTxtFld.text=[[GlobalInstances sharedInstance]getValueFromUserDefaults:@"Email"];
    passwordTxrfld.text=[[GlobalInstances sharedInstance]getValueFromUserDefaults:@"Password"];
    flag=2;
    topLabel.textColor=[UIColor whiteColor];
    topLabel.font=[UIFont fontWithName:@"Brisko Sans" size:16];
    
    // Do any additional setup after loading the view from its nib.
}

 #pragma mark -----------textfield Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    [theTextField resignFirstResponder];
    return YES;
}


//Check box
- (IBAction)chckBoxAction:(id)sender
{
    if ([sender isSelected])
    {
        [sender setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [sender setSelected:NO];
        flag=1;
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        [sender setSelected:YES];
        flag=2;
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
	CGRect frame=self.view.frame;
    switch (textField.tag)
    {
        case 1:
            break;
        case 2:
            frame.origin.y=-20;
            break;
        default:
            break;
    }
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.2];
	frame.origin.x=0;
    self.view.frame=frame;
	[UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.1];
	CGRect frame=self.view.frame;
	frame.origin.x=0;
	frame.origin.y=0;
	self.view.frame=frame;
	[UIView commitAnimations];
}

//Login Button
-(IBAction)loginAction:(id)sender
{
    if(([emailTxtFld.text length]==0) || ([passwordTxrfld.text length]==0))
    {
        [GlobalInstances showAlertMessage:nil withMessage:@"Please enter Email and Password both."];
        return;
    }
    else
    {
        [self loginWebService];
    }
}

#pragma mark -----------Login Action
-(void)loginWebService
{
    if([GlobalInstances checkNetwork]==FALSE)
    {
        UIAlertView *networkAlert = [[UIAlertView alloc]initWithTitle:nil message:@"There was a problem connecting to the server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [networkAlert show];
    }
    else
    {
        service=@"Login";
        [appdelRef showProgress:@"Please wait..."];
        self.view.userInteractionEnabled = NO;

        NSDictionary *postDict = [NSDictionary dictionaryWithObjectsAndKeys:emailTxtFld.text,@"szEmail",passwordTxrfld.text,@"szPassword",@"merchant",@"szType",nil];
        NSString *jsonString = [postDict JSONRepresentation];
        
        NSString* xml = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><user_login xmlns=\"urn:passwebservices\"><data>%@</data></user_login></soap:Body></soap:Envelope>",jsonString];
        
        [self webServiceCallWithHeadder:xml];
    }
}

-(void)forgetPassword_webservice:(NSString*)email
{
    if([GlobalInstances checkNetwork]==FALSE)
    {
        UIAlertView *networkAlert = [[UIAlertView alloc]initWithTitle:nil message:@"There was a problem connecting to the server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [networkAlert show];
    }
    else
    {
        service=@"forgetPassword";
        [appdelRef showProgress:@"Please wait..."];
        self.view.userInteractionEnabled = NO;
        
        NSDictionary *postDict = [NSDictionary dictionaryWithObjectsAndKeys:email,@"email",nil];
        NSString *jsonString = [postDict JSONRepresentation];
        
        NSString* xml = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><merchant_reset_password xmlns=\"urn:passwebservices\"><data>%@</data></merchant_reset_password></soap:Body></soap:Envelope>",jsonString];
        
        [self webServiceCallWithHeadder:xml];
    }

}

-(void)merchantid:(NSString *)key
{
    if([GlobalInstances checkNetwork]==FALSE)
    {
        UIAlertView *networkAlert = [[UIAlertView alloc]initWithTitle:nil message:@"There was a problem connecting to the server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [networkAlert show];
    }
    else
    {
        service=@"merchantId";
        [appdelRef showProgress:@"Please wait..."];
        self.view.userInteractionEnabled = NO;

        NSDictionary *mobileKey=@{@"szMobileKey": key};
        NSString *post=[mobileKey JSONRepresentation];
        NSString *xml=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><get_merchant_detail_by_mobile_key xmlns=\"urn:passwebservices\"><data>%@</data></get_merchant_detail_by_mobile_key></soap:Body></soap:Envelope>",post];
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
     if([service isEqualToString:@"Login"])
     {
        NSDictionary* json_string= [[[[dict objectForKey:@"SOAP-ENV:Envelope"] objectForKey:@"SOAP-ENV:Body"] objectForKey:@"ns1:user_loginResponse"]objectForKey:@"return"] ;
        NSString *str=[json_string valueForKey:@"text"];
        
        NSDictionary *arr =
        [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding:NSISOLatin1StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: nil];
        NSString *response=[[arr valueForKey:@"site_response"]valueForKey:@"response"];
        NSString *message=[[arr valueForKey:@"site_message"]valueForKey:@"message"];

        if([response isEqualToString:@"SUCCESS"])
        {
            if(flag==1)
            {
                [[GlobalInstances sharedInstance]saveValueToUserDefaults:@"" forKey:@"Email"];
                [[GlobalInstances sharedInstance]saveValueToUserDefaults:@"" forKey:@"Password"];
              [[GlobalInstances sharedInstance]saveValueToUserDefaults:@"DetailNotSaved" forKey:@"LoginView"];
            }
           else if(flag==2)
            {
                [[GlobalInstances sharedInstance]saveValueToUserDefaults:emailTxtFld.text forKey:@"Email"];
                 [[GlobalInstances sharedInstance]saveValueToUserDefaults:passwordTxrfld.text forKey:@"Password"];
                [[GlobalInstances sharedInstance]saveValueToUserDefaults:@"DetailSaved" forKey:@"LoginView"];
            }
            
            NSString *key=[[arr valueForKey:@"1"]valueForKey:@"szMobileKey"];
            [[GlobalInstances sharedInstance]saveValueToUserDefaults:key forKey:@"MobileKey"];
            
            [self merchantid:key];
            
        }
        else
        {
            [GlobalInstances showAlertMessage:response withMessage:message];
        }
     }
    else if ([service isEqualToString:@"merchantId"])
    {
        NSDictionary* json_string= [[[[dict objectForKey:@"SOAP-ENV:Envelope"] objectForKey:@"SOAP-ENV:Body"] objectForKey:@"ns1:get_merchant_detail_by_mobile_keyResponse"]objectForKey:@"return"] ;
        NSString *str=[json_string valueForKey:@"text"];
        NSDictionary *arr =
        [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding:NSISOLatin1StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: nil];
        NSString *response=[[arr valueForKey:@"site_response"]valueForKey:@"response"];
 
        if([response isEqualToString:@"SUCCESS"])
        {
            NSArray *merchantdetail=[arr objectForKey:@"merchant_detail"];
            NSString *merchantId=[[merchantdetail objectAtIndex:0]objectForKey:@"id"];
            [[GlobalInstances sharedInstance]saveValueToUserDefaults:merchantId forKey:@"merchant_Id"];
            
            MainViewController_iPhone*main=[[MainViewController_iPhone alloc]initWithNibName:[GlobalInstances xibNameForName:@"MainViewController"] bundle:nil];
            [self.navigationController pushViewController:main animated:YES];
        }
        else
        {
            NSString *message=[[arr valueForKey:@"site_message"]valueForKey:@"message"];
            [GlobalInstances showAlertMessage:response withMessage:message];
        }
    }
    else if ([service isEqualToString:@"forgetPassword"])
    {
        NSDictionary* json_string= [[[[dict objectForKey:@"SOAP-ENV:Envelope"] objectForKey:@"SOAP-ENV:Body"] objectForKey:@"ns1:merchant_reset_passwordResponse"]objectForKey:@"return"] ;
        NSString *str=[json_string valueForKey:@"text"];
        NSDictionary *arr =
        [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding:NSISOLatin1StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: nil];
        NSString *response=[[arr valueForKey:@"site_response"]valueForKey:@"response"];
        NSString *message=[[arr valueForKey:@"site_message"]valueForKey:@"message"];

        if([response isEqualToString:@"SUCCESS"])
        {
            if([message isEqualToString:@"Your Password has been successfully sent to your mail"])
            {
                [GlobalInstances showAlertMessage:response withMessage:@"Your Password has been successfully sent."];
            }
        }
        else
            [GlobalInstances showAlertMessage:response withMessage:message];
    }
}

-(IBAction)forgetPassword:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter Email Address." message:nil delegate:self cancelButtonTitle:@"Done" otherButtonTitles:@"Cancel",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
    alert.delegate=self;
    alert.tag=11;
    alert=nil;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if(alertView.tag==11)
    {
        if([title isEqualToString:@"Done"])
        {
            NSString *str=[alertView textFieldAtIndex:0].text;
            [self forgetPassword_webservice:str];
        }
    }
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
