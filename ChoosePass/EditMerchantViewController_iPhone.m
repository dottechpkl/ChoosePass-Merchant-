//
//  EditMerchantViewController_iPhone.m
//  ChoosePass
//
//  Created by Dottechnologies on 7/16/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import "EditMerchantViewController_iPhone.h"
#import "NSObject+SBJSON.h"
#import "XMLReader.h"
#import "AppDelegate.h"
#import "MyPassesViewController_iPhone.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSDataAdditions.h"
#import "NotesViewController_iPhone.h"
#import "FeedBackViewController_iPhone.h"
#import "LocationViewController_iPhone.h"
#import "InfoViewController_iPhone.h"
#import "PayoutViewController_iPhone.h"

@interface EditMerchantViewController_iPhone ()
{
    BOOL keyboardIsShown;
    NSString  *Webservice;
    BOOL checkStatus;
}
@end

@implementation EditMerchantViewController_iPhone
@synthesize getUserDetail;

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
    topLabel.font=[UIFont fontWithName:@"Brisko Sans" size:18];
    businessnameTxtfield.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    firstnameTxtfield.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    lastnameTxtfield.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    companynameTxtfield.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    emailtxtfield.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    phonenoTxtfield.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    websiteTxtfield.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    shortdescTxtfield.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    longdescTxtfield.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    logOutBtn.titleLabel.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    highlightTextfield.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    
     payoutLabel.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    notesLabel.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    locationLabel.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    passwordLabel.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    passesLabel.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    consumerFeedbackLabel.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    descriptionLabel.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    profileInfoLabel.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    buttonImage_merchant.titleLabel.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    
    shortdescTxtfield.editable=NO;
    longdescTxtfield.editable=NO;
    buttonImage_merchant.userInteractionEnabled=NO;
    
    for (UITextField *texter in [scroll subviews])
    {
        if ([texter isKindOfClass:[UITextField class]])
        {
            texter.userInteractionEnabled=NO;
        }
    }
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
    keyboardIsShown = NO;

    if(IS_IPHONE_5)
        scroll.contentSize=CGSizeMake(320, 804);
    else
        scroll.contentSize=CGSizeMake(320, 804);

    [self getDetails];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

#pragma mark Web Service for get User Detail
-(void)getDetails
{
    if([GlobalInstances checkNetwork]==FALSE)
    {
        [GlobalInstances showAlertMessage:nil withMessage:@"There was a problem connecting to the server"];
    }
    else
    {
        [appdelRef showProgress:@"Please wait..."];
        self.view.userInteractionEnabled = NO;
        Webservice=@"getDetails";
        
        NSString *merchid=[[GlobalInstances sharedInstance]getValueFromUserDefaults:@"MobileKey"];
        
        NSDictionary *merchdic=@{@"szMobileKey": merchid};
        
        NSString *post=[merchdic JSONRepresentation];
        
        NSString *xml=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><get_merchant_detail_by_mobile_key xmlns=\"urn:passwebservices\"><data>%@</data></get_merchant_detail_by_mobile_key></soap:Body></soap:Envelope>",post];
        
        [self webServiceCallWithHeadder:xml];

    }

}

#pragma mark Web Service for Update User Detail
-(void)updateDetails
{
    if([GlobalInstances checkNetwork]==FALSE)
    {
        [GlobalInstances showAlertMessage:nil withMessage:@"There was a problem connecting to the server"];
    }
    else
    {
        [appdelRef showProgress:@"Please wait..."];
        self.view.userInteractionEnabled = NO;
        Webservice=@"updateDetails";
        NSString *key=[[GlobalInstances sharedInstance]getValueFromUserDefaults:@"MobileKey"];
        
        NSData *imageData = UIImageJPEGRepresentation(merchantImage.image,0.1);
        NSString *imageDataAsString=[imageData base64Encoding];
        
        if([shortdescTxtfield.text isEqualToString:@"Short Description"])
            shortdescTxtfield.text=@"";
        
        if([longdescTxtfield.text isEqualToString:@"Long Description"])
            longdescTxtfield.text=@"";

        
        NSDictionary *dic=@{@"szMobileKey": key,@"firstName":firstnameTxtfield.text ,@"lastName":lastnameTxtfield.text,@"description":longdescTxtfield.text,@"shortDescription":shortdescTxtfield.text,@"companyName":companynameTxtfield.text,@"phoneNumber":phonenoTxtfield.text,@"email":emailtxtfield.text,@"szFlag":@"Merchant",@"website":websiteTxtfield.text,@"idMerchant":merchantId,@"businessName":businessnameTxtfield.text,@"merchantImage":imageDataAsString,@"szHighlight":highlightTextfield.text};
    
        NSString *jsonString = [dic JSONRepresentation];
        
        NSString *editMerchant=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><add_edit_merchant  xmlns=\"urn:passwebservices\"><data>%@</data></add_edit_merchant ></soap:Body></soap:Envelope>",jsonString];
        
        [self webServiceCallWithHeadder:editMerchant];
    }
}

