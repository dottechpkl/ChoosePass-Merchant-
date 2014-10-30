//
//  AppDelegate.m
//  ChoosePass
//
//  Created by Dottechnologies on 5/29/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import "AppDelegate.h"
#import "InfoViewController_iPhone.h"
#import "MainViewController_iPhone.h"


@implementation AppDelegate
@synthesize myPassesDictionary;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
    NSString *str=[[GlobalInstances sharedInstance]getValueFromUserDefaults:@"LoginView"];
    if([str isEqualToString:@"DetailSaved"])
    {
        MainViewController_iPhone *mainView=[[MainViewController_iPhone alloc]initWithNibName:[GlobalInstances xibNameForName:@"MainViewController"] bundle:nil];
        _navController = [[UINavigationController alloc] initWithRootViewController:mainView];
    }
    else
    {
        InfoViewController_iPhone *viewController=[[InfoViewController_iPhone alloc]initWithNibName:[GlobalInstances xibNameForName:@"InfoViewController"] bundle:nil];
        _navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    }

    [_navController setNavigationBarHidden:YES animated:NO];
    self.window.rootViewController = _navController;


    ProgressView =  [[UIView alloc] initWithFrame:CGRectMake(110,200,100,100)];//CGRectMake(0, 0, self.window.frame.size.width,  self.window.frame.size.height)];
    ProgressView.backgroundColor=[UIColor blackColor];
    ProgressView.alpha=0.7f;
    ProgressView.layer.cornerRadius=10;
    activityFrame = CGRectMake(10,0,80,80);
    
    UIActivityIndicatorView *activityindicatorView= [[UIActivityIndicatorView alloc ] initWithFrame:activityFrame];
    activityindicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    //activityindicatorView.color = [UIColor whiteColor];
    [activityindicatorView startAnimating];
    [ProgressView addSubview:activityindicatorView];
    ProgressView.hidden=YES;
    
    progressViewlblText=[[UILabel alloc] initWithFrame:CGRectMake(0,100-30,100,30)];
    progressViewlblText.backgroundColor=[UIColor clearColor];
    progressViewlblText.textColor=[UIColor whiteColor];
    progressViewlblText.textAlignment = NSTextAlignmentCenter;
	progressViewlblText.font = [UIFont fontWithName:@"Helvetica" size:12];
    
    [ProgressView addSubview:progressViewlblText ];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window addSubview:ProgressView];
    
    [self.window makeKeyAndVisible];
   
    return YES;
}

-(void) showProgress:(NSString*)withText
{
    progressViewlblText.text=withText;
    [self.window bringSubviewToFront:ProgressView];
    @synchronized(self) {
        if ([[NSThread currentThread] isCancelled]) return;
        
        [_thread cancel]; // Cell! Stop what you were doing!
        _thread = nil;
        
        _thread = [[NSThread alloc] initWithTarget:self selector:@selector(setVisible:) object:@"NO"];
        [_thread start];
    }
}

-(void) setVisible:(NSString*) visibility
{
    BOOL x = [visibility boolValue];
    ProgressView.hidden=x;
    //NSLog(visibility);
}

-(void) hideProgress
{
    @synchronized(self) {
        if ([[NSThread currentThread] isCancelled]) return;
        
        [_thread cancel]; // Cell! Stop what you were doing!
        _thread = nil;
        
        _thread = [[NSThread alloc] initWithTarget:self selector:@selector(setVisible:) object:@"YES"];
        [_thread start];
        
    }
}

-(BOOL)application:(UIApplication *)application
           openURL:(NSURL *)url
 sourceApplication:(NSString *)sourceApplication
        annotation:(id)annotation
{
  return [FBSession.activeSession handleOpenURL:url];}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     [FBSession.activeSession handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [FBSession.activeSession close];
}

@end
