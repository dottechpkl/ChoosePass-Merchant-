//
//  FeedBackViewController_iPhone.h
//  ChoosePass
//
//  Created by Dottechnologies on 6/5/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface FeedBackViewController_iPhone : UIViewController
{
    ASIFormDataRequest *request;
    IBOutlet UILabel *topLabel;
    IBOutlet UIButton *firstBtn,*secondBtn,*thirdBtn,*fourthBtn,*fifthBtn;
}
@property (strong, nonatomic) IBOutlet UITextField *titleTxtfld;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property(strong,nonatomic)NSString *checkScreen;
- (IBAction)backAction:(id)sender;
- (IBAction)allButtons:(id)sender;
- (IBAction)submitAction:(id)sender;

@end
