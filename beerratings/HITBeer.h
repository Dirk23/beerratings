//
//  HITBeer.h
//  beerratings
//
//  Created by Dirk Hildebrand on 26.08.14.
//  Copyright (c) 2014 Dirk Hildebrand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HITBeer : NSObject
@property (strong) NSString* name;
@property (strong) NSString* brewery;
@property (assign) double abv;
@property (assign) double body;
@property (strong) NSDate* date;
@property (assign) double ibu;
@property (assign) long index;
@property (assign) double look;
@property (strong) NSString* note;
@property (assign) double rating;
@property (assign) double smell;
@property (assign) long style;
@property (assign) double taste;

+(id) beerName:(NSString*)inName brewery:(NSString*)inBrewery abv:(double)inABV body:(double)inBody date:(NSDate*)inDate ibu:(double)inIBU look:(double)inLook note:(NSString*)inNote rating:(double)inRating smell:(double)inSmell style:(long)inStyle taste:(double)inTaste;
@end
