//
//  LocationViewController_iPhone.h
//  ChoosePass
//
//  Created by Dottechnologies on 7/21/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface LocationViewController_iPhone : UIViewController
{
    IBOutlet UITableView *table;
    NSMutableArray *array;
    IBOutlet UILabel *topLabel;
    NSMutableArray *locid,*zipcode,*locnickname;
    NSString *locidstr,*zipcodestr,*locnicknamestr;
    IBOutlet UIButton *locbtn;
    ASIFormDataRequest *request;
}
@property(strong,nonatomic)NSString *merchantId_location;
-(IBAction)addloc:(id)sender;
@end
