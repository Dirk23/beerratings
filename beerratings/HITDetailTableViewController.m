//
//  HITDetailTableViewController.m
//  beerratings
//
//  Created by Dirk Hildebrand on 08.09.14.
//  Copyright (c) 2014 Dirk Hildebrand. All rights reserved.
//

#import "HITDetailTableViewController.h"
#import "HITTextfieldTableViewCell.h"
#import "HITTextViewTableViewCell.h"
#import "HITSliderTableViewCell.h"
#import "HITPickerTableViewCell.h"
#import "HITSliderColorTableViewCell.h"
#import "HITStyleTableViewCell.h"
#import "HITAppDelegate.h"
#import "HITCalculations.h"
#import "igViewController.h"

@interface HITDetailTableViewController () <UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, igViewControllerDelegate>
@property (assign) BOOL stylePickerIsShowing;
@property (strong) NSString* styleCategorie;
@property (strong) NSString* styleDetail;
@property (assign) long numberOfSections;
@property (strong, nonatomic) UIBarButtonItem* rightBarButton;
@end

@implementation HITDetailTableViewController
@synthesize stylesArr;
@synthesize styleCategoriesArr;
@synthesize beerDetailArr;
@synthesize index;
@synthesize sliderLook;
@synthesize sliderSmell;
@synthesize sliderTaste;
@synthesize sliderBody;
@synthesize sliderEBC;
@synthesize color;
@synthesize selectedCategorie;
@synthesize stylePickerIsShowing;
@synthesize styleCategorie;
@synthesize styleDetail;
@synthesize numberOfSections;
@synthesize rightBarButton;
HITAppDelegate *appDelegateDetail;
NSManagedObjectContext *contextDetail;

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegateDetail = [[UIApplication sharedApplication] delegate];
    contextDetail = [appDelegateDetail managedObjectContext];
    self.title = NSLocalizedString(@"Beer Details", nil);
    [self loadBeerDetailswithIndex:index];
    [self loadStyleCategories];
    [self loadstyleForCategorieIndex:[[[beerDetailArr objectAtIndex:0] valueForKey:@"styleCategorieIndex"]longValue]];
    sliderLook = [[[beerDetailArr objectAtIndex:0] valueForKey:@"look"]doubleValue];
    sliderSmell = [[[beerDetailArr objectAtIndex:0] valueForKey:@"smell"]doubleValue];
    sliderTaste = [[[beerDetailArr objectAtIndex:0] valueForKey:@"taste"]doubleValue];
    sliderBody = [[[beerDetailArr objectAtIndex:0] valueForKey:@"body"]doubleValue];
    sliderEBC = [[[beerDetailArr objectAtIndex:0] valueForKey:@"ebc"]doubleValue];
    stylePickerIsShowing = NO;
    long categorie = [[[beerDetailArr objectAtIndex:0] valueForKey:@"styleCategorieIndex"]longValue];
    long style = [[[beerDetailArr objectAtIndex:0] valueForKey:@"rowStyleIndex"]longValue];
    styleCategorie = [[styleCategoriesArr objectAtIndex:categorie] valueForKey:@"name"];
    styleDetail = [[stylesArr objectAtIndex:style] valueForKey:@"name"];
    numberOfSections = 11;
}
-(void)loadStyleCategories{
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"StyleCategories" inManagedObjectContext:contextDetail];
    [fetchRequest setEntity:entity];
    NSSortDescriptor* sortByIndex = [[NSSortDescriptor alloc] initWithKey:@"index" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortByIndex]];
    NSError* error;
    NSArray* fetchedObjects = [contextDetail executeFetchRequest:fetchRequest error:&error];
    if (!error) {
        styleCategoriesArr = fetchedObjects;
    } else {
        NSLog(@"%@", [error localizedDescription]);
    }
}
-(void)loadstyleForCategorieIndex:(long)styleCategorieIndex {
    stylesArr = [[NSArray alloc]init];
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Style" inManagedObjectContext:contextDetail];
    [fetchRequest setEntity:entity];
    NSError* error;
    NSPredicate *predicateID = [NSPredicate predicateWithFormat:@"categorie == %li", styleCategorieIndex];
    [fetchRequest setPredicate:predicateID];
    NSArray *fetchedObjects = [contextDetail executeFetchRequest:fetchRequest error:&error];
    if (!error) {
        stylesArr = fetchedObjects;
    } else {
        NSLog(@"%@", [error localizedDescription]);
    }
}
-(void)loadBeerDetailswithIndex:(long)beerIndex {
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Beer" inManagedObjectContext:contextDetail];
    [fetchRequest setEntity:entity];
    NSPredicate *predicateID = [NSPredicate predicateWithFormat:@"index == %li",beerIndex];
    [fetchRequest setPredicate:predicateID];
    NSError* error;
    NSArray *fetchedObjects = [contextDetail executeFetchRequest:fetchRequest error:&error];
    beerDetailArr = fetchedObjects;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 4) {
        if (stylePickerIsShowing) {
            return 2;
        } else {
            return 1;
        }
    } else {
        return 1;
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return NSLocalizedString(@"Beername", nil);
            break;
        case 1:
            return NSLocalizedString(@"Breweryname", nil);
            break;
        case 2:
            return NSLocalizedString(@"IBU", nil);
            break;
        case 3:
            return NSLocalizedString(@"ABV", nil);
            break;
        case 4:
            return NSLocalizedString(@"Style", nil);
            break;
        case 5:
            return NSLocalizedString(@"Look", nil);
            break;
        case 6:
            return NSLocalizedString(@"Smell", nil);
            break;
        case 7:
            return NSLocalizedString(@"Taste", nil);
            break;
        case 8:
            return NSLocalizedString(@"Body", nil);
            break;
        case 9:
            return NSLocalizedString(@"Color", nil);
            break;
        case 10:
            return NSLocalizedString(@"Notes", nil);
            break;
        default:
            return @"";
            break;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 4 && indexPath.row == 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSIndexPath * path1 = [NSIndexPath indexPathForRow:1 inSection:4];
        NSArray *indexArray = [NSArray arrayWithObjects:path1,nil];
        if (stylePickerIsShowing) {
            stylePickerIsShowing = NO;
            [self.tableView beginUpdates];
            [self.tableView deleteRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationRight];
            [self.tableView endUpdates];
        } else {
            stylePickerIsShowing = YES;
            [self.tableView beginUpdates];
            [self.tableView insertRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationLeft];
            [self.tableView endUpdates];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* textfield = @"cellTextfield";
    static NSString* picker = @"cellPicker";
    static NSString* slider = @"cellSlider";
    static NSString* sliderColor = @"cellSliderColor";
    static NSString* textView = @"cellTextView";
    static NSString* style = @"cellStyle";
    
    if (indexPath.section == 0) {
        //Beername
        HITTextfieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:textfield forIndexPath:indexPath];
        [cell.textField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingDidEnd];
        [cell.textField setTag:indexPath.section];
        cell.textField.delegate = self;
        cell.textField.text = [[beerDetailArr lastObject] valueForKey:@"name"];
        return cell;
    }
    if (indexPath.section == 1) {
        //Breweryname
        HITTextfieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:textfield forIndexPath:indexPath];
        [cell.textField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingDidEnd];
        cell.textField.delegate = self;
        [cell.textField setTag:indexPath.section];
        cell.textField.text = [[beerDetailArr lastObject] valueForKey:@"brewery"];

        return cell;
    }
    if (indexPath.section == 2) {
        //IBU
        HITTextfieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:textfield forIndexPath:indexPath];
        [cell.textField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingDidEnd];
        cell.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        cell.textField.delegate = self;
        [cell.textField setTag:indexPath.section];
        cell.textField.text = [NSString stringWithFormat:@"%li", [[[beerDetailArr lastObject] valueForKey:@"ibu"]longValue]];
        return cell;
    }
    if (indexPath.section == 3) {
        //ABV
        HITTextfieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:textfield forIndexPath:indexPath];
        [cell.textField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingDidEnd];
        cell.textField.delegate = self;
        cell.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        [cell.textField setTag:indexPath.section];
        cell.textField.text = [NSString stringWithFormat:@"%.1f", [[[beerDetailArr lastObject] valueForKey:@"abv"]doubleValue]];
        return cell;
    }
    if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            HITStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:style forIndexPath:indexPath];
            cell.styleCategorie.text = styleCategorie;
            cell.styleDetail.text = styleDetail;
            return cell;
        } else {
            HITPickerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:picker forIndexPath:indexPath];
            cell.picker.delegate = self;
            cell.picker.dataSource = self;
            [cell.picker setTag:indexPath.section];
            long categorie = [[[beerDetailArr objectAtIndex:0] valueForKey:@"styleCategorieIndex"]longValue];
            long style = [[[beerDetailArr objectAtIndex:0] valueForKey:@"rowStyleIndex"]longValue];
            [cell.picker selectRow:categorie inComponent:0 animated:YES];
            [cell.picker selectRow:style inComponent:1 animated:YES];
            return cell;
        }
    }
