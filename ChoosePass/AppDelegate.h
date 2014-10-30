//
//  AppDelegate.h
//  ChoosePass
//
//  Created by Dottechnologies on 5/29/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIView *ProgressView;
    NSThread *_thread;
    CGRect activityFrame;
    UILabel *progressViewlblText;

}
@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic)UINavigationController *navController;
@property(strong,nonatomic)NSDictionary *myPassesDictionary;
-(void) showProgress:(NSString*)withText;
-(void) hideProgress;
@end
