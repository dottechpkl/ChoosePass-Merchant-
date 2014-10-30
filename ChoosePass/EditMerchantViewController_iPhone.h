//
//  EditMerchantViewController_iPhone.h
//  ChoosePass
//
//  Created by Dottechnologies on 7/16/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface EditMerchantViewController_iPhone : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    IBOutlet UITextField *businessnameTxtfield,*firstnameTxtfield,*lastnameTxtfield,*companynameTxtfield,*emailtxtfield,*phonenoTxtfield,*websiteTxtfield,*highlightTextfield;
    IBOutlet UILabel *payoutLabel,*notesLabel,*locationLabel,*passwordLabel,*passesLabel,*consumerFeedbackLabel,*descriptionLabel;
    IBOutlet UIScrollView *scroll;
    IBOutlet UILabel *topLabel,*profileInfoLabel;
    IBOutlet UITextView *shortdescTxtfield,*longdescTxtfield;
    ASIFormDataRequest *request;
    NSString *merchantId;
    IBOutlet UIButton *buttonImage_merchant;
    IBOutlet UIImageView *merchantImage;
    UIImagePickerController *imagePicker;
    NSString *changedPassword;
    IBOutlet UIButton *logOutBtn;

}
@property(strong,nonatomic)NSDictionary *getUserDetail;
-(IBAction)saveAction:(id)sender;
-(IBAction)allbtnsAction:(id)sender;
-(IBAction)editBtnAction:(id)sender;
-(IBAction)merchantImage:(id)sender;
@end