-(void)changePassword
{
    if([GlobalInstances checkNetwork]==FALSE)
    {
        [GlobalInstances showAlertMessage:nil withMessage:@"There was a problem connecting to the server"];
    }
    else
    {
        [appdelRef showProgress:@"Please wait..."];
        self.view.userInteractionEnabled = NO;
        Webservice=@"changePassword";

        NSString *key=[[GlobalInstances sharedInstance]getValueFromUserDefaults:@"MobileKey"];
  
        NSDictionary *postDict = [NSDictionary dictionaryWithObjectsAndKeys:key,@"mobileKey",changedPassword,@"password",changedPassword,@"cPassword",@"merchant",@"type",nil];
        NSString *jsonString = [postDict JSONRepresentation];
        
        NSString* xml = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><change_password xmlns=\"urn:passwebservices\"><data>%@</data></change_password></soap:Body></soap:Envelope>",jsonString];
        
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
    if([Webservice isEqualToString:@"updateDetails"])
    {
        NSDictionary *dict = [XMLReader dictionaryForXMLString:request1.responseString error:nil];
        NSDictionary* json_string = [[[[dict objectForKey:@"SOAP-ENV:Envelope"] objectForKey:@"SOAP-ENV:Body"] objectForKey:@"ns1:add_edit_merchantResponse"]objectForKey:@"return"];
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
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:response message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            alert.delegate=self;
            alert.tag=123;
            alert=nil;

        }
        else
        {
            [GlobalInstances showAlertMessage:response withMessage:message];
        }
    }
    else if([Webservice isEqualToString:@"changePassword"])
    {
        NSDictionary *dict = [XMLReader dictionaryForXMLString:request1.responseString error:nil];
        
        NSDictionary* json_string = [[[[dict objectForKey:@"SOAP-ENV:Envelope"] objectForKey:@"SOAP-ENV:Body"] objectForKey:@"ns1:change_passwordResponse"]objectForKey:@"return"];
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
    else if([Webservice isEqualToString:@"getDetails"])
    {
        NSDictionary *dict = [XMLReader dictionaryForXMLString:request1.responseString error:nil];
        
        NSDictionary* json_string = [[[[dict objectForKey:@"SOAP-ENV:Envelope"] objectForKey:@"SOAP-ENV:Body"] objectForKey:@"ns1:get_merchant_detail_by_mobile_keyResponse"]objectForKey:@"return"];
        NSString *str=[json_string valueForKey:@"text"];
        
        NSRange r;
        while ((r = [str rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
            str = [str stringByReplacingCharactersInRange:r withString:@""];
        
        NSDictionary *arr =
        [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding:NSISOLatin1StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: nil];
        NSString *response=[[arr valueForKey:@"site_response"]valueForKey:@"response"];
        if([response isEqualToString:@"SUCCESS"])
        {
            NSArray *merchantdetail=[arr objectForKey:@"merchant_detail"];
            
            merchantId=[[merchantdetail objectAtIndex:0] valueForKey:@"id"];
            topLabel.text=[[merchantdetail objectAtIndex:0] valueForKey:@"szFirstName"];
            businessnameTxtfield.text=[[merchantdetail objectAtIndex:0] valueForKey:@"szName"];
            emailtxtfield.text=[[merchantdetail objectAtIndex:0] valueForKey:@"szEmail"];
            phonenoTxtfield.text=[[merchantdetail objectAtIndex:0] valueForKey:@"szMainPhoneNumber"];
            firstnameTxtfield.text=[[merchantdetail objectAtIndex:0] valueForKey:@"szFirstName"];
            lastnameTxtfield.text=[[merchantdetail objectAtIndex:0] valueForKey:@"szLastName"];
            longdescTxtfield.text=[[merchantdetail objectAtIndex:0] valueForKey:@"szDescription"];
            shortdescTxtfield.text=[[merchantdetail objectAtIndex:0] valueForKey:@"szShortDescription"];
            companynameTxtfield.text=[[merchantdetail objectAtIndex:0] valueForKey:@"szCompanyName"];
            highlightTextfield.text=[[merchantdetail objectAtIndex:0]valueForKey:@"szHighlight"];
            websiteTxtfield.text=[[merchantdetail objectAtIndex:0] valueForKey:@"szWebsite"];
            merchantImage.contentMode = UIViewContentModeScaleAspectFit;
            [merchantImage setImageWithURL:[NSURL URLWithString:[[merchantdetail objectAtIndex:0]  valueForKey:@"szUploadFileName"]] placeholderImage:[UIImage imageNamed:@"frame1.png"]];
            
            if([shortdescTxtfield.text isEqualToString:@""] || [shortdescTxtfield.text isEqualToString:@"Short Description"])
            {
                shortdescTxtfield.textColor = [UIColor lightGrayColor];
                shortdescTxtfield.text=@"Short Description";
            }
            
            else
                shortdescTxtfield.textColor = [UIColor blackColor];
            
            if([longdescTxtfield.text isEqualToString:@""] || [longdescTxtfield.text isEqualToString:@"Long Description"])
            {
                longdescTxtfield.textColor = [UIColor lightGrayColor];
                longdescTxtfield.text=@"Long Description";
            }
            else
                longdescTxtfield.textColor = [UIColor blackColor];

        }
        else
        {
            [GlobalInstances showAlertMessage:response withMessage:@"Please try again"];
        }
    }
}

- (void)keyboardWillHide:(NSNotification *)n
{
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // resize the scrollview
    CGRect viewFrame = scroll.frame;
    viewFrame.size.height += (keyboardSize.height - 10);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [scroll setFrame:viewFrame];
    [UIView commitAnimations];
    
    keyboardIsShown = NO;
}

- (void)keyboardWillShow:(NSNotification *)n
{
    if (keyboardIsShown) {
        return;
    }
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect viewFrame = scroll.frame;
    viewFrame.size.height -= (keyboardSize.height - 10);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [scroll setFrame:viewFrame];
    [UIView commitAnimations];
    keyboardIsShown = YES;
}

#pragma mark -----------textfield Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    [theTextField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag==6)
    {
        NSUInteger length = [self getLength:textField.text];
        //NSLog(@"Length  =  %d ",length);
        if(length == 10)
        {
            if(range.length == 0)
                return NO;
        }
        if(length == 3)
        {
            NSString *num = [self formatNumber:textField.text];
            textField.text = [NSString stringWithFormat:@"(%@) ",num];
            
            if(range.length > 0)
            {
                textField.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
            }
            
        }
        else if(length == 6)
        {
            NSString *num = [self formatNumber:textField.text];
             textField.text = [NSString stringWithFormat:@"(%@) %@-",[num  substringToIndex:3],[num substringFromIndex:3]];
            if(range.length > 0)
                textField.text = [NSString stringWithFormat:@"(%@) %@",[num substringToIndex:3],[num substringFromIndex:3]];
            
        }
    }
    return YES;
}
-(NSString*)formatNumber:(NSString*)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    NSLog(@"%@", mobileNumber);
    NSUInteger length = [mobileNumber length];
    if(length > 10)
    {
        mobileNumber = [mobileNumber substringFromIndex: length-10];
        NSLog(@"%@", mobileNumber);
    }
    return mobileNumber;
}
-(NSUInteger)getLength:(NSString*)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    NSUInteger length = [mobileNumber length];
    return length;
}

