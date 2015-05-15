//
//  DataManager.m
//  MortgageCalculator
//
//  Created by student on 5/9/15.
//  Copyright (c) 2015 sjsu. All rights reserved.
//

#import "DataManager.h"

@interface DataManager()


@property (nonatomic, strong) NSString *documentsDirectory;
@end

@implementation DataManager

-(instancetype)initWithDatabaseFilename:(NSArray *)data{
    self = [super init];
    if (self) {
        self.propertyType =  [data objectAtIndex:0];
        self.address=  [data objectAtIndex:1];
        self.city=  [data objectAtIndex:2];
        self.state=  [data objectAtIndex:3];
        self.zip=  [data objectAtIndex:4];
        self.loanAmount=  [data objectAtIndex:5];
        self.downPayment=  [data objectAtIndex:6];
        self.apr=  [data objectAtIndex:7];
        self.terms=  [data objectAtIndex:8];
        self.monthlyPayment=  [data objectAtIndex:9];
        self.longitude=  [data objectAtIndex:10];
        self.latitude=  [data objectAtIndex:11];
    }
    return self;
}

@end
