//
//  LocationDetailViewController_iPhone.m
//  ChoosePass
//
//  Created by Dottechnologies on 7/21/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import "LocationDetailViewController_iPhone.h"
#import "NSObject+SBJSON.h"
#import "XMLReader.h"
#import "AppDelegate.h"
#import "NSDataAdditions.h"

@interface LocationDetailViewController_iPhone ()
{
}
@end

@implementation LocationDetailViewController_iPhone
@synthesize passlocid,passzipcode,passlocnickname,update;
@synthesize checkWebservce;
@synthesize merchantId_locationdetail;

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
    
    locnicktext.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    phonetext.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    add1text.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    add2text.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    citytext.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    statetext.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    ziptext.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    pointtext.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    button_image.titleLabel.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    
    if ([update isEqualToString:@"Yes"])
    {
        [self locationdetail:passlocid];
    }
    else
    {
        UIImage *image=[UIImage imageNamed:@"frame1.png"];
        imgProfile.image=image;
        getImage=[self imageWithImage:image scaledToSize:CGSizeMake(150, 150)];
        imageData = UIImageJPEGRepresentation(getImage,0.1);
        imageDataAsString=[imageData base64Encoding];
    }
        // Do any additional setup after loading the view from its nib.
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

-(void)locationdetail:(NSString *)locid
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
        
    NSDictionary *dic1=@{@"mobileKey":mobilekey,@"location_id":locid,@"userType":@"merchant",@"merchantId":merchantId_locationdetail};
    NSString *str=[dic1 JSONRepresentation];
        
    NSString *xml=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><get_location_detail_by_id xmlns=\"urn:passwebservices\"><data>%@</data></get_location_detail_by_id></soap:Body></soap:Envelope>",str];
        
        [self webServiceCallWithHeadder:xml];
    }
}
-(IBAction)save:(id)sender
{
    [appdelRef showProgress:@"Please wait..."];
    self.view.userInteractionEnabled = NO;
    
    for (UITextField *texter in [self.view subviews])
    {
        if ([texter isKindOfClass:[UITextField class]])
        {
            [texter resignFirstResponder];
        }
    }

    NSString *mobilekey=[[GlobalInstances sharedInstance]getValueFromUserDefaults:@"MobileKey"];
    

    if ([update isEqualToString:@"Yes"])
    {
        checkWebservce=@"2";
        dic=@{@"szMobileKey": mobilekey,@"szFlag":@"Merchant",@"szLocationNickName":locnicktext.text,@"szPhoneNumber":phonetext.text,@"szAddress1":add1text.text,@"szAddress2":add2text.text,@"szCity":citytext.text,@"szState":statetext.text,@"szZipCode":ziptext.text,@"szPointContact":pointtext.text,@"szLocationPhoto":imageDataAsString,@"idMerchant":merchantId_locationdetail,@"idLocation":passlocid};
    }
    else
    {
         dic=@{@"szMobileKey": mobilekey,@"szFlag":@"Merchant",@"szLocationNickName":locnicktext.text,@"szPhoneNumber":phonetext.text,@"szAddress1":add1text.text,@"szAddress2":add2text.text,@"szCity":citytext.text,@"szState":statetext.text,@"szZipCode":ziptext.text,@"szPointContact":pointtext.text,@"szLocationPhoto":imageDataAsString,@"idMerchant":merchantId_locationdetail};
    }
    
    NSString *str=[dic JSONRepresentation];
    NSString *xml=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><add_edit_merchant_location xmlns=\"urn:passwebservices\"><data>%@</data></add_edit_merchant_location></soap:Body></soap:Envelope>",str];
    
    [self webServiceCallWithHeadder:xml];

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
    
    if([checkWebservce isEqualToString:@"1"])
    {
        NSDictionary* json_string = [[[[dict objectForKey:@"SOAP-ENV:Envelope"] objectForKey:@"SOAP-ENV:Body"] objectForKey:@"ns1:get_location_detail_by_idResponse"]objectForKey:@"return"];
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
        NSArray *merchantloc=[arr objectForKey:@"merchant_location_detail"];
        
        if ([response isEqualToString:@"SUCCESS"])
        {
            for (NSDictionary *dict in merchantloc)
            {
                locnicktext.text=[dict objectForKey:@"szLocationNickName"];
                add1text.text=[dict objectForKey:@"szAddress1"];
                add2text.text=[dict objectForKey:@"szAddress2"];
                citytext.text=[dict objectForKey:@"szCity"];
                statetext.text=[dict objectForKey:@"szState"];
                ziptext.text=[dict objectForKey:@"szZipCode"];
                pointtext.text=[dict objectForKey:@"szPointContact"];
                strimage=[dict objectForKey:@"szLocationPhoto"];
            }
            imgProfile.image=[UIImage imageWithData:
                              [NSData dataWithContentsOfURL:
                               [NSURL URLWithString:strimage]]];
            getImage=[self imageWithImage:imgProfile.image scaledToSize:CGSizeMake(150, 150)];
            imageData = UIImageJPEGRepresentation(getImage,0.1);
            imageDataAsString=[imageData base64Encoding];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:response message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
            [alert show];
        }

    }
    else
    {
        NSDictionary* json_string = [[[[dict objectForKey:@"SOAP-ENV:Envelope"] objectForKey:@"SOAP-ENV:Body"] objectForKey:@"ns1:add_edit_merchant_locationResponse"]objectForKey:@"return"];
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
        
        if ([response isEqualToString:@"SUCCESS"])
        {
            [GlobalInstances showAlertMessage:response withMessage:message];
        }
        else
        {
            [GlobalInstances showAlertMessage:response withMessage:message];
        }
    }
 
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag==2)
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


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
	CGRect frame=self.view.frame;
    switch (textField.tag)
    {
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        case 5:
            frame.origin.y=-50;
            break;
        case 6:
            frame.origin.y=-100;
            break;
        case 7:
            frame.origin.y=-100;
            break;
        case 8:
            frame.origin.y=-120;
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

-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)btnuploadMathodImage:(id)sender
{
    
    for (UITextField *texter in [self.view subviews])
    {
        if ([texter isKindOfClass:[UITextField class]])
        {
            [texter resignFirstResponder];
        }
    }

    NSString *actionSheetTitle = @"Change Profile Picture"; //Action Sheet Title
    NSString *destructiveTitle = @"Take Photo"; //Action Sheet Button Titles
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
    imgProfile.image=nil;
    [imgProfile setImage:image];
    getImage=[self imageWithImage:image scaledToSize:CGSizeMake(150, 150)];
    imageData = UIImageJPEGRepresentation(getImage,0.1);
    imageDataAsString=[imageData base64Encoding];
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
