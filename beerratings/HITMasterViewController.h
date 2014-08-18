//
//  HITMasterViewController.h
//  beerratings
//
//  Created by Dirk Hildebrand on 18.08.14.
//  Copyright (c) 2014 Dirk Hildebrand. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HITDetailViewController;

#import <CoreData/CoreData.h>

@interface HITMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) HITDetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
