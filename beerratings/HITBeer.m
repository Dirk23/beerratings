//
//  HITBeer.m
//  beerratings
//
//  Created by Dirk Hildebrand on 26.08.14.
//  Copyright (c) 2014 Dirk Hildebrand. All rights reserved.
//

#import "HITBeer.h"

@implementation HITBeer

+(id) beerName:(NSString*)inName brewery:(NSString*)inBrewery abv:(double)inABV body:(double)inBody date:(NSDate*)inDate ibu:(double)inIBU look:(double)inLook note:(NSString*)inNote rating:(double)inRating smell:(double)inSmell style:(long)inStyle taste:(double)inTaste {
    
    HITBeer * beer = [[HITBeer alloc] init];
    beer.name       = inName;
    beer.brewery    = inBrewery;
    beer.abv        = inABV;
    beer.body       = inBody;
    beer.date       = inDate;
    beer.ibu        = inIBU;
    beer.look       = inLook;
    beer.note       = inNote;
    beer.rating     = inRating;
    beer.smell      = inSmell;
    beer.style      = inStyle;
    beer.taste      = inTaste;
    return beer;
}
@end
