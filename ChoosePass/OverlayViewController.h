//
//  OverlayViewController.h
//  TableView
//
//  Created by iPhone SDK Articles on 1/17/09.
//  Copyright www.iPhoneSDKArticles.com 2009. 
//

#import <UIKit/UIKit.h>

@class PassShopViewController_iPhone;

@interface OverlayViewController : UIViewController
{
    PassShopViewController_iPhone *Controller;
}

@property (nonatomic, retain) PassShopViewController_iPhone *Controller;

@end
