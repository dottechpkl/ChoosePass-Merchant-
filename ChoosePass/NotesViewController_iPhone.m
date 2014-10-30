//
//  NotesViewController_iPhone.m
//  ChoosePass
//
//  Created by Dottechnologies on 7/18/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import "NotesViewController_iPhone.h"
#import "AppDelegate.h"
#import "NSObject+SBJSON.h"
#import "XMLReader.h"

@interface NotesViewController_iPhone ()
{
    BOOL isUpdate;
}
@end

@implementation NotesViewController_iPhone
@synthesize merchant_id;

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
    textView_notes.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.userInteractionEnabled = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^
                   {
                       self.view.userInteractionEnabled = NO;
                       isUpdate=false;
                       [self getNotes];
                       dispatch_async(dispatch_get_main_queue(), ^
                                      {
                                          self.view.userInteractionEnabled = YES;
                                      });
                   });
}

#pragma mark -----------textview Delegate
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    BOOL isToolBar = '\0';
    if (textView.textColor == [UIColor lightGrayColor] || [textView.text isEqualToString:@"Add Note"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        }

    isToolBar=TRUE;

    if ([[UIScreen mainScreen] bounds].size.height != 568)
    {
        [textView setFrame:CGRectMake(12,72,296,160)];
    }
    else
    {
        [textView setFrame:CGRectMake(12,72,296,250)];
    }

    if(isToolBar)
    {
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = [NSArray arrayWithObjects:
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                               nil];
        [numberToolbar sizeToFit];
        textView.inputAccessoryView = numberToolbar;
    }
    return YES;
}

-(void)doneWithNumberPad
{
    [textView_notes resignFirstResponder];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView1
{
    if(textView1.text.length == 0)
        {
                textView1.textColor = [UIColor lightGrayColor];
                textView1.text=@"Add Note";
        }

    if ([[UIScreen mainScreen] bounds].size.height != 568)
    {
        [textView_notes setFrame:CGRectMake(12,72,296,300)];
    }
    else
    {
        [textView_notes setFrame:CGRectMake(12,72,296,359)];
    }

        return YES;
}

//-(void) textViewDidChange:(UITextView *)textView
//{
//    if(textView.text.length == 0)
//    {
//        textView.textColor = [UIColor lightGrayColor];
//        textView.text=@"Add Note";
//     //   [textView resignFirstResponder];
//    }
//}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        
    }
    return YES;
}
-(void)getNotes
{
    if([GlobalInstances checkNetwork]==FALSE)
    {
        [GlobalInstances showAlertMessage:nil withMessage:@"There was a problem connecting to the server"];
    }
    else
    {
        [appdelRef showProgress:@"Please wait..."];
        self.view.userInteractionEnabled = NO;
        
        NSString *key=[[GlobalInstances sharedInstance]getValueFromUserDefaults:@"MobileKey"];
        
        NSDictionary *postDict = [NSDictionary dictionaryWithObjectsAndKeys:key,@"mobileKey",@"merchant",@"userType",merchant_id,@"merchantId",nil];
        
        NSString *jsonString = [postDict JSONRepresentation];
        
        NSString* xml = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><get_merchant_note_by_mobile_key xmlns=\"urn:passwebservices\"><data>%@</data></get_merchant_note_by_mobile_key></soap:Body></soap:Envelope>",jsonString];
        
        [self webServiceCallWithHeadder:xml];
    }

}
-(void)saveNote
{
    if([GlobalInstances checkNetwork]==FALSE)
    {
        [GlobalInstances showAlertMessage:nil withMessage:@"There was a problem connecting to the server"];
    }
    else
    {
        [appdelRef showProgress:@"Please wait..."];
        self.view.userInteractionEnabled = NO;
        
        NSString *key=[[GlobalInstances sharedInstance]getValueFromUserDefaults:@"MobileKey"];
        
        NSDictionary *postDict = [NSDictionary dictionaryWithObjectsAndKeys:key,@"mobileKey",textView_notes.text,@"note",@"merchant",@"userType",merchant_id,@"merchantId",nil];
        
        NSString *jsonString = [postDict JSONRepresentation];
        
        NSString* xml = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><add_edit_merchant_note xmlns=\"urn:passwebservices\"><data>%@</data></add_edit_merchant_note></soap:Body></soap:Envelope>",jsonString];
        
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
    
    if(isUpdate)
    {
        NSDictionary *dict = [XMLReader dictionaryForXMLString:request1.responseString error:nil];
        
        NSDictionary* json_string = [[[[dict objectForKey:@"SOAP-ENV:Envelope"] objectForKey:@"SOAP-ENV:Body"] objectForKey:@"ns1:add_edit_merchant_noteResponse"]objectForKey:@"return"];
        NSString *str=[json_string valueForKey:@"text"];
        
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
        NSDictionary *dict = [XMLReader dictionaryForXMLString:request1.responseString error:nil];
        
        NSDictionary* json_string = [[[[dict objectForKey:@"SOAP-ENV:Envelope"] objectForKey:@"SOAP-ENV:Body"] objectForKey:@"ns1:get_merchant_note_by_mobile_keyResponse"]objectForKey:@"return"];
        NSString *str=[json_string valueForKey:@"text"];
        
        NSDictionary *arr =
        [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding:NSISOLatin1StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: nil];
        
        NSString *response=[[arr valueForKey:@"site_response"]valueForKey:@"response"];
        
        if([response isEqualToString:@"SUCCESS"])
        {
            NSArray *arr1 =[arr valueForKey:@"merchant_Note"];
            if([arr1 isKindOfClass:[NSArray class]]==YES)
            {
                if([[arr1 objectAtIndex:0] isEqualToString:@"No Record Found"])
                {
                    textView_notes.text=@"Add Note";
                    textView_notes.textColor=[UIColor lightGrayColor];

                }
            }
            else
            {
                NSString *text_str=[[arr valueForKey:@"merchant_Note"]valueForKey:@"note"];
                if([text_str isEqualToString:@"Add Note"])
                {
                    textView_notes.text=text_str;
                    textView_notes.textColor=[UIColor lightGrayColor];
                }
                else
                {
                    textView_notes.text=text_str;
                    textView_notes.textColor=[UIColor blackColor];

                }
            }
        }
        else
        {
            [GlobalInstances showAlertMessage:response withMessage:@"Please add note."];
            textView_notes.text=@"Add Note";
            textView_notes.textColor=[UIColor lightGrayColor];

        }
    }
}

-(IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}
-(IBAction)saveAction:(id)sender
{
    isUpdate=TRUE;
    [self saveNote];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
