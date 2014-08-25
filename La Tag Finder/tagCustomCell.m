//
//  tagCustomCell.m
//  LaTag_v2.0
//
//  Created by Apple on 13/03/14.
//  Copyright (c) 2014 Prakash. All rights reserved.
//

#import "tagCustomCell.h"

@implementation tagCustomCell
@synthesize deviceName;
@synthesize deviceImageView;

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

@end
