//
//  StreetViewController.m
//  MortgageCalculator
//
//  Created by Akshay on 5/9/15.
//  Copyright (c) 2015 Akshay. All rights reserved.
//

#import "StreetViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface StreetViewController ()
@property (nonatomic, strong)GMSPanoramaView *panoView;
@end

@implementation StreetViewController

-(void)loadView{
    self.title = @"Street View";
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    [self.navigationItem setRightBarButtonItem:doneButton];
    
    self.panoView = [[GMSPanoramaView alloc] initWithFrame:CGRectZero];
    self.view = self.panoView;
    [self.panoView moveNearCoordinate:CLLocationCoordinate2DMake(self.coordinate.latitude,self.coordinate.longitude)];
}

- (void)done{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
