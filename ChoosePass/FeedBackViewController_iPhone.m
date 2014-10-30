//
//  FeedBackViewController_iPhone.m
//  ChoosePass
//
//  Created by Dottechnologies on 6/5/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import "FeedBackViewController_iPhone.h"
#import "NSObject+SBJSON.h"
#import "XMLReader.h"
#import "AppDelegate.h"

@interface FeedBackViewController_iPhone ()
{
    NSString*placeholderText;
    NSString *rating;
    UIImage *imageUnselected;
    UIImage *imageSelected;
}
@end

@implementation FeedBackViewController_iPhone
@synthesize checkScreen;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    imageSelected=[UIImage imageNamed:@"fedback_active.png"];
    imageUnselected=[UIImage imageNamed:@"feedback_blue.png"];

    if([checkScreen isEqualToString:@"sendFeedback"])
    {
      rating=@"1";
      placeholderText=@"Enter your Feedback";
        for (UIButton* btn in self.view.subviews) {
            if ([btn isKindOfClass:[UIButton class]])
                if(btn.tag==1)
                {
                    [btn setImage:imageSelected forState:UIControlStateSelected];
                    [btn setSelected:YES];
                }
        }
    }
    else
    {
        rating=@"4";
        placeholderText=@"Enter your Ideas";
        for (UIButton* btn in self.view.subviews) {
            if ([btn isKindOfClass:[UIButton class]])
                if(btn.tag==4)
                {
                    [btn setImage:imageSelected forState:UIControlStateSelected];
                    [btn setSelected:YES];
                }
        }
    }
    topLabel.textColor=[UIColor whiteColor];
    topLabel.font=[UIFont fontWithName:@"Brisko Sans" size:16];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)allButtons:(id)sender
{
    [_textView resignFirstResponder];
    if ([sender isSelected])
    {
        [sender setImage:imageUnselected forState:UIControlStateNormal];
        [sender setSelected:NO];
    }
    else
    {
        [sender setImage:imageSelected forState:UIControlStateSelected];
        [sender setSelected:YES];
    }
    
    [self disableAllButtons:YES inView:self.view];
    ((UIButton*)sender).selected = YES;

    switch ([sender tag])
    {
        case 1:
            placeholderText=@"Enter your Feedback";
            rating=@"1";
            break;
        case 2:
            placeholderText=@"Enter your Feedback";
            rating=@"2";
            break;
        case 3:
            placeholderText=@"Enter your Queries";
            rating=@"3";
            break;
        case 4:
            placeholderText=@"Enter your Ideas";
            rating=@"4";
            break;
        case 5:
            placeholderText=@"Enter your Bugs";
            rating=@"5";
            break;
        default:
            break;
    }
    _textView.text=placeholderText;
    _textView.textColor = [UIColor lightGrayColor];
}

//-----Method to disable all buttons
-(void)disableAllButtons:(BOOL)enable inView:(UIView*)view{
    
    for (UIButton* btn in view.subviews) {
        if ([btn isKindOfClass:[UIButton class]])
            btn.selected = !enable;
        
        if (btn.subviews.count > 0)
            [self disableAllButtons:enable inView:btn];
    }
}

#pragma mark -----------textfield Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    [theTextField resignFirstResponder];
    return YES;
}

#pragma mark -----------textview Delegate
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (_textView.textColor == [UIColor lightGrayColor]) {
        _textView.text = @"";
        _textView.textColor = [UIColor blackColor];
    }
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(_textView.text.length == 0){
        _textView.textColor = [UIColor lightGrayColor];
        _textView.text = placeholderText;
        [_textView resignFirstResponder];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if(_textView.text.length == 0)
        {
            _textView.textColor = [UIColor lightGrayColor];
            _textView.text = placeholderText;
            [_textView resignFirstResponder];
        }
        return NO;
    }
    return YES;
}

