//
//  HITDetailTableViewController.h
//  beerratings
//
//  Created by Dirk Hildebrand on 08.09.14.
//  Copyright (c) 2014 Dirk Hildebrand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "igViewController.h"

@interface HITDetailTableViewController : UITableViewController <igViewControllerDelegate>
@property (strong, nonatomic) NSArray* stylesArr;
@property (strong, nonatomic) NSArray* styleCategoriesArr;
@property (strong, nonatomic) NSArray* beerDetailArr;
@property (assign) long index;
@property (assign) double sliderLook;
@property (assign) double sliderSmell;
@property (assign) double sliderTaste;
@property (assign) double sliderBody;
@property (assign) long sliderEBC;
@property (strong, nonatomic) UIColor* color;
@property (assign) long selectedCategorie;
@end