//    if (indexPath.section == 5) {
//        //Style
//        if (stylePickerIsShowing) {
//             HITPickerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:picker forIndexPath:indexPath];
//            cell.picker.delegate = self;
//            cell.picker.dataSource = self;
//            [cell.picker setTag:indexPath.section];
//            long categorie = [[[beerDetailArr objectAtIndex:0] valueForKey:@"styleCategorieIndex"]longValue];
//            long style = [[[beerDetailArr objectAtIndex:0] valueForKey:@"rowStyleIndex"]longValue];
//            [cell.picker selectRow:categorie inComponent:0 animated:YES];
//            [cell.picker selectRow:style inComponent:1 animated:YES];
//            return cell;
//        } else {
//            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:textfield forIndexPath:indexPath];
//            return cell;
//        }
//    }
    if (indexPath.section == 5) {
        //Look
        HITSliderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:slider forIndexPath:indexPath];
        cell.slider.minimumValue = 0;
        cell.slider.maximumValue = 5;
        cell.sliderLabel.text = [NSString stringWithFormat:@"%.1f", sliderLook];
        [cell.slider setTag:indexPath.section];
        [cell.slider addTarget:self action:@selector(lookSave:) forControlEvents:UIControlEventTouchUpInside];
        [cell.slider addTarget:self action:@selector(lookChanged:) forControlEvents:UIControlEventValueChanged];
        cell.slider.value = sliderLook;
        return cell;
    }
    if (indexPath.section == 6) {
        //Smell
        HITSliderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:slider forIndexPath:indexPath];
        cell.slider.minimumValue = 0;
        cell.slider.maximumValue = 5;
        cell.sliderLabel.text = [NSString stringWithFormat:@"%.1f", sliderSmell];
        cell.slider.value = sliderSmell;
        [cell.slider setTag:indexPath.section];
        [cell.slider addTarget:self action:@selector(smellSave:) forControlEvents:UIControlEventTouchUpInside];
        [cell.slider addTarget:self action:@selector(smellChanged:) forControlEvents:UIControlEventValueChanged];

        return cell;
    }
    if (indexPath.section == 7) {
        //Taste
        HITSliderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:slider forIndexPath:indexPath];
        cell.slider.minimumValue = 0;
        cell.slider.maximumValue = 5;
        cell.sliderLabel.text = [NSString stringWithFormat:@"%.1f", sliderTaste];
        cell.slider.value = sliderTaste;
        [cell.slider setTag:indexPath.section];
        [cell.slider addTarget:self action:@selector(tasteSave:) forControlEvents:UIControlEventTouchUpInside];
        [cell.slider addTarget:self action:@selector(tasteChanged:) forControlEvents:UIControlEventValueChanged];
        return cell;
    }
    if (indexPath.section == 8) {
        //Body
        HITSliderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:slider forIndexPath:indexPath];
        cell.slider.minimumValue = 0;
        cell.slider.maximumValue = 5;
        cell.sliderLabel.text = [NSString stringWithFormat:@"%.1f", sliderBody];
        cell.slider.value = sliderBody;
        [cell.slider setTag:indexPath.section];
        [cell.slider addTarget:self action:@selector(bodySave:) forControlEvents:UIControlEventTouchUpInside];
        [cell.slider addTarget:self action:@selector(bodyChanged:) forControlEvents:UIControlEventValueChanged];
        return cell;
    }
    if (indexPath.section == 9) {
        //Color
        HITSliderColorTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:sliderColor forIndexPath:indexPath];
        HITCalculations* calc = [[HITCalculations alloc]init];
        UIColor* bgColor = [calc getColorforEBC:sliderEBC];
