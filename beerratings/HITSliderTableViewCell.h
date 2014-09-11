//
//  HITSliderTableViewCell.h
//  beerratings
//
//  Created by Dirk Hildebrand on 08.09.14.
//  Copyright (c) 2014 Dirk Hildebrand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HITSliderTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UILabel *sliderLabel;

@end
