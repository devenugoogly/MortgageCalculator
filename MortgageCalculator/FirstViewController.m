//
//  FirstViewController.m
//  Mortgage Calculator
//
//  Created by student on 4/20/15.
//  Copyright (c) 2015 sjsu. All rights reserved.
//

#import "FirstViewController.h"
#import "DBManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "DataManager.h"

@interface FirstViewController ()
{
    NSArray *_stateData;
    NSString *propertyType;
    NSString *numberString;
    
    
}
@property (nonatomic, strong) DBManager *dbManager;
@property (nonatomic, strong) DataManager *dataManager;
@property (nonatomic, strong) NSArray *arrMortgageInfo;

@end

@implementation FirstViewController

@synthesize cityTextField;
@synthesize resultLabel;
@synthesize address;
@synthesize zip;
@synthesize loanAmount;
@synthesize downPayment;
@synthesize apr;
@synthesize terms;
@synthesize propertyTypeBtn;
@synthesize stateText;
@synthesize calculate;
@synthesize save;
@synthesize New;

- (IBAction)openActionSheet:(id)sender{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select property type" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"House",@"Apartment", nil];
    [actionSheet showInView:self.view];
    
}

- (void)actionSheet: (UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex==0){
        propertyType = @"House";
        [propertyTypeBtn setTitle:@" House" forState:UIControlStateNormal];
    }
    if(buttonIndex==1){
        propertyType = @"Apartment";
        [propertyTypeBtn setTitle:@" Apartment" forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iphone image.png"]];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    
    [pickerView reloadAllComponents];
    [pickerView selectRow:0 inComponent:0 animated:YES];
    
    //initialize DB Manager
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"mortgagedb.sql"];
    //initialize picker data
    
    _stateData = @[@"Alabama",@"Alaska",@"Arizona",@"Arkansas",@"California",@"Colorado",@"Connecticut",@"Delaware",@"Florida",@"Georgia",@"Hawaii",@"Idaho",@"Illinois",@"Indiana",@"Iowa",@"Kansas",@"Kentucky",@"Louisiana",@"Maine",@"Maryland",@"Massachusetts",@"Michigan",@"Minnesota",@"Mississippi",@"Missouri",@"Montana",@"Nebraska",@"Nevada",@"New Hampshire",@"New Jersey",@"New Mexico",@"New York",@"North Carolina",@"North Dakota",@"Ohio",@"Oklahoma",@"Oregon",@"Pennsylvania",@"Rhode Island",@"South Carolina",@"South Dakota",@"Tennessee",@"Texas",@"Utah",@"Vermont",@"Virginia",@"Washington",@"West Virginia",@"Wisconsin",@"Wyoming"];
    
    
    self.address.layer.borderWidth = 1;
    self.address.layer.cornerRadius = 8;
    self.address.layer.masksToBounds=YES;
    self.address.layer.borderColor=[[UIColor whiteColor]CGColor];
    
    self.cityTextField.layer.borderWidth = 1;
    self.cityTextField.layer.cornerRadius = 8;
    self.cityTextField.layer.masksToBounds=YES;
    self.cityTextField.layer.borderColor=[[UIColor whiteColor]CGColor];
    
    self.stateText.layer.borderWidth = 1;
    self.stateText.layer.cornerRadius = 8;
    self.stateText.layer.masksToBounds=YES;
    self.stateText.layer.borderColor=[[UIColor whiteColor]CGColor];
    
    self.zip.layer.borderWidth = 1;
    self.zip.layer.cornerRadius = 8;
    self.zip.layer.masksToBounds=YES;
    self.zip.layer.borderColor=[[UIColor whiteColor]CGColor];
    
    self.loanAmount.layer.borderWidth = 1;
    self.loanAmount.layer.cornerRadius = 8;
    self.loanAmount.layer.masksToBounds=YES;
    self.loanAmount.layer.borderColor=[[UIColor whiteColor]CGColor];
    
    self.downPayment.layer.borderWidth = 1;
    self.downPayment.layer.cornerRadius = 8;
    self.downPayment.layer.masksToBounds=YES;
    self.downPayment.layer.borderColor=[[UIColor whiteColor]CGColor];
    
    self.apr.layer.borderWidth = 1;
    self.apr.layer.cornerRadius = 8;
    self.apr.layer.masksToBounds=YES;
    self.apr.layer.borderColor=[[UIColor whiteColor]CGColor];
    
    self.terms.layer.borderWidth = 1;
    self.terms.layer.cornerRadius = 8;
    self.terms.layer.masksToBounds=YES;
    self.terms.layer.borderColor=[[UIColor whiteColor]CGColor];
    
    
    
    self.propertyTypeBtn.frame = CGRectMake(100, 250, 40, 40); // 40px square
    self.propertyTypeBtn.layer.cornerRadius = 8.0; // half height & width
    self.propertyTypeBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.propertyTypeBtn.backgroundColor = [UIColor whiteColor];
    
    self.calculate.frame = CGRectMake(100, 250, 40, 40); // 40px square
    self.calculate.layer.cornerRadius = 8.0; // half height & width
    
    self.calculate.layer.borderColor = [UIColor blackColor].CGColor;
    self.calculate.backgroundColor = [UIColor whiteColor];
    
    
    self.New.frame = CGRectMake(100, 250, 40, 40); // 40px square
    self.New.layer.cornerRadius = 8.0; // half height & width
    self.New.layer.borderColor = [UIColor blackColor].CGColor;
    self.New.backgroundColor = [UIColor whiteColor];
    
    
    self.save.frame = CGRectMake(100, 250, 40, 40); // 40px square
    self.save.layer.cornerRadius = 8.0; // half height & width
    self.save.layer.borderColor = [UIColor blackColor].CGColor;
    self.save.backgroundColor = [UIColor whiteColor];
    
    stateArray = [[NSMutableArray alloc] init];
    [stateArray addObjectsFromArray:_stateData];
    
//    @property (strong, nonatomic) NSString *propertyTypeText;
//    @property (strong, nonatomic) NSString *addressText;
//    @property (strong, nonatomic) NSString *cityText;
//    @property (strong, nonatomic) NSString *stateText;
//    @property (strong, nonatomic) NSString *zipText;
//    @property (strong, nonatomic) NSString *loanAmountText;
//    @property (strong, nonatomic) NSString *downPaymentText;
//    @property (strong, nonatomic) NSString *aprText;
//    @property (strong, nonatomic) NSString *termsText;
    
    NSLog(@"type %@",_propertyTypeText);
    self.propertyTypeBtn.titleLabel.text = _propertyTypeText;
    self.address.text = _addressText;
    self.cityTextField.text = _cityText;
    self.stateText.text = _stateText1;
    self.zip.text = _zipText;
    self.loanAmount.text = _loanAmountText;
    self.downPayment.text = _downPaymentText;
    self.apr.text = _aprText;
    self.terms.text = _termsText;
    if(self.result != nil){
        self.resultLabel.text =  [NSString stringWithFormat: @"$ %@", self.result];}
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    [self.navigationItem setLeftBarButtonItem:cancelButton];
    
    
    stateText.delegate = self;
}

- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect pickerFrame = CGRectMake(0,44,0,0);
    pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    
    stateText.text = [stateArray objectAtIndex:0];
    stateText.inputView = pickerView;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    stateText.delegate = self;
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [stateText resignFirstResponder];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return [stateArray count];
    
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return [stateArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    stateText.text = [stateArray objectAtIndex:row];
}

-(void) calculateMortgageAmount{
    
    float principalAmount = [loanAmount.text floatValue] - [downPayment.text floatValue];
    float interestRateMonthly = [apr.text floatValue]/(1200);
    int n = [terms.text intValue]*12;
    
    
    double term = pow((double)1+interestRateMonthly, (double)n);
    
    double M = principalAmount*((interestRateMonthly*term)/(term-1));
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    [formatter setRoundingMode: NSNumberFormatterRoundUp];
    
    NSString *finalResult = @"$ ";
    numberString = [formatter stringFromNumber:[NSNumber numberWithFloat:M]];
    
    finalResult = [finalResult stringByAppendingString:numberString];
    
    resultLabel.text = finalResult;
}

- (IBAction)buttonClicked:(UIButton *)sender {
    
    
    if(![self validateForm]){
        
        [self showAlert:@"All Fields are mandatory. !"];
        
    }else{
        
        [self calculateMortgageAmount];
        
        
    }
    
    
}

- (IBAction)save:(id)sender {
    
    if(![self validateForm]){
        
        [self showAlert:@"All fields are mandatory. !"];
        
    }else{
        [self calculateMortgageAmount];
        [self validatAddress];
        
    }
}



-(void) showAlert:(NSString *)errorMessage
{
    UIAlertView *ErrorAlert = [[UIAlertView alloc] initWithTitle:@""
                                                         message: errorMessage
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil, nil];
    [ErrorAlert show];
}


