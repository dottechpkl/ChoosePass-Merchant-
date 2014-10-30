//
//  ShowPassCustomCell.m
//  ChoosePass
//
//  Created by Dottechnologies on 6/4/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import "ShowPassCustomCell.h"

@implementation ShowPassCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)buttonAction:(id)sender
{
    [self.delegate useButtonTappedonCell:self];
}


@end
