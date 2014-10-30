//
//  SecondViewController_iPhone.h
//  ChoosePass
//
//  Created by Dottechnologies on 6/10/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface SecondViewController_iPhone : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *table;
    IBOutlet UIButton *bottomBtn;
    ASIFormDataRequest *request;
    NSMutableArray *userPass_arr;
    IBOutlet UIImageView *backgroundImage;

}
@property(strong,nonatomic)NSMutableArray *arr;
-(IBAction)bottomBtnAction:(id)sender;


@end
