//
//  GlobalInstances.m
//  InsightMobileApp
//
//  Created by Parkash Chandra on 6/27/13.
//  Copyright (c) 2013 Parkash Chandra. All rights reserved.
//

#import "GlobalInstances.h"
#import "AppDelegate.h"
#import "Reachability.h"

@implementation GlobalInstances
@synthesize userInfo;
//@synthesize fbAccessTokenData;
static GlobalInstances *sharedSettings = nil;


+ (GlobalInstances*)sharedInstance
{
    @synchronized(self)
	{
        if (sharedSettings == nil)
		{
            sharedSettings=[[self alloc]init];
        }
    }
    return sharedSettings;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
	{
        if (sharedSettings == nil)
		{
            sharedSettings = [super allocWithZone:zone];
			
            return sharedSettings;  // assignment and return on first allocation
        }
    }
    return nil; //on subsequent allocation attempts return nil
}

#pragma mark -----------whole app user defaults handling
-(void)saveValueToUserDefaults:(id)value forKey:(NSString*)key
{
    if(![key isMemberOfClass:[NSNull class]])
    {
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];

    }
    else
    {
        NSLog(@"null value passed for user defaults");
    }
}

-(id)getValueFromUserDefaults:(NSString*)key
{
    id saveValue=[[NSUserDefaults standardUserDefaults] valueForKey:key];
    return saveValue;
}

#pragma mark -----------Check Devices
+ (NSString*)xibNameForName:(NSString*)name
{
    if (IS_IPHONE_5)
        return [NSString stringWithFormat:@"%@_iPhone5", name];
    
	return [NSString stringWithFormat:@"%@_iPhone", name];
}

#pragma mark -----------Show Alerts
+ (void)showAlertMessage:(NSString*)title withMessage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	alert = nil;
}

#pragma mark -----------Validate Email
+(BOOL)validateEmail:(NSString*) emailString
{
    NSString *regExPattern = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$";
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
    NSLog(@"%lu", (unsigned long)regExMatches);
    if (regExMatches == 0)
    {
        return NO;
    }
    else
        return YES;
}

#pragma mark -----------formatting WS parameter list
- (NSData*)encodeDictionary:(NSDictionary*)dictionary {
    NSMutableArray *parts = [[NSMutableArray alloc] init];
    for (NSString *key in dictionary)
    {
        NSString *encodedValue = [[dictionary objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
        [parts addObject:part];
    }
    NSString *encodedDictionary = [parts componentsJoinedByString:@"&"];
    return [encodedDictionary dataUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark -----------reachability
+(BOOL)checkNetwork
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus == NotReachable)
    {
        UIAlertView *networkAlert = [[UIAlertView alloc]initWithTitle:nil message:@"There was a problem connecting to the server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [networkAlert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
        return FALSE;
    }
    else
        return TRUE;
}

#pragma mark -----------database handling
//+(sqlite3 *)checkAndCreateDatabase
//{
//    sqlite3 *refToDb;
//    NSString *databasePath;
//    NSString *databaseName=@"DBRentSpekMobileApp.sqlite";
//    NSArray *docPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    NSString *docDirectory=[docPaths objectAtIndex:0];
//    databasePath=[docDirectory stringByAppendingPathComponent:databaseName];
//    NSFileManager *file=[NSFileManager defaultManager];
//    BOOL success;
//    success=[file fileExistsAtPath: databasePath];
//    if (success)
//    {
//        if (sqlite3_open([databasePath UTF8String], &refToDb)!=SQLITE_OK)
//            
//        {
//            NSLog(@"Database opened1");
//        }
//        return refToDb;
//    }
//    NSString *databasePathFromApp=[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:databaseName];
//    [file copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
//    
//    if (sqlite3_open([databasePath UTF8String], &refToDb)!=SQLITE_OK)
//        
//    {
//        NSLog(@"Database opened2");
//    }
//    return refToDb;
//}


//-(cllo)
//{
//    locationManager = [[CLLocationManager alloc] init];
//    locationManager.delegate = self;
//    locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
//    locationManager.distanceFilter = kCLDistanceFilterNone;
//    [locationManager startUpdatingLocation];
//    CLLocation *location = [locationManager location];
//    coordinate = [location coordinate];
//    latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
//    longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
//    NSLog(@"dLatitude : %@", latitude);
//    NSLog(@"dLongitude : %@",longitude);
//
//}

//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
//    
//    NSString *latitude = [[NSString alloc] initWithFormat:@"%f", newLocation.coordinate.latitude] ;
//    NSString *longitude = [[NSString alloc] initWithFormat:@"%f", newLocation.coordinate.longitude];
//    
//    //    [[GlobalInstances sharedInstance]setValue:latitude forKey:@"Latitude"];
//    //    [[GlobalInstances sharedInstance]setValue:longitude forKey:@"Longitude"];
//    [manager stopUpdatingLocation];
//}

//-(BOOL)checkNetworkAccess
//{
//Reachability *reachability = [Reachability reachabilityForInternetConnection];
//NetworkStatus internetStatus = [reachability currentReachabilityStatus];
//if (internetStatus != NotReachable || internetStatus==ReachableViaWiFi ||internetStatus== ReachableViaWWAN) {
//    return YES;
//}
//else {
//    return NO;
//}
//}
//


#pragma mark ============facebook login=======================

//-(NSString*)checkforFacebookLogin
//{
//    // Whenever a person opens the app, check for a cached session
//    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
//        NSLog(@"Found a cached session");
//        // If there's one, just open the session silently, without showing the user the login UI
//        [FBSession openActiveSessionWithReadPermissions:@[@"basic_info"]
//                                           allowLoginUI:NO
//                                      completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
//                                          
//                                          [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error)
//                                           {
//                                               if (!error)
//                                               {
//                                                   
//                                                   NSLog(@"............. user info ........%@",user);
//                                                   [self setUserInfo:userInfo];
//                                               }
//                                           }];
//                                          // Handler for session state changes
//                                          // This method will be called EACH time the session state changes,
//                                          // also for intermediate states and NOT just when the session open
//                                          [self sessionStateChanged:session state:state error:error];
//                                      }];
//        
//        // If there's no cached session, we will show a login button
//        return @"Logout";
//        
//    } else {
//        //        UIButton *loginButton = [self.customLoginViewController loginButton];
//        //        [loginButton setTitle:@"Log in with Facebook" forState:UIControlStateNormal];
//        
//        return @"Log in with Facebook";
//    }
//    return nil;
//}

// This method will handle ALL the session state changes in the app




@end
