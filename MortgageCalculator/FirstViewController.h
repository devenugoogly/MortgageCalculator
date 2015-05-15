//
//  FirstViewController.h
//  MortgageCalculator
//
//  Created by student on 5/7/15.
//  Copyright (c) 2015 sjsu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController : UIViewController<UIPickerViewDelegate, UITextFieldDelegate, UIPickerViewDataSource>{
    NSMutableArray *stateArray;
    UIPickerView *pickerView;
}

@property (strong, nonatomic) IBOutlet UIButton *calculate;
@property (strong, nonatomic) IBOutlet UIButton *save;
@property (strong, nonatomic) IBOutlet UIButton *New;
@property (strong, nonatomic) IBOutlet UITextField *cityTextField;
@property (strong, nonatomic) IBOutlet UILabel *resultLabel;
@property (strong, nonatomic) IBOutlet UITextView *address;
@property (strong, nonatomic) IBOutlet UITextField *zip;
@property (strong, nonatomic) IBOutlet UITextField *loanAmount;
@property (strong, nonatomic) IBOutlet UITextField *downPayment;
@property (strong, nonatomic) IBOutlet UITextField *apr;
@property (strong, nonatomic) IBOutlet UITextField *terms;

@property (strong, nonatomic) IBOutlet UITextField *stateText;

@property (strong, nonatomic) IBOutlet UIButton *propertyTypeBtn;



@property (strong, nonatomic) NSString *propertyTypeText;
@property (strong, nonatomic) NSString *addressText;
@property (strong, nonatomic) NSString *cityText;
@property (strong, nonatomic) NSString *stateText1;
@property (strong, nonatomic) NSString *zipText;
@property (strong, nonatomic) NSString *loanAmountText;
@property (strong, nonatomic) NSString *downPaymentText;
@property (strong, nonatomic) NSString *aprText;
@property (strong, nonatomic) NSString *termsText;
@property (strong, nonatomic) NSString *result;
@property (assign, nonatomic) int ID;


- (IBAction)openActionSheet:(id)sender;


@end