//        UIColor* inverseColor = [calc inverseColorWithUICollor:bgColor];
        cell.slider.minimumValue = 0;
        cell.slider.maximumValue = 100;
        cell.sliderTextfield.delegate = self;
        cell.sliderTextfield.text = [NSString stringWithFormat:@"%li", sliderEBC];
//        cell.sliderTextfield.textColor = inverseColor;
//        cell.label.textColor = inverseColor;
        cell.slider.value = sliderEBC;
        cell.beercolor.backgroundColor = bgColor;
        [cell.slider setTag:indexPath.section];
        [cell.slider addTarget:self action:@selector(ebcSliderSave:) forControlEvents:UIControlEventTouchUpInside];
        [cell.slider addTarget:self action:@selector(ebcSliderChanged:) forControlEvents:UIControlEventValueChanged];
        [cell.sliderTextfield addTarget:self action:@selector(ebcTextfield:) forControlEvents:UIControlEventEditingDidEnd];
        return cell;
    }
    if (indexPath.section == 10) {
        //Look
        HITTextViewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:textView forIndexPath:indexPath];
        cell.textView.delegate = self;
        if ([[beerDetailArr lastObject] valueForKey:@"note"] == nil) {
            cell.textView.text = @"";
        } else {
            cell.textView.text = [NSString stringWithFormat:@"%@", [[beerDetailArr lastObject] valueForKey:@"note"]];
        }
        [cell.textView setTag:indexPath.section];
        return cell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:textfield forIndexPath:indexPath];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 4:
            if (indexPath.row == 0) {
                return 55;
                break;
            } else {
                return 132;
                break;
            }
