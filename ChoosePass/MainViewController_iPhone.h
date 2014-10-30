//
//  MainViewController_iPhone.h
//  ChoosePass
//
//  Created by Dottechnologies on 5/29/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondViewController_iPhone.h"
#import "CreateNewPassesView.h"

@interface MainViewController_iPhone : UIViewController
{
    IBOutlet UIButton *firstBtn;
    IBOutlet UIButton *secondBtn;
    IBOutlet UIButton *thirdBtn;
    SecondViewController_iPhone *second;
}
- (IBAction)firstBtnAction:(id)sender;
- (IBAction)secondBtnAction:(id)sender;
- (IBAction)thirdBtnAction:(id)sender;
-(void)removeChildVeiwController;

@end
