//
//  MortgagePopoverViewController.m
//  MortgageCalculator
//
//  Created by Akshay on 5/7/15.
//  Copyright (c) 2015 Akshay. All rights reserved.
//

#import "MortgagePopoverViewController.h"
#import "DBManager.h"
#import "FirstViewController.h"

@interface MortgagePopoverViewController ()
@property (weak, nonatomic) IBOutlet UILabel *property;
@property (weak, nonatomic) IBOutlet UILabel *streetAddress;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *loanAmount;
@property (weak, nonatomic) IBOutlet UILabel *apr;
@property (weak, nonatomic) IBOutlet UILabel *monthlyPayment;
@property (strong, nonatomic) DBManager *dbManager;
@end

@implementation MortgagePopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.property.text = self.propertyString;
    self.streetAddress.text = self.streetAddressString;
    self.streetAddress.sizeToFit;
    self.city.text = self.cityString;
    self.loanAmount.text = self.loanAmountString;
    self.apr.text = self.aprString;
    self.monthlyPayment.text = self.monthlyPaymentString;
}

- (IBAction)delete:(id)sender {
    NSString *deleteQuery = [NSString stringWithFormat:@"delete from mortgageInfo where mortgage_id=%@", self.ID];
    self.dbManager = [[DBManager alloc]initWithDatabaseFilename:@"mortgagedb.sql"];
    [self.dbManager executeQuery:deleteQuery];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate didDeleteMortgageEntryWithAnnotation:self.marker];
}
- (IBAction)streetView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate didSelectStreetViewForCoordinate:self.coordinate];
}

- (IBAction)edit:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate didSelectEditButtonForId:self.ID];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
