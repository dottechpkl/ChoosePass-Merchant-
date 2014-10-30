//
//  PayoutViewController_iPhone.h
//  ChoosePass
//
//  Created by Dottechnologies on 7/22/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface PayoutViewController_iPhone : UIViewController
{
    IBOutlet UITextField *bankName_txtfield,*accountNumber_txtfield, *routingNumber_txtfield;
    IBOutlet UILabel *nextPayout, *accountOwned,*subscribers, *passesSold, *averageAddedSales, *mostPopularPass,*topLabel;
    IBOutlet UILabel *nextPayout_lbl, *accountOwned_lbl,*subscribers_lbl, *passesSold_lbl, *averageAddedSales_lbl, *mostPopularPass_lbl;
    ASIFormDataRequest *request;
}
@property(strong,nonatomic)NSString *merchantId_payout;
-(IBAction)backAction;
-(IBAction)contactTeam:(id)sender;
-(IBAction)btnAction:(id)sender;
-(IBAction)saveAction:(id)sender;
@end
