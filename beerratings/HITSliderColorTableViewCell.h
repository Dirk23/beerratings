//
//  HITSliderColorTableViewCell.h
//  beerratings
//
//  Created by Dirk Hildebrand on 09.09.14.
//  Copyright (c) 2014 Dirk Hildebrand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HITSliderColorTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextField *sliderTextfield;
@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UILabel *label;
@end
