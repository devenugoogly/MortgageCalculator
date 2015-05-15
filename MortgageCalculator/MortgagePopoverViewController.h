//
//  MortgagePopoverViewController.h
//  MortgageCalculator
//
//  Created by Akshay on 5/7/15.
//  Copyright (c) 2015 Akshay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "MortgageAnnotation.h"

@protocol MortgagePopoverDelegate <NSObject>
- (void)didDeleteMortgageEntryWithAnnotation:(MortgageAnnotation *)ann;
- (void)didSelectEditButtonForId:(NSString *)ID;
- (void)didSelectStreetViewForCoordinate:(CLLocationCoordinate2D)coordinate;
@end

@interface MortgagePopoverViewController : UIViewController

@property (strong, nonatomic) NSString *propertyString;
@property (strong, nonatomic) NSString *streetAddressString;
@property (strong, nonatomic) NSString *cityString;
@property (strong, nonatomic) NSString *loanAmountString;
@property (strong, nonatomic) NSString *aprString;
@property (strong, nonatomic) NSString *monthlyPaymentString;
@property (strong, nonatomic) NSString *ID;
@property (nonatomic, weak) id<MortgagePopoverDelegate> delegate;
@property (nonatomic, strong) GMSMarker *marker;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end
