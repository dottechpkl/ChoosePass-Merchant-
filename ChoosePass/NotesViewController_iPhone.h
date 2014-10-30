//
//  NotesViewController_iPhone.h
//  ChoosePass
//
//  Created by Dottechnologies on 7/18/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface NotesViewController_iPhone : UIViewController<UITextViewDelegate>
{
    IBOutlet UIButton *backBtn;
    IBOutlet UILabel *topLabel;
    IBOutlet UITextView *textView_notes;
    ASIFormDataRequest *request;
}
@property(strong,nonatomic)NSString *merchant_id;
-(IBAction)backAction:(id)sender;
-(IBAction)saveAction:(id)sender;
@end
