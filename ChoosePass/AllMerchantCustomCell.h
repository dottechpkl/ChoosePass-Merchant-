//
//  AllMerchantCustomCell.h
//  ChoosePass
//
//  Created by Dottechnologies on 6/10/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MerchantCellDelagate<NSObject>

@optional
-(void)useButtonTapped:(id)sender;
@end
@interface AllMerchantCustomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *merchantName;
@property (strong, nonatomic) IBOutlet UILabel *merchantCompany;
@property (strong, nonatomic) IBOutlet UIImageView *merchantImage;
@property (strong, nonatomic) IBOutlet UIButton *viewPassesBtn;
@property(strong,nonatomic)id<MerchantCellDelagate>delegate;
- (IBAction)viewPassesAction:(id)sender;

@end
