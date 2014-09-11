//
//  HITAppDelegate.m
//  beerratings
//
//  Created by Dirk Hildebrand on 18.08.14.
//  Copyright (c) 2014 Dirk Hildebrand. All rights reserved.
//

#import "HITAppDelegate.h"
#import <Crashlytics/Crashlytics.h>

@implementation HITAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Crashlytics startWithAPIKey:@"350f5b65ba22ff0376be9ab655dcefc7f64ed8ca"];
    NSManagedObjectContext* context = [self managedObjectContext];
    NSError* error;
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"]) {

        //writing StyleCategories into the Database
        NSMutableDictionary* StyleCategorieDict = [[NSMutableDictionary alloc] init];
        [StyleCategorieDict setObject:@"Light Lager" forKey:@"0"];
        [StyleCategorieDict setObject:@"Pilsner" forKey:@"1"];
        [StyleCategorieDict setObject:@"European Amber Lager" forKey:@"2"];
        [StyleCategorieDict setObject:@"Dark Lager" forKey:@"3"];
        [StyleCategorieDict setObject:@"Bock" forKey:@"4"];
        [StyleCategorieDict setObject:@"Light Hybrid Beer" forKey:@"5"];
        [StyleCategorieDict setObject:@"Amber Hybrid Beer" forKey:@"6"];
        [StyleCategorieDict setObject:@"English Pale Ale" forKey:@"7"];
        [StyleCategorieDict setObject:@"Scottish and Irish Ale" forKey:@"8"];
        [StyleCategorieDict setObject:@"American Ale" forKey:@"9"];
        [StyleCategorieDict setObject:@"English Brown Ale" forKey:@"10"];
        [StyleCategorieDict setObject:@"Porter" forKey:@"11"];
        [StyleCategorieDict setObject:@"Stout" forKey:@"12"];
        [StyleCategorieDict setObject:@"India Pale Ale (IPA)" forKey:@"13"];
        [StyleCategorieDict setObject:@"German Wheat and Rye Beer" forKey:@"14"];
        [StyleCategorieDict setObject:@"Belgian and French Ale" forKey:@"15"];
        [StyleCategorieDict setObject:@"Sour Ale" forKey:@"16"];
        [StyleCategorieDict setObject:@"Belgian Strong Ale" forKey:@"17"];
        [StyleCategorieDict setObject:@"Strong Ale" forKey:@"18"];
        [StyleCategorieDict setObject:@"Fruit Beer" forKey:@"19"];
        [StyleCategorieDict setObject:@"Spice/Herb/Vegetable Beer" forKey:@"20"];
        [StyleCategorieDict setObject:@"Smoke-Flavored/Wood-Aged Beer" forKey:@"21"];
        [StyleCategorieDict setObject:@"Specialty Beer" forKey:@"22"];
        [StyleCategorieDict setObject:@"Traditional Mead" forKey:@"23"];
        [StyleCategorieDict setObject:@"Melomel (Fruit Mead)" forKey:@"24"];
        [StyleCategorieDict setObject:@"Other Mead" forKey:@"25"];
        [StyleCategorieDict setObject:@"Standard Cider and Perry" forKey:@"26"];
        [StyleCategorieDict setObject:@"Specialty Cider and Perry" forKey:@"27"];
        
        for (long x = 0; x < [StyleCategorieDict count]; x++) {
            NSManagedObject* StyleCategorie = [NSEntityDescription insertNewObjectForEntityForName:@"StyleCategories" inManagedObjectContext:context];
            [StyleCategorie setValue:[StyleCategorieDict valueForKey:[NSString stringWithFormat:@"%li",x]] forKey:@"name"];
            [StyleCategorie setValue:[NSNumber numberWithLong:x] forKey:@"index"];
        }
        //wrting the Styles into the Database
        NSMutableArray *stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"Lite American Lager (1A)"];
        [stylesArr addObject:@"Standard American Lager (1B)"];
        [stylesArr addObject:@"Premium American Lager (1C)"];
        [stylesArr addObject:@"Munich Helles (1D)"];
        [stylesArr addObject:@"Dortmunder Export (1E)"];
        int cntr = 0;
        int index = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:0] forKey:@"categorie"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"German Pilsner (2A)"];
        [stylesArr addObject:@"Bohemian Pilsner (2B)"];
        [stylesArr addObject:@"Classic American Pilsner (2C)"];
         cntr = 0;
         for (NSString* object in stylesArr) {
             NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
             [style setValue:object forKey:@"name"];
             [style setValue:[NSNumber numberWithLong:1] forKey:@"categorie"];
             [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
             if (![context save:&error]) {
                 NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
             }
             cntr++;
             index++;
         }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"Vienna Lager (3A)"];
        [stylesArr addObject:@"Oktoberfest (3B)"];
        cntr = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:2] forKey:@"categorie"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"Oktoberfest (4A)"];
        [stylesArr addObject:@"Munich Dunkel (4B)"];
        [stylesArr addObject:@"Schwarzbier (Black Beer) (4C)"];
        cntr = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:3] forKey:@"categorie"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"Maibock/Heller Bock (5A)"];
        [stylesArr addObject:@"Traditional Bock (5B)"];
        [stylesArr addObject:@"Doppelbock (5C)"];
        [stylesArr addObject:@"Eisbock (5D)"];
        cntr = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:4] forKey:@"categorie"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"Cream Ale (6A)"];
        [stylesArr addObject:@"Blonde Ale (6B)"];
        [stylesArr addObject:@"Kölsch (6C)"];
        [stylesArr addObject:@"American Wheat or Rye Beer (6D)"];
        cntr = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:5] forKey:@"categorie"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"Northern German Altbier (7A)"];
        [stylesArr addObject:@"Califorinia Common Beer (7B)"];
        [stylesArr addObject:@"Düsseldorfer Altbier (7A)"];
        cntr = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:6] forKey:@"categorie"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"Standard/Ordinary Bitter (8A)"];
        [stylesArr addObject:@"Special/Best/Premium Bitter (8B)"];
        [stylesArr addObject:@"Extra Special/Strong Bitter (English Pale Ale) (8C)"];
        cntr = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:7] forKey:@"categorie"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"Scottish Light 60/- (9A)"];
        [stylesArr addObject:@"Scottish Heavy 70/- (9B)"];
        [stylesArr addObject:@"Scottish Export 80/- (9C)"];
        [stylesArr addObject:@"Irish Red Ale (9D)"];
        [stylesArr addObject:@"Strong Scotch Ale (9E)"];
        cntr = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:8] forKey:@"categorie"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"American Pale Ale (10A)"];
        [stylesArr addObject:@"American Amber Ale (10B)"];
        [stylesArr addObject:@"American Brown Ale (10C)"];
        cntr = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:9] forKey:@"categorie"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"Mild (11A)"];
        [stylesArr addObject:@"Southern English Brown (11B)"];
        [stylesArr addObject:@"Northern English Brown (11C)"];
        cntr = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:10] forKey:@"categorie"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"Brown Porter (12A)"];
        [stylesArr addObject:@"Robust Porter (12B)"];
        [stylesArr addObject:@"Baltic Porter (12C)"];
        cntr = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:11] forKey:@"categorie"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"Dry Stout (13A)"];
        [stylesArr addObject:@"Sweet Stout (13B)"];
        [stylesArr addObject:@"Oatmeal Stout (13C)"];
        [stylesArr addObject:@"Foreign Extra Stout (13D)"];
        [stylesArr addObject:@"American Stout (13E)"];
        [stylesArr addObject:@"Russian Imperial Stout (13F)"];
        cntr = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:12] forKey:@"categorie"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"English IPA (14A)"];
        [stylesArr addObject:@"American IPA (14B)"];
        [stylesArr addObject:@"Imperial IPA (14C)"];
        cntr = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:13] forKey:@"categorie"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"Weizen/Weissbier (15A)"];
        [stylesArr addObject:@"Dunkelweizen (15B)"];
        [stylesArr addObject:@"Weizenbock (15C)"];
        [stylesArr addObject:@"Roggenbier (German Rye Beer) (15D)"];
        cntr = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:14] forKey:@"categorie"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"Witbier (16A)"];
        [stylesArr addObject:@"Belgian Pale Ale (16B)"];
        [stylesArr addObject:@"Saison (16C)"];
        [stylesArr addObject:@"Bière de Garde (16D)"];
        [stylesArr addObject:@"Belgian Specialty Ale (16E)"];
        cntr = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:15] forKey:@"categorie"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"Berliner Weisse (17A)"];
        [stylesArr addObject:@"Flanders Red Ale (17B)"];
        [stylesArr addObject:@"Flanders Brown Ale/Oud Bruin (17C)"];
        [stylesArr addObject:@"Straight (Unblended) Lambic (17D)"];
        [stylesArr addObject:@"Gueuze (17E)"];
        [stylesArr addObject:@"Fruit Lambic (17F)"];
        cntr = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:16] forKey:@"categorie"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"Belgian Blond Ale (18A)"];
        [stylesArr addObject:@"Belgian Dubbel (18B)"];
        [stylesArr addObject:@"Belgian Tripel (18C)"];
        [stylesArr addObject:@"Belgian Golden Strong Ale (18D)"];
        [stylesArr addObject:@"Belgian Dark Strong Ale (18E)"];
        cntr = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:17] forKey:@"categorie"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"Old Ale (19A)"];
        [stylesArr addObject:@"English Barleywine (19B)"];
        [stylesArr addObject:@"American Barleywine (19C)"];
        cntr = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:18] forKey:@"categorie"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"Fruit Beer (20A)"];
        cntr = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:19] forKey:@"categorie"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"Spice, Herb, or Vegetable Beer (21A)"];
        [stylesArr addObject:@"Christmas/Winter Specialty Spiced Beer (21B)"];
        cntr = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:20] forKey:@"categorie"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"Classic Rauchbier (22A)"];
        [stylesArr addObject:@"Other Smoked Beer (22B)"];
        [stylesArr addObject:@"Wood-Aged Beer (22C)"];
        cntr = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:21] forKey:@"categorie"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
           if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"Specialty Beer (23A)"];
        cntr = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:22] forKey:@"categorie"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"Dry Mead (24A)"];
        [stylesArr addObject:@"Semi-Sweet Mead (24B)"];
        [stylesArr addObject:@"Sweet Mead (24C)"];
        cntr = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:23] forKey:@"categorie"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"Cyser (25A)"];
        [stylesArr addObject:@"Pyment (25B)"];
        [stylesArr addObject:@"Other Fruit Melomel (25C)"];
        cntr = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:24] forKey:@"categorie"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"Metheglin (26A)"];
        [stylesArr addObject:@"Braggot (26B)"];
        [stylesArr addObject:@"Open Category Mead (26C)"];
        cntr = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:25] forKey:@"categorie"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"Common Cider (27A)"];
        [stylesArr addObject:@"English Cider (27B)"];
        [stylesArr addObject:@"French Cider (27C)"];
        [stylesArr addObject:@"Common Perry (27D)"];
        [stylesArr addObject:@"Traditional Perry (27E)"];
        cntr = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
            [style setValue:[NSNumber numberWithLong:26] forKey:@"categorie"];
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = [[NSMutableArray alloc]init];
        [stylesArr addObject:@"New England Cider (28A)"];
        [stylesArr addObject:@"Fruit Cider (28B)"];
        [stylesArr addObject:@"Applewine (28C)"];
        [stylesArr addObject:@"Other Specialty Cider/Perry (28D)"];
        cntr = 0;
        for (NSString* object in stylesArr) {
            NSManagedObject* style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
            [style setValue:object forKey:@"name"];
            [style setValue:[NSNumber numberWithLong:27] forKey:@"categorie"];
            [style setValue:[NSNumber numberWithLong:index] forKey:@"index"];
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            cntr++;
            index++;
        }
        stylesArr = nil;
    }
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"beerratings" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"beerratings.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
