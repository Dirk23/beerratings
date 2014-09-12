//
//  HITMasterTableViewCell.h
//  beerratings
//
//  Created by Dirk Hildebrand on 26.08.14.
//  Copyright (c) 2014 Dirk Hildebrand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HITMasterTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *beerName;
@property (strong, nonatomic) IBOutlet UILabel *breweryName;
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UIImageView *beercolor;
@end
