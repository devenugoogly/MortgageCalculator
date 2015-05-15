//
//  DataMager.h
//  MortgageCalculator
//
//  Created by student on 5/9/15.
//  Copyright (c) 2015 sjsu. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface DataManager : NSObject

@property (nonatomic) NSString *propertyType;
@property (nonatomic) NSString *address;
@property (nonatomic) NSString *city;
@property (nonatomic) NSString *state;
@property (nonatomic) NSString *zip;
@property (nonatomic) NSString *loanAmount;
@property (nonatomic) NSString *downPayment;
@property (nonatomic) NSString *apr;
@property (nonatomic) NSString *terms;
@property (nonatomic) NSString *monthlyPayment;
@property (nonatomic) NSString *longitude;
@property (nonatomic) NSString *latitude;

@property (nonatomic) long long lastInsertedRowID;

@end

