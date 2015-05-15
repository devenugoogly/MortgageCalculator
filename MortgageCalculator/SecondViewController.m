//
//  SecondViewController.m
//  MortgageCalculator
//
//  Created by student on 5/7/15.
//  Copyright (c) 2015 sjsu. All rights reserved.
//

#import "SecondViewController.h"
#import "DBManager.h"
#import "CustomInfoWindow.h"
#import "FirstViewController.h"

@interface SecondViewController ()

@property (nonatomic, strong) DBManager *dbManager;
@property (nonatomic, strong) NSArray *arrMortgageInfo;
@property(nonatomic,retain)UIPopoverPresentationController *dateTimePopover8;
@end

@implementation SecondViewController{
    GMSMapView *mapView;
    NSMutableArray *markers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //initialize DB Manager
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"mortgagedb.sql"];
    
    
    GMSCameraPosition *cameraPostition=[GMSCameraPosition cameraWithLatitude:37.335438 longitude:-121.884972 zoom:15];
    
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:cameraPostition];
    mapView.myLocationEnabled = NO;
    mapView.delegate = self;
    self.view = mapView;
    
    
    [self loadData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GMSMapViewDelegate

//- (void)mapView:(GMSMapView *)mapView
//didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
//    NSLog(@"You tapped at %f,%f", coordinate.latitude, coordinate.longitude);
//}
//

-(void)didDeleteMortgageEntryWithAnnotation:(GMSMarker*)marker{
    
    [marker setMap:nil];
//    NSLog(@"id %@",id);
}

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker{
    NSLog(@"mareker tapped %f %f",marker.position.latitude,marker.position.longitude);
    
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MortgagePopoverViewController *mortgagePopover = (MortgagePopoverViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MortgagePopoverController"];
    
    
    
    UINavigationController *destNav = [[UINavigationController alloc] initWithRootViewController:mortgagePopover];
    mortgagePopover.preferredContentSize = CGSizeMake(300,280);
    destNav.modalPresentationStyle = UIModalPresentationPopover;
    _dateTimePopover8 = destNav.popoverPresentationController;
    _dateTimePopover8.delegate = self;
    _dateTimePopover8.sourceView = self.view;
//    CGRect frame = [[marker map] frame];
    CGRect frame = marker.layer.frame;
    frame.origin.y = marker.layer.frame.origin.y + 30;
    
    CGPoint point = [mapView.projection pointForCoordinate:marker.position];
    
    _dateTimePopover8.sourceRect = CGRectMake(point.x, point.y, 30, 30);
    destNav.modalPresentationStyle = UIModalPresentationPopover;
    destNav.navigationBarHidden = YES;
    

    NSDictionary *tuple = marker.userData;
    mortgagePopover.propertyString = tuple[@"propertytype"];
    mortgagePopover.streetAddressString = tuple[@"address"];
    mortgagePopover.cityString = tuple[@"city"];
    mortgagePopover.loanAmountString = tuple[@"loanamount"];
    mortgagePopover.aprString = tuple[@"apr"];
    mortgagePopover.monthlyPaymentString = tuple[@"monthlypayment"];
    mortgagePopover.ID = tuple[@"id"];
    mortgagePopover.marker = tuple[@"marker"];
    mortgagePopover.coordinate = CLLocationCoordinate2DMake([tuple[@"lat"]doubleValue],[tuple[@"long"]doubleValue]);

    mortgagePopover.delegate = self;
    
    [self presentViewController:destNav animated:YES completion:nil];
    
    return NO;
}


- (UIModalPresentationStyle) adaptivePresentationStyleForPresentationController: (UIPresentationController * ) controller {
    return UIModalPresentationNone;
}

#pragma mark MortgagePopoverDelegate

//-(UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    MortgagePopoverViewController *mortgagePopover = (MortgagePopoverViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MortgagePopoverController"];
//    
//    
//    return mortgagePopover;
//}

-(void)didSelectEditButtonForId:(NSString *)ID{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FirstViewController *firstController = (FirstViewController *)[storyboard instantiateViewControllerWithIdentifier:@"propertyInfoController"];
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM mortgageInfo WHERE mortgage_id=%d",[ID intValue]];
    NSArray *results = [[NSArray alloc]init];
    results = [self.dbManager loadDataFromDB:query];
    
    NSLog(@"populate entry %@",[results[0] objectAtIndex:1]);
    


    
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:firstController];
    firstController.ID = [[NSString stringWithString:[results[0] objectAtIndex:0]] intValue];
    firstController.propertyTypeText = [NSString stringWithString:[results[0] objectAtIndex:1]];
    firstController.addressText = [NSString stringWithString:[results[0] objectAtIndex:2]];
    firstController.cityText = [NSString stringWithString:[results[0] objectAtIndex:3]];
    firstController.stateText1 = [NSString stringWithString:[results[0] objectAtIndex:4]];
    firstController.zipText = [NSString stringWithString:[results[0] objectAtIndex:5]];
    firstController.loanAmountText = [NSString stringWithString:[results[0] objectAtIndex:6]];
    firstController.downPaymentText = [NSString stringWithString:[results[0] objectAtIndex:7]];
    firstController.aprText = [NSString stringWithString:[results[0] objectAtIndex:8]];
    firstController.termsText = [NSString stringWithString:[results[0] objectAtIndex:9]];
        firstController.ID = [ID intValue];
    firstController.result = [NSString stringWithString:[results[0] objectAtIndex:10]];
    [self presentViewController:navigationController animated:YES completion:nil];
}



-(void)didSelectStreetViewForCoordinate:(CLLocationCoordinate2D)coordinate{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    StreetViewController *streetViewController = [storyboard instantiateViewControllerWithIdentifier:@"StreetViewController"];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:streetViewController];
    streetViewController.coordinate = coordinate;
    [self presentViewController:navController animated:YES completion:nil];
}

