//
//  LoginViewController_iPhone.h
//  ChoosePass
//
//  Created by Dottechnologies on 5/29/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface LoginViewController_iPhone : UIViewController<UITextFieldDelegate>
{
    ASIFormDataRequest *request;
    IBOutlet UITextField *emailTxtFld,*passwordTxrfld;
    IBOutlet UILabel *topLabel;
}
-(IBAction)loginAction:(id)sender;
-(IBAction)back:(id)sender;
- (IBAction)chckBoxAction:(id)sender;
-(IBAction)forgetPassword:(id)sender;

@end