- (IBAction)submitAction:(id)sender
{
    NSString *rawString = [_textView text];
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    
    NSString *rawString1 = [_titleTxtfld text];
    NSCharacterSet *whitespace1 = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed1 = [rawString1 stringByTrimmingCharactersInSet:whitespace1];

    if([_titleTxtfld.text length]==0 || [trimmed1 length] == 0)
    {
        [GlobalInstances showAlertMessage:nil withMessage:@"Please enter title of the message."];
        return;
    }
    else if([_textView.text isEqualToString:placeholderText] || [_textView.text length]==0 || [trimmed length] == 0)
    {
        [GlobalInstances showAlertMessage:nil withMessage:@"Please enter the message."];
        return;
    }
    else
    {
        if([checkScreen isEqualToString:@"sendFeedback"])
        [self sendFeedBack];
        
        else if([checkScreen isEqualToString:@"requestPass"])
        [self requestPass];
    }
}

-(void)sendFeedBack
{
    if([GlobalInstances checkNetwork]==FALSE)
    {
        [GlobalInstances showAlertMessage:nil withMessage:@"There was a problem connecting to the server"];
    }
    else
    {
        [appdelRef showProgress:@"Please wait.."];
        self.view.userInteractionEnabled = NO;
        
        NSString *key=[[GlobalInstances sharedInstance]getValueFromUserDefaults:@"MobileKey"];
        
        NSDictionary *postDict = [NSDictionary dictionaryWithObjectsAndKeys:key,@"szMobileKey",@"merchant",@"szFlag",rating,@"szRating",_titleTxtfld.text,@"szTitle",_textView.text,@"szMessage", nil];
        
        NSString *jsonString = [postDict JSONRepresentation];

        NSString* xml = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><feedback_app_web_service xmlns=\"urn:passwebservices\"><data>%@</data></feedback_app_web_service></soap:Body></soap:Envelope>",jsonString];
        
        [self webServiceCallWithHeadder:xml];
    }
}

-(void)requestPass
{
    if([GlobalInstances checkNetwork]==FALSE)
    {
      [GlobalInstances showAlertMessage:nil withMessage:@"There was a problem connecting to the server"];
    }
    else
    {
        [appdelRef showProgress:@"Please wait.."];
        self.view.userInteractionEnabled = NO;
        
        NSString *key=[[GlobalInstances sharedInstance]getValueFromUserDefaults:@"MobileKey"];
        
        NSDictionary *postDict = [NSDictionary dictionaryWithObjectsAndKeys:key,@"szMobileKey",rating,@"szRating",_titleTxtfld.text,@"szTitle",_textView.text,@"szMessage", nil];
        
        NSString *jsonString = [postDict JSONRepresentation];
        
        NSString* xml = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><new_pass_request_to_admin xmlns=\"urn:passwebservices\"><data>%@</data></new_pass_request_to_admin></soap:Body></soap:Envelope>",jsonString];
        
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
    NSDictionary *dict = [XMLReader dictionaryForXMLString:request1.responseString error:nil];
    
    NSDictionary *responseDictionary;
    if([checkScreen isEqualToString:@"sendFeedback"])
    {
        NSDictionary* json_string = [[[[dict objectForKey:@"SOAP-ENV:Envelope"] objectForKey:@"SOAP-ENV:Body"] objectForKey:@"ns1:feedback_app_web_serviceResponse"]objectForKey:@"return"];
        NSString *str=[json_string valueForKey:@"text"];
        
        responseDictionary =
        [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding:NSISOLatin1StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: nil];
    }
    else
    {
        NSDictionary* json_string = [[[[dict objectForKey:@"SOAP-ENV:Envelope"] objectForKey:@"SOAP-ENV:Body"] objectForKey:@"ns1:new_pass_request_to_adminResponse"]objectForKey:@"return"];
        NSString *str=[json_string valueForKey:@"text"];
        
        responseDictionary =
        [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding:NSISOLatin1StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: nil];
    }
    NSString *response=[[responseDictionary valueForKey:@"site_response"] valueForKey:@"response"];
    NSString *message=[[responseDictionary valueForKey:@"site_message"] valueForKey:@"message"];
    
    
    if([response isEqualToString:@"SUCCESS"])
    {
        [appdelRef hideProgress];
        self.view.userInteractionEnabled = YES;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:response message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert.delegate=self;
        alert.tag=1;
        alert = nil;

     }
    else
    {
        [appdelRef hideProgress];
        self.view.userInteractionEnabled = YES;
        [GlobalInstances showAlertMessage:response withMessage:message];
    }
}

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

@end