-(void)loadData{
    NSString *query = @"select * from mortgageInfo";
    NSString *lat,*lng;
    // Get the results.
    if (self.arrMortgageInfo != nil) {
        self.arrMortgageInfo = nil;
    }
    self.arrMortgageInfo = [[NSArray alloc] init ];
    
    self.arrMortgageInfo = [self.dbManager loadDataFromDB:query];
    
//    NSLog(@"count %lu",[self.arrMortgageInfo count]);
        for (int i=0; i < [self.arrMortgageInfo count]; i++) {
            GMSMarker* marker = [[GMSMarker alloc]init];
            
            
            
            lat = [self.arrMortgageInfo[i] objectAtIndex:11];
            lng = [self.arrMortgageInfo[i] objectAtIndex:12];
            
//            [marker setTitle:[self.arrMortgageInfo[i] objectAtIndex:1]];
//            [marker setSnippet:[self.arrMortgageInfo[i] objectAtIndex:2]];
            
            [marker setPosition:CLLocationCoordinate2DMake([lat doubleValue], [lng doubleValue])];
            [marker setMap:mapView];
            NSDictionary *inventory = @{
                                        @"id" : [NSNumber numberWithInteger:[[self.arrMortgageInfo[i] objectAtIndex:0] integerValue]],
                                        @"propertytype" : [NSString stringWithString:[self.arrMortgageInfo[i] objectAtIndex:1]],
                                        @"address" : [NSString stringWithString:[self.arrMortgageInfo[i] objectAtIndex:2]],
                                        @"city" : [NSString stringWithString:[self.arrMortgageInfo[i] objectAtIndex:3]],
                                        @"loanamount" : [NSString stringWithString:[self.arrMortgageInfo[i] objectAtIndex:6]],
                                        @"apr" : [NSString stringWithString:[self.arrMortgageInfo[i] objectAtIndex:8]],
                                        @"monthlypayment" : [NSString stringWithString:[self.arrMortgageInfo[i] objectAtIndex:10]],
                                        @"lat" : [NSString stringWithString:[self.arrMortgageInfo[i] objectAtIndex:11]],
                                        @"long" : [NSString stringWithString:[self.arrMortgageInfo[i] objectAtIndex:12]],
                                        @"marker" : marker
                                        };

            [marker setUserData:inventory];
            
//            NSLog(@"Data %@, %@ ",lat,lng);
            
        }

    
}

@end
