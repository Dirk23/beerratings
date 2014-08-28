//
//  HITMasterTableViewController.h
//  beerratings
//
//  Created by Dirk Hildebrand on 18.08.14.
//  Copyright (c) 2014 Dirk Hildebrand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HITMasterTableViewController : UITableViewController
@property (nonatomic, strong) NSArray *beersArr;
- (IBAction)addBeer:(id)sender;
@end
