//
//  HITCalculations.h
//  beerratings
//
//  Created by Dirk Hildebrand on 09.09.14.
//  Copyright (c) 2014 Dirk Hildebrand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HITCalculations : NSObject
-(UIColor*)getColorforEBC:(long)EBC;
-(UIColor*) inverseColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
-(float)roundValue:(float)floatValue step:(double)step;
-(UIColor*) inverseColorWithUICollor:(UIColor*)color;
@end