-(bool) validateForm
{
    if(   self.address == nil || [self.address.text isEqualToString:@""]
       || self.zip == nil || [self.zip.text isEqualToString:@""]
       || self.loanAmount == nil || [self.loanAmount.text isEqualToString:@""]
       || self.downPayment == nil || [self.downPayment.text isEqualToString:@""]
       || self.apr == nil || [self.apr.text isEqualToString:@""]
       || self.terms == nil || [self.terms.text isEqualToString:@""]
       || self.cityTextField == nil || [self.cityTextField.text isEqualToString:@""]
       || self.stateText == nil || [self.stateText.text isEqualToString:@""]
       || self.propertyTypeBtn == nil || [self.propertyTypeBtn.titleLabel.text isEqualToString:@" Select"]){
        
        return false;
        
    }else{
        return true;
    }
}


- (IBAction)addNewData:(id)sender {
    self.address.text = @"";
    self.zip.text = @"";
    self.loanAmount.text = @"";
    self.downPayment.text = @"";
    self.apr.text = @"";
    self.terms.text = @"";
    self.cityTextField.text = @"";
    self.resultLabel.text = @"";
    self.stateText.text = @"";
    self.stateText.placeholder = @"Please select state";
    [pickerView reloadAllComponents];
    [pickerView selectRow:0 inComponent:0 animated:YES];
    self.propertyTypeBtn.titleLabel.text=@" Select";
    [address becomeFirstResponder];
}

- (void)resetData {
    self.address.text = @"";
    self.zip.text = @"";
    self.loanAmount.text = @"";
    self.downPayment.text = @"";
    self.apr.text = @"";
    self.terms.text = @"";
    self.cityTextField.text = @"";
    self.resultLabel.text = @"";
    self.stateText.text = @"";
    self.stateText.placeholder = @"Please select state";
    [pickerView reloadAllComponents];
    [pickerView selectRow:0 inComponent:0 animated:YES];
    self.propertyTypeBtn.titleLabel.text=@" Select";
    [address becomeFirstResponder];
}

-(void)validatAddress{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableString* url = [[NSMutableString alloc] init];
    
    NSString* address = self.address.text;
    NSDictionary *parameters = @{@"address":self.address.text };
    NSMutableArray *values = [[NSMutableArray alloc] init];

    [url appendString:[NSMutableString stringWithString:@"https://maps.googleapis.com/maps/api/geocode/json"]];

    
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *query;
        NSLog(@"JSON: %@", responseObject);
        
        NSArray* lat = [responseObject valueForKeyPath:@"results.geometry.location.lat"];
        
        NSArray* lng = [responseObject valueForKeyPath:@"results.geometry.location.lng"];
       

        
        NSLog(@"result is %@ %@",lat[0],lng[0]);
        if(lat[0] != nil && lng[0]!= nil){
            NSLog(@"id %d",self.ID);
            
            if(self.ID == 0){
            query = [NSString stringWithFormat:@"insert or replace into mortgageInfo values((select mortgage_id from mortgageInfo where address='%@' and city='%@' and state='%@' and zip='%@'), '%@', '%@', '%@','%@', '%@', '%@','%@', '%@', '%@', '%@', '%@','%@')",self.address.text, self.cityTextField.text, self.stateText.text, self.zip.text, self.propertyTypeBtn.titleLabel.text, self.address.text, self.cityTextField.text, self.stateText.text, self.zip.text, self.loanAmount.text, self.downPayment.text, self.apr.text, self.terms.text, numberString,lat[0],lng[0]];
            }
            else{
                 query = [NSString stringWithFormat:@"update mortgageInfo set property_type='%@', address='%@', city='%@', state='%@', zip='%@', loan_amount='%@', down_payment='%@', apr='%@', terms='%@', latitude='%@', longitude='%@', mortgage_value='%@' where mortgage_id='%d'",self.propertyTypeBtn.titleLabel.text, self.address.text, self.cityTextField.text, self.stateText.text, self.zip.text, self.loanAmount.text, self.downPayment.text, self.apr.text, self.terms.text, lat[0], lng[0], numberString, self.ID];
            }
            
            NSLog(@"query %@", query);
            // Execute the query.
            [self.dbManager executeQuery:query];
            
            
            // If the query was successfully executed then pop the view controller.
            if (self.dbManager.affectedRows != 0) {
                NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
                
                // Pop the view controller.
                [self.navigationController popViewControllerAnimated:YES];
                
                [self showAlert:@"Data saved successfully.! "];
                [self resetData];
            }
            else{
                NSLog(@"Could not execute the query.");
            }
        }else{
            [self showAlert:@"Invalid address."];
        }

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self showAlert:@"Invalid address."];
    }];
    
//    NSLog(@" values count is %lu",[values count]);
}



@end
