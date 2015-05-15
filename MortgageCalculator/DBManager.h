//
//  DBManager.h
//  Mortgage Calculator
//
//  Created by student on 5/7/15.
//  Copyright (c) 2015 sjsu. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DBManager : NSObject

@property (nonatomic, strong) NSMutableArray *arrColumnNames;

@property (nonatomic) int affectedRows;

@property (nonatomic) long long lastInsertedRowID;

-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename;

-(NSArray *)loadDataFromDB:(NSString *)query;

-(void)executeQuery:(NSString *)query;

@end
