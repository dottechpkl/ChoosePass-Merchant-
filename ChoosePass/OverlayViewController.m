//
//  OverlayViewController.m
//  TableView
//
//  Created by iPhone SDK Articles on 1/17/09.
//  Copyright www.iPhoneSDKArticles.com 2009. 
//

#import "OverlayViewController.h"
#import "PassShopViewController_iPhone.h"

@implementation OverlayViewController

@synthesize Controller;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	[Controller doneSearching_Clicked:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}




@end
