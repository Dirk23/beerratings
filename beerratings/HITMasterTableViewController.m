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
#import "HITDetailTableViewController.h"
#import "HITCalculations.h"
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
    [self getBeerList];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated {
    [self getBeerList];
}
-(void)getBeerList{
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
    HITCalculations* calc = [[HITCalculations alloc]init];
    UIColor* bgColor = [calc getColorforEBC:[[[beersArr objectAtIndex:indexPath.row] valueForKey:@"ebc"]longValue]];
    UIColor* inverseColor = [calc inverseColorWithUICollor:bgColor];
    cell.beerName.text = [[beersArr objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.beerName.textColor = inverseColor;
    cell.breweryName.text = [[beersArr objectAtIndex:indexPath.row] valueForKey:@"brewery"];
    cell.breweryName.textColor = inverseColor;
    cell.backgroundColor = bgColor;
     NSDate *date = [[beersArr objectAtIndex:indexPath.row] valueForKey:@"date"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:@"eee dd.MM.yyyy HH:mm:ss"];
    NSString *timeString = [formatter stringFromDate:date];
    cell.date.text = timeString;
    cell.date.textColor = inverseColor;
    [cell setTag:[[[beersArr objectAtIndex:indexPath.row] valueForKey:@"index"]longValue]];
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
        [self getBeerList];

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
    UITableViewCell *cell = sender;
    HITDetailTableViewController* showDetailView = segue.destinationViewController;
    long index = cell.tag;
    showDetailView.index = index;
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
#pragma mark - MaxID
-(long)getMaxID{
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Beer" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    fetchRequest.fetchLimit = 1;
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"index" ascending:NO]];
    NSError* error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    long maxID = [[[fetchedObjects lastObject] valueForKey:@"index"]longValue] + 1;
    return maxID;
}

#pragma mark - Actions
- (IBAction)addBeer:(id)sender {
    NSDate *currentDate = [[NSDate alloc] init];
    long maxID = [self getMaxID];
    NSManagedObject *beer;
    beer = [NSEntityDescription insertNewObjectForEntityForName:@"Beer" inManagedObjectContext:context];
    [beer setValue:[NSNumber numberWithDouble:4.8] forKey:@"abv"];
    [beer setValue:[NSNumber numberWithDouble:2.5] forKey:@"body"];
    [beer setValue:@"John Doo Brew" forKey:@"brewery"];
    [beer setValue:currentDate forKey:@"date"];
    [beer setValue:[NSNumber numberWithLong:20] forKey:@"ibu"];
    [beer setValue:[NSNumber numberWithLong:maxID] forKey:@"index"];
    [beer setValue:[NSNumber numberWithDouble:2.5] forKey:@"look"];
    [beer setValue:@"New Beer" forKey:@"name"];
    [beer setValue:@"" forKey:@"note"];
    [beer setValue:[NSNumber numberWithDouble:2.5] forKey:@"rating"];
    [beer setValue:[NSNumber numberWithDouble:2.5] forKey:@"smell"];
    [beer setValue:[NSNumber numberWithLong:0] forKey:@"styleCategorieIndex"];
    [beer setValue:[NSNumber numberWithLong:0] forKey:@"styleIndex"];
    [beer setValue:[NSNumber numberWithDouble:2.5] forKey:@"taste"];
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    [self getBeerList];
    UITableViewCell* cell = [[UITableViewCell alloc]init];
    [cell setTag:maxID];
    [self performSegueWithIdentifier:@"pushToDetails" sender:cell];
}
@end
