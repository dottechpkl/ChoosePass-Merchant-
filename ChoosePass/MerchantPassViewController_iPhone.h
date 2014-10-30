//
//  MerchantPassViewController_iPhone.h
//  ChoosePass
//
//  Created by Dottechnologies on 6/11/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "AllMerchantCustomCell.h"

@interface MerchantPassViewController_iPhone : UIViewController<UITableViewDataSource,UITableViewDelegate,MerchantCellDelagate>
{
    ASIFormDataRequest *request;
    NSDictionary *responseDictionary,*dictionary_categories;
    IBOutlet UITableView *table;
    IBOutlet UILabel *topLabel;
    NSMutableArray *arr_category;
    IBOutlet UIButton *requestNewPass;
}
@property(strong,nonatomic)NSString *getId;
@property(strong,nonatomic)NSDictionary *getDictionary;
@property(strong,nonatomic)NSString *merchantName;
-(IBAction)backAction:(id)sender;
-(IBAction)requestNewPass:(id)sender;

@end
