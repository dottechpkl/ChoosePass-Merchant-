//
//  MerchantAccountViewController_iPhone.h
//  ChoosePass
//
//  Created by Dottechnologies on 7/8/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface MerchantAccountViewController_iPhone : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
{
    IBOutlet UITextField *businessnameTxtfield,*firstnameTxtfield,*lastnameTxtfield,*companynameTxtfield,*emailtxtfield,*phonenoTxtfield,*websiteTxtfield,*passTxtfield,*confirmpasswordTxtfield;
    IBOutlet UIScrollView *scroll;
    IBOutlet UILabel *topLabel;
    IBOutlet UITextView *shortdescTxtfield,*longdescTxtfield;
    ASIFormDataRequest *request;
    IBOutlet UIView *editView;
    IBOutlet UIButton *buttonImage;
    IBOutlet UIImageView *merchantImage;
    UIImagePickerController *imagePicker;
}
-(IBAction)back:(id)sender;
-(IBAction)saveAction:(id)sender;
-(IBAction)buttonImageAction:(id)sender;
@end
