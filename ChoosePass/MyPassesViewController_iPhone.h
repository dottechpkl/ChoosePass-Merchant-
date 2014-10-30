//
//  MyPassesViewController_iPhone.h
//  ChoosePass
//
//  Created by Dottechnologies on 6/27/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface MyPassesViewController_iPhone : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    ASIFormDataRequest *request;
    IBOutlet UILabel *topLabel;
    IBOutlet UITableView *table;
    NSMutableArray *myPasses;
    NSMutableDictionary *boolArray;
}
@property(strong,nonatomic)NSString *showScreen;
-(IBAction)backAction:(id)sender;
@end