#pragma mark -----------textview Delegate
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView.textColor == [UIColor lightGrayColor]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(textView.text.length == 0)
    {
        textView.textColor = [UIColor lightGrayColor];
        if (textView.tag==1)
            textView.text=@"Short Description";
        else
            textView.text=@"Long Description";
        
        [textView resignFirstResponder];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if(textView.text.length == 0)
        {
            textView.textColor = [UIColor lightGrayColor];
            if (textView.tag==1)
                textView.text=@"Short Description";
            else
                textView.text=@"Long Description";
            [textView resignFirstResponder];
        }
        return NO;
    }
    return YES;
}

-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)allbtnsAction:(id)sender
{
    switch ([sender tag])
    {
        case 1:
        {
            PayoutViewController_iPhone *payOut=[[PayoutViewController_iPhone alloc]initWithNibName:[GlobalInstances xibNameForName:@"PayoutViewController"] bundle:nil];
            payOut.merchantId_payout=merchantId;
            [self.navigationController pushViewController:payOut animated:YES];
        }
            break;
        case 2:
        {
            NotesViewController_iPhone *myNotes=[[NotesViewController_iPhone alloc]initWithNibName:[GlobalInstances xibNameForName:@"NotesViewController"] bundle:nil];
            myNotes.merchant_id=merchantId;
            [self.navigationController pushViewController:myNotes animated:YES];
        }
            break;
        case 3:
        {
            LocationViewController_iPhone *location=[[LocationViewController_iPhone alloc]initWithNibName:[GlobalInstances xibNameForName:@"LocationViewController"] bundle:nil];
            location.merchantId_location=merchantId;
            [self.navigationController pushViewController:location animated:YES];
        }
            break;
        case 4:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter new Password." message:nil delegate:self cancelButtonTitle:@"Done" otherButtonTitles:@"Cancel",nil];
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alert show];
            alert.delegate=self;
            alert.tag=11;
            alert=nil;
        }

            break;
        case 5:
        {
            MyPassesViewController_iPhone *myPasses=[[MyPassesViewController_iPhone alloc]initWithNibName:[GlobalInstances xibNameForName:@"MyPassesViewController"] bundle:nil];
            myPasses.showScreen=@"MyPasses";
            [self.navigationController pushViewController:myPasses animated:YES];
        }
            break;
        case 6:
        {
            FeedBackViewController_iPhone *feedBack=[[FeedBackViewController_iPhone alloc]initWithNibName:[GlobalInstances xibNameForName:@"FeedBackViewController"] bundle:nil];
            feedBack.checkScreen=@"sendFeedback";
            [self.navigationController pushViewController:feedBack animated:YES];

        }
            break;
        case 7:
        {
            [[GlobalInstances sharedInstance]saveValueToUserDefaults:@"" forKey:@"LoginView"];

            NSMutableArray *viewControllerArray = [self.navigationController.viewControllers mutableCopy];
            [viewControllerArray removeAllObjects];
//            for (int i = 0 ; i <views.count; i++){
//                if ([[views objectAtIndex:i] isKindOfClass:[LoginViewController_iPhone class]])
//                {
//                    [self.navigationController popToViewController:[views objectAtIndex:i] animated:YES];
//                }
             InfoViewController_iPhone *info=[[InfoViewController_iPhone alloc]initWithNibName:[GlobalInstances xibNameForName:@"InfoViewController"] bundle:nil];
            [self.navigationController pushViewController:info animated:YES];
        }
            break;
        default:
            break;
    }

}
-(IBAction)saveAction:(id)sender
{
    for (UITextField *texter in [scroll subviews])
    {
        if ([texter isKindOfClass:[UITextField class]])
        {
            [texter resignFirstResponder];
        }
    }

    if (checkStatus==YES)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Confirm!" message:@"Do you want to save your changes?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        [alert show];
        alert.delegate=self;
        alert.tag=1;
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Edit" message:@"Edit something" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if(alertView.tag==1)
    {
        if([title isEqualToString:@"OK"])
        {
            [self updateDetails];
        }
    }
    else if(alertView.tag==11)
    {
        if([title isEqualToString:@"Done"])
        {
            changedPassword=[alertView textFieldAtIndex:0].text;
            [self changePassword];
        }
    }
    else if(alertView.tag==123)
    {
        if([title isEqualToString:@"OK"])
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

-(IBAction)editBtnAction:(id)sender
{
    for (UITextField *texter in [scroll subviews])
    {
        if ([texter isKindOfClass:[UITextField class]])
        {
            texter.userInteractionEnabled=YES;
            [texter becomeFirstResponder];
        }
    }
    checkStatus=YES;
    shortdescTxtfield.editable=YES;
    longdescTxtfield.editable=YES;
    buttonImage_merchant.userInteractionEnabled=YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:UIKeyboardWillShowNotification];
    [[NSNotificationCenter defaultCenter]removeObserver:UIKeyboardWillHideNotification];
}

-(IBAction)merchantImage:(id)sender
{
    for (UITextField *texter in [scroll subviews])
    {
        if ([texter isKindOfClass:[UITextField class]])
        {
            texter.userInteractionEnabled=NO;
        }
    }

    NSString *actionSheetTitle = @"Change Profile Picture";
    NSString *destructiveTitle = @"Take Photo";
    NSString *other1 = @"Choose Photo";
    NSString *cancelTitle = @"Cancel";
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:actionSheetTitle
                                                             delegate:self
                                                    cancelButtonTitle:cancelTitle destructiveButtonTitle:destructiveTitle otherButtonTitles:other1, nil];
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex== 0)
    {
        [self TakePicture];
        
    }
    else if(buttonIndex == 1)
    {
        [self ChoosePicture];
    }
}
-(void)TakePicture
{
    imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self ;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    else
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}
-(void)ChoosePicture
{
    imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    merchantImage.image=nil;
    UIImage *im=[self imageWithImage:image scaledToSize:CGSizeMake(100, 100)];
    [merchantImage setImage:im];
    
    [picker dismissModalViewControllerAnimated:YES];
    
}
-(UIImage*)imageWithImage:(UIImage*)image
             scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContextWithOptions(newSize, YES, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
