//
//  HITMasterTableViewCell.m
//  beerratings
//
//  Created by Dirk Hildebrand on 26.08.14.
//  Copyright (c) 2014 Dirk Hildebrand. All rights reserved.
//

#import "HITMasterTableViewCell.h"

@implementation HITMasterTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
