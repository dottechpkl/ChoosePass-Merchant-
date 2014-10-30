//
//  ShowPassCustomCell.h
//  ChoosePass
//
//  Created by Dottechnologies on 6/4/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TableCellDelagate<NSObject>

@optional
-(void)useButtonTappedonCell:(id)sender;
@end

@interface ShowPassCustomCell : UITableViewCell
@property(weak,nonatomic)IBOutlet UILabel *labelCell;
@property(weak,nonatomic)IBOutlet UILabel *label2Cell;
@property(weak,nonatomic)IBOutlet UIImageView *imageViewCell;
@property(strong,nonatomic)IBOutlet UIButton *buttonCell;
@property(strong,nonatomic)id<TableCellDelagate>delegate;
-(IBAction)buttonAction:(id)sender;

@end
