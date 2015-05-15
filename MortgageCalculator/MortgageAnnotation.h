//
//  MortgageAnnotation.h
//  MortgageCalculator
//
//  Created by Akshay on 5/7/15.
//  Copyright (c) 2015 Akshay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MortgageAnnotation : NSObject<MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *tuple;
- (id)initWithLat:(float)latitude andLong:(float)longitude;
@end
