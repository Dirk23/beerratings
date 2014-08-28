//
//  HITMasterTableViewController.m
//  beerratings
//
//  Created by Dirk Hildebrand on 18.08.14.
//  Copyright (c) 2014 Dirk Hildebrand. All rights reserved.
//

#import "HITMasterTableViewController.h"
#import "HITAppDelegate.h"
#import "HITMasterTableViewCell.h"
#import "HITBeer.h"

@interface HITMasterTableViewController () <UIGestureRecognizerDelegate, UITableViewDelegate>

@end

@implementation HITMasterTableViewController
@synthesize beersArr;
HITAppDelegate *appDelegate;
NSManagedObjectContext *context;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = [[UIApplication sharedApplication] delegate];
    context = [appDelegate managedObjectContext];
    UILongPressGestureRecognizer *longpressed = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongpress:)];
    longpressed.minimumPressDuration = 0.75; //seconds
    longpressed.delegate = self;
    [self.tableView addGestureRecognizer:longpressed];
    self.title = NSLocalizedString(@"Beer Ratings", nil);
    [self dings];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)dings{
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Beer" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError* error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    beersArr = fetchedObjects;
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [beersArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HITMasterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellMaster" forIndexPath:indexPath];
    cell.beerName.text = [[beersArr objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.breweryName.text = [[beersArr objectAtIndex:indexPath.row] valueForKey:@"brewery"];
    NSDate *date = [[beersArr objectAtIndex:indexPath.row] valueForKey:@"date"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:@"eee dd.MM.yyyy HH:mm:ss"];
    NSString *timeString = [formatter stringFromDate:date];
    cell.date.text = timeString;
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source

        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        [context deleteObject:[beersArr objectAtIndex:indexPath.row]];
        NSError * error = nil;
        if (![context save:&error])
        {
            NSLog(@"Error ! %@", error);
        }
        [self dings];

    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self performSegueWithIdentifier:@"pushToDetail" sender:self];
}

#pragma mark - LongPress handle
-(void)handleLongpress:(UILongPressGestureRecognizer*)gestureRecognizer {
    [[self tableView] setEditing:YES animated:YES];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil) style:UIBarButtonItemStyleDone target:self action:@selector(moveDone)];
    self.navigationItem.rightBarButtonItem = doneButton;
}
-(void)moveDone{
    
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString:NSLocalizedString(@"Done", nil)]) {
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBeer:)];
        [[self tableView] setEditing:NO animated:YES];
        self.navigationItem.rightBarButtonItem = addButton;
    }
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



#pragma mark - Actions
- (IBAction)addBeer:(id)sender {
    NSDate *currentDate = [[NSDate alloc] init];
    NSManagedObject *beer;
    beer = [NSEntityDescription insertNewObjectForEntityForName:@"Beer" inManagedObjectContext:context];
     [beer setValue:@"New Beer" forKey:@"name"];
    [beer setValue:@"John Doo Brew" forKey:@"brewery"];
    [beer setValue:currentDate forKey:@"date"];
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    [self dings];
}
@end


//    for (NSManagedObject* info in fetchedObjects) {
//        HITBeer* beer = [[HITBeer alloc] init];
//        beer.name = [info valueForKey:@"name"];
//        beer.brewery = [info valueForKey:@"brewery"];
//        beer.abv = [[info valueForKey:@"abv"]doubleValue];
//        beer.body = [[info valueForKey:@"body"]doubleValue];
//        beer.date = [info valueForKey:@"date"];
//        beer.ibu = [[info valueForKey:@"ibu"]doubleValue];
//        beer.look = [[info valueForKey:@"look"]doubleValue];
//        beer.note = [info valueForKey:@"note"];
//        beer.rating = [[info valueForKey:@"rating"]doubleValue];
//        beer.smell = [[info valueForKey:@"smell"]doubleValue];
//        beer.style = [[info valueForKey:@"style"]longValue];
//        beer.taste = [[info valueForKey:@"taste"]doubleValue];
//    }

