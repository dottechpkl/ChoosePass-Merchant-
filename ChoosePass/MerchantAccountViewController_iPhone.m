//
//  MerchantAccountViewController_iPhone.m
//  ChoosePass
//
//  Created by Dottechnologies on 7/8/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import "MerchantAccountViewController_iPhone.h"

#import "NSObject+SBJSON.h"
#import "XMLReader.h"
#import "AppDelegate.h"
#import "NSDataAdditions.h"

@interface MerchantAccountViewController_iPhone ()
{
    BOOL keyboardIsShown;
}
@end

@implementation MerchantAccountViewController_iPhone

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
    businessnameTxtfield.font=[UIFont fontWithName:@"Brisko Sans" size:12];
    firstnameTxtfield.font=[UIFont fontWithName:@"Brisko Sans" size:12];
    lastnameTxtfield.font=[UIFont fontWithName:@"Brisko Sans" size:12];
    companynameTxtfield.font=[UIFont fontWithName:@"Brisko Sans" size:12];
    emailtxtfield.font=[UIFont fontWithName:@"Brisko Sans" size:12];
    phonenoTxtfield.font=[UIFont fontWithName:@"Brisko Sans" size:12];
    websiteTxtfield.font=[UIFont fontWithName:@"Brisko Sans" size:12];
    passTxtfield.font=[UIFont fontWithName:@"Brisko Sans" size:12];
    confirmpasswordTxtfield.font=[UIFont fontWithName:@"Brisko Sans" size:12];
    shortdescTxtfield.font=[UIFont fontWithName:@"Brisko Sans" size:12];
    longdescTxtfield.font=[UIFont fontWithName:@"Brisko Sans" size:12];
    
    shortdescTxtfield.text=@"Short Description";
    longdescTxtfield.text=@"Long Description";
    
    shortdescTxtfield.textColor=[UIColor grayColor];
    longdescTxtfield.textColor=[UIColor grayColor];
    
    merchantImage.image=[UIImage imageNamed:@"frame1.png"];
    buttonImage.titleLabel.font=[UIFont fontWithName:@"Brisko Sans" size:12];
    
    if(IS_IPHONE_5)
        scroll.contentSize=CGSizeMake(320, 538);
    else
        scroll.contentSize=CGSizeMake(320, 510);
    
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
            //NSLog(@"%@",[num  substringToIndex:3]);
            //NSLog(@"%@",[num substringFromIndex:3]);
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

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.textColor == [UIColor lightGrayColor]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }

}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(textView.text.length == 0){
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

-(IBAction)saveAction:(id)sender;
{
    [self saveMerchant];
}

-(void)saveMerchant
{
    if([GlobalInstances checkNetwork]==FALSE)
    {
        UIAlertView *networkAlert = [[UIAlertView alloc]initWithTitle:nil message:@"There was a problem connecting to the server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [networkAlert show];
    }
    else
    {
        [appdelRef showProgress:@"Please wait..."];
        self.view.userInteractionEnabled = NO;
    
        NSString *key=[[GlobalInstances sharedInstance]getValueFromUserDefaults:@"MobileKey"];
        
        NSData *imageData = UIImageJPEGRepresentation(merchantImage.image,0.1);
        NSString *imageDataAsString=[imageData base64Encoding];

        NSDictionary *postDict = [NSDictionary dictionaryWithObjectsAndKeys:key,@"szMobileKey",@"Admin",@"szFlag",businessnameTxtfield.text,@"businessName",firstnameTxtfield.text,@"firstName",lastnameTxtfield.text,@"lastName",companynameTxtfield.text,@"companyName",emailtxtfield.text,@"email",phonenoTxtfield.text,@"phoneNumber",websiteTxtfield.text,@"website",longdescTxtfield.text,@"description",shortdescTxtfield.text,@"shortDescription",passTxtfield.text,@"password",confirmpasswordTxtfield.text,@"cPassword",imageDataAsString,@"merchantImage",nil];
        NSString *jsonString = [postDict JSONRepresentation];
        
        NSString* xml = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><add_edit_merchant  xmlns=\"urn:passwebservices\"><data>%@</data></add_edit_merchant ></soap:Body></soap:Envelope>",jsonString];
        
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
    
    NSDictionary* json_string= [[[[dict objectForKey:@"SOAP-ENV:Envelope"] objectForKey:@"SOAP-ENV:Body"] objectForKey:@"ns1:add_edit_merchantResponse"]objectForKey:@"return"] ;
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
        alert.tag=1;
        alert=nil;

    }
    else
    {
        [GlobalInstances showAlertMessage:response withMessage:message];
    }
}

#pragma mark-----alertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if(alertView.tag==1)
    {
        if([title isEqualToString:@"OK"])
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:UIKeyboardWillShowNotification];
    [[NSNotificationCenter defaultCenter]removeObserver:UIKeyboardWillHideNotification];
}

-(IBAction)buttonImageAction:(id)sender
{
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
    UIImage *im=[self imageWithImage:image scaledToSize:CGSizeMake(100, 100)];
    merchantImage.image=im;

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
}

@end
