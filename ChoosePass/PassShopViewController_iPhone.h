//
//  PassShopViewController_iPhone.h
//  ChoosePass
//
//  Created by Dottechnologies on 6/10/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "AllMerchantCustomCell.h"

@class OverlayViewController;
@interface PassShopViewController_iPhone : UIViewController<MerchantCellDelagate,UITableViewDataSource,UITabBarDelegate,UISearchBarDelegate>
{
    ASIFormDataRequest *request;
    IBOutlet UITableView *table;
    BOOL searching;
    OverlayViewController *ovController;
    BOOL letUserSelectRow;
    NSMutableArray *searchArray;
    UIAlertView *theAlertView;
}
@property(strong,nonatomic)NSDictionary *responseDictionary;
@property (strong, nonatomic) UISearchBar *searchBar;
- (IBAction)backAction:(id)sender;
-(void)doneSearching_Clicked:(id)sender;

@end
