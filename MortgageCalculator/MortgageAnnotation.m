//
//  MortgageAnnotation.m
//  MortgageCalculator
//
//  Created by Akshay on 5/7/15.
//  Copyright (c) 2015 Akshay. All rights reserved.
//

#import "MortgageAnnotation.h"

@implementation MortgageAnnotation

- (id)initWithLat:(float)latitude andLong:(float)longitude{
    if(self = [super init]){
        self.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    }
    return self;
}

@end