//         case 5:
//            if (stylePickerIsShowing) {
//                return 132;
//                break;
//            } else {
//                return 0;
//                break;
//            }
        case 5:
            return 66;
            break;
        case 6:
            return 66;
            break;
        case 7:
            return 66;
            break;
        case 8:
            return 66;
            break;
        case 9:
            return 88;
            break;
        case 10:
            return 132;
            break;
        default:
            return 44;
            break;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Show/Hide Picker
//- (void)showDatePickerCell {
//    self.datePickerIsShowing = YES;
//    [self.tableView beginUpdates];
//    [self.tableView endUpdates];
//    
//    self.datePicker.hidden = NO;
//    self.datePicker.alpha = 0.0f;
//    
//    [UIView animateWithDuration:0.25 animations:^{
//        self.datePicker.alpha = 1.0f;
//    }];
//}
//
//- (void)hideDatePickerCell {
//    self.datePickerIsShowing = NO;
//    [self.tableView beginUpdates];
//    [self.tableView endUpdates];
//    
//    [UIView animateWithDuration:0.25
//                     animations:^{
//                         self.datePicker.alpha = 0.0f;
//                     }
//                     completion:^(BOOL finished){
//                         self.datePicker.hidden = YES;
//                     }];
//}

#pragma mark - Picker
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* tView = (UILabel*)view;
    if (!tView){
        tView = [[UILabel alloc] init];
        tView.font = [UIFont systemFontOfSize:15.0];
        tView.textAlignment = NSTextAlignmentCenter;
        if (component == 0) {
            tView.text = [[styleCategoriesArr objectAtIndex:row] valueForKey:@"name"];
        } else {
            tView.text = [[stylesArr objectAtIndex:row] valueForKey:@"name"];
        }
    }
    return tView;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    long value = 0;
    if (component == 0) {
        long selectedRow = [[[styleCategoriesArr objectAtIndex:row] valueForKey:@"index"]longValue];
        [self loadstyleForCategorieIndex:selectedRow];
        [pickerView reloadAllComponents];
     }
    if (component == 1) {
        [pickerView reloadAllComponents];
    }
    styleCategorie = [[styleCategoriesArr objectAtIndex:[pickerView selectedRowInComponent:0]] valueForKey:@"name"];
    styleDetail = [[stylesArr objectAtIndex:[pickerView selectedRowInComponent:1]] valueForKey:@"name"];
    value = [[[styleCategoriesArr objectAtIndex:[pickerView selectedRowInComponent:0]] valueForKey:@"index"]longValue];
    [self saveChangesWithValue:[NSNumber numberWithLong:value] Key:@"styleCategorieIndex"];
    value = [[[stylesArr objectAtIndex:[pickerView selectedRowInComponent:1]] valueForKey:@"index"]longValue];
    [self saveChangesWithValue:[NSNumber numberWithLong:value] Key:@"styleIndex"];
    value = [pickerView selectedRowInComponent:1];
    [self saveChangesWithValue:[NSNumber numberWithLong:value] Key:@"rowStyleIndex"];
    [self.tableView reloadData];
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [styleCategoriesArr count];
    } else {
        return [stylesArr count];
    }
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}
#pragma mark - Delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField selectAll:self];
}
#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if ([segue.identifier isEqualToString:@"modalToBarcode"]) {
            ((igViewController*)segue.destinationViewController).delegate = self;
        }
    }
}
#pragma mark - Selectoren
-(void)textFieldChanged:(id)sender{
    UITextField* txt = sender;
    NSString* key = @"";
    switch (txt.tag) {
        case 0:
            key = @"name";
            break;
        case 1:
            key = @"brewery";
            break;
        case 2:
            key = @"ibu";
            break;
        case 3:
            key = @"abv";
            break;
        default:
            break;
    }
    if ([key isEqualToString:@"ibu"]) {
        [self saveChangesWithValue:[NSNumber numberWithLong:[txt.text intValue]] Key:key];
    }
    else if ([key isEqualToString:@"abv"]) {
        NSString* value = txt.text;
        value = [value stringByReplacingOccurrencesOfString:@"," withString:@"."];
        [self saveChangesWithValue:[NSNumber numberWithDouble:[value doubleValue]] Key:key];
    }
    else {
        [self saveChangesWithValue:txt.text Key:key];

    }
    [self.tableView reloadData];
}
-(void)lookChanged:(id)sender {
    HITCalculations* calc = [[HITCalculations alloc] init];
    UISlider* slider = sender;
    sliderLook = [calc roundValue:slider.value step:0.5];
    [self.tableView reloadData];
}
-(void)lookSave:(id)sender {
    HITCalculations* calc = [[HITCalculations alloc] init];
    UISlider* slider = sender;
    [self saveChangesWithValue:[NSNumber numberWithFloat:[calc roundValue:slider.value step:0.5]] Key:@"look"];
    [self.tableView reloadData];
}
-(void)smellChanged:(id)sender {
    HITCalculations* calc = [[HITCalculations alloc] init];
    UISlider* slider = sender;
    sliderSmell = [calc roundValue:slider.value step:0.5];
    [self.tableView reloadData];
}
-(void)smellSave:(id)sender {
    HITCalculations* calc = [[HITCalculations alloc] init];
    UISlider* slider = sender;
    [self saveChangesWithValue:[NSNumber numberWithFloat:[calc roundValue:slider.value step:0.5]] Key:@"smell"];
    [self.tableView reloadData];
}
-(void)tasteChanged:(id)sender {
    HITCalculations* calc = [[HITCalculations alloc] init];
    UISlider* slider = sender;
    sliderTaste = [calc roundValue:slider.value step:0.5];
    [self.tableView reloadData];
}
-(void)tasteSave:(id)sender {
    HITCalculations* calc = [[HITCalculations alloc] init];
    UISlider* slider = sender;
    [self saveChangesWithValue:[NSNumber numberWithFloat:[calc roundValue:slider.value step:0.5]] Key:@"taste"];
    [self.tableView reloadData];
}
-(void)bodyChanged:(id)sender {
    HITCalculations* calc = [[HITCalculations alloc] init];
    UISlider* slider = sender;
    sliderBody = [calc roundValue:slider.value step:0.5];
    [self.tableView reloadData];
}
-(void)bodySave:(id)sender {
    HITCalculations* calc = [[HITCalculations alloc] init];
    UISlider* slider = sender;
    [self saveChangesWithValue:[NSNumber numberWithFloat:[calc roundValue:slider.value step:0.5]] Key:@"body"];
    [self.tableView reloadData];
}
-(void)ebcSliderChanged:(id)sender {
    UISlider* slider = sender;
    sliderEBC = (long)slider.value;
    [self.tableView reloadData];
}
-(void)ebcSliderSave:(id)sender {
    UISlider* slider = sender;
    [self saveChangesWithValue:[NSNumber numberWithLong:(long)slider.value] Key:@"ebc"];
    [self.tableView reloadData];
}
-(void)ebcTextfield:(id)sender {
    UITextField* textfield = sender;
    sliderEBC = [textfield.text intValue];
    [self saveChangesWithValue:[NSNumber numberWithLong:[textfield.text intValue]] Key:@"ebc"];
    [self.tableView reloadData];
}
#pragma mark - Textview
-(void)textViewDidBeginEditing:(UITextView *)textView {
    rightBarButton = self.navigationItem.rightBarButtonItem;
    UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil) style:UIBarButtonItemStyleDone target:self action:@selector(textViewKeyboardDown:)];
    [self.navigationItem setRightBarButtonItem:rightButton];
}
-(void)textViewKeyboardDown:(id)sender {
    self.navigationItem.rightBarButtonItem = rightBarButton;
    UITextView* tView = (UITextView*)[self.view viewWithTag:10];
    [tView endEditing:YES];
}
-(void)textViewDidEndEditing:(UITextView *)textView {
    [self saveChangesWithValue:textView.text Key:@"note"];
}
#pragma mark - Save changes

-(void)saveChangesWithValue:(id)value Key:(id)key{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Beer" inManagedObjectContext:contextDetail]];
    NSError *error = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"index == %li", index];
    [request setPredicate:predicate];
    NSArray *results = [contextDetail executeFetchRequest:request error:&error];
    NSManagedObject* favoritsGrabbed = [results objectAtIndex:0];
    [favoritsGrabbed setValue:value forKey:key];
    if (![contextDetail save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}
#pragma mark - Barcode
-(void)cameraDidFinish:(igViewController *)inController data:(NSString*)code {
    [self dismissViewControllerAnimated:YES completion:^{
        if (code) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Barcode" message:code delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}
#pragma mark - Delegate Methods

@end
