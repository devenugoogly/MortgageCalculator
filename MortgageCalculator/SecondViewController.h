//
//  SecondViewController.h
//  MortgageCalculator
//
//  Created by student on 5/7/15.
//  Copyright (c) 2015 sjsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "MortgagePopoverViewController.h"
#import "StreetViewController.h"

@interface SecondViewController : UIViewController<GMSMapViewDelegate, UIPopoverPresentationControllerDelegate, MortgagePopoverDelegate>


@end

