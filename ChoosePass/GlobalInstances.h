//
//  GlobalInstances.h
//  InsightMobileApp
//
//  Created by Parkash Chandra on 6/27/13.
//  Copyright (c) 2013 Parkash Chandra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
#import "sqlite3.h"

#define cell1_color [UIColor colorWithRed:251/255.0 green:236/255.0 blue:231/255.0 alpha:1]

#define cell2_color [UIColor colorWithRed:249/255.0 green:230/255.0 blue:224/255.0 alpha:1]

#define COLOR_ORANGE [UIColor colorWithRed:246/255.0 green:216/255.0 blue:209/255.0 alpha:1]

#define appdelRef (AppDelegate *)[[UIApplication sharedApplication] delegate]

#define urlWebService  @"http://www.chooseyourpass.com/webservice/passwebservices.php"

#define IS_IPHONE_5 ([UIScreen mainScreen].bounds.size.height == 568.0)

@interface GlobalInstances : NSObject
{
    UIView *ProgressView;
    NSThread *_thread;
    UILabel *progressViewlblText;
}
@property (nonatomic,retain)  NSDictionary<FBGraphUser> *userInfo;

+ (GlobalInstances*)sharedInstance ;
+ (id)allocWithZone:(NSZone *)zone;
-(void)saveValueToUserDefaults:(id)value forKey:(NSString*)key;
-(id)getValueFromUserDefaults:(NSString*)key;
+ (NSString*)xibNameForName:(NSString*)name;
+ (void) showAlertMessage:(NSString*)title withMessage:(NSString*)message;
+ (BOOL) validateEmail:(NSString*) emailString;
+(BOOL)checkNetwork;



@end
