//
//  CustomInfoWindow.h
//  MortgageCalculator
//
//  Created by student on 5/10/15.
//  Copyright (c) 2015 sjsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomInfoWindow : UIView
@property (strong) IBOutlet UIButton *editButton;
@property (strong) IBOutlet UIButton *deleteButton;
@property (strong) IBOutlet UIButton *streetViewButton;

@property (strong) IBOutlet UILabel *addressLabel;
@property (strong) IBOutlet UILabel *cityLabel;
@property (strong) IBOutlet UILabel *loanAmountLable;


@end
