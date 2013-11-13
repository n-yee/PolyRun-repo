//
//  pickerController.m
//  PolyRun
//
//  Created by Ruchita Patel on 11/12/13.
//  Copyright (c) 2013 Nathan Yee. All rights reserved.
//

#import "pickerController.h"
#import "ViewController.h"


@implementation pickerController


- (void)viewDidLoad
{
    [super viewDidLoad];
    arrStatus = [[NSArray alloc] initWithObjects:@"0", @"1",@"2",@"3", @"4",@"5", @"6", @"7", @"8", @"9", nil];
    
    decimal = [[NSArray alloc] initWithObjects:@".0", @".5", nil];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //One column
    return 3;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //set number of rows
    if (component == 0 || component == 1) return arrStatus.count;
    else return decimal.count;
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //set item per row
    if (component == 0 || component == 1) return [arrStatus objectAtIndex:row];
    else return [decimal objectAtIndex:row];
}




-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
    NSString *numbers = [arrStatus objectAtIndex:[pickerView selectedRowInComponent:0] ];
    NSString *one = [arrStatus objectAtIndex:[pickerView selectedRowInComponent:1] ];
    NSString *ten = [decimal objectAtIndex:[pickerView selectedRowInComponent:2] ];
    
    
    
    _miles= [numbers stringByAppendingString:[one stringByAppendingString:ten]];

    
}

-(NSMutableArray*) getRouteHalfMile
{
    
    self.locMgr = [[CLLocationManager alloc] init];
    self.locMgr.distanceFilter = kCLDistanceFilterNone;
    self.locMgr.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
   
    NSMutableArray * locations = [[NSMutableArray alloc] init];
    
    MKPointAnnotation *startPoint = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D startP;
    startP.latitude = _locMgr.location.coordinate.latitude;
    startP.longitude = _locMgr.location.coordinate.longitude;
    
    startPoint.coordinate=startP;
    
    [locations addObject:startPoint];
    
    MKPointAnnotation *p1 = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coordP1;
    coordP1.latitude = 35.30202;
    coordP1.longitude= -120.66209;
    
    p1.coordinate=coordP1;
    
    [locations addObject:(p1)];
    
    
    MKPointAnnotation *p2 = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coordP2;
    coordP2.latitude = 35.30235;
    coordP2.longitude= -120.66227;
    
    p2.coordinate=coordP2;
    
    [locations addObject:(p2)];
    
    MKPointAnnotation *p3 = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coordP3;
    coordP3.latitude = 35.30235;
    coordP3.longitude= -120.66287;
    
    p3.coordinate=coordP3;
    
    [locations addObject:(p3)];
    
    
    MKPointAnnotation *p4 = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coordP4;
    coordP4.latitude = 35.30206;
    coordP4.longitude= -120.66285;
    
    p4.coordinate=coordP4;
    
    [locations addObject:(p4)];
    
    
    
    MKPointAnnotation *p5 = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coordP5;
    coordP5.latitude = 35.30130;
    coordP5.longitude= -120.66281;
    
    p5.coordinate=coordP5;
    
    [locations addObject:(p5)];
    
    return locations;
}
-(NSMutableArray*) getRouteOneMile
{
    
    self.locMgr = [[CLLocationManager alloc] init];
    self.locMgr.distanceFilter = kCLDistanceFilterNone;
    self.locMgr.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
    
    NSMutableArray * locations = [[NSMutableArray alloc] init];
    
    MKPointAnnotation *startPoint = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D startP;
    startP.latitude = _locMgr.location.coordinate.latitude;
    startP.longitude = _locMgr.location.coordinate.longitude;
    
    startPoint.coordinate=startP;
    
    [locations addObject:startPoint];
    
    MKPointAnnotation *p1 = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coordP1;
    coordP1.latitude = 35.302343;
    coordP1.longitude= -120.663046;
    
    p1.coordinate=coordP1;
    
    [locations addObject:(p1)];
    
    
    MKPointAnnotation *p2 = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coordP2;
    coordP2.latitude = 35.303958;
    coordP2.longitude= -120.662257;
    
    p2.coordinate=coordP2;
    
    [locations addObject:(p2)];
    
    MKPointAnnotation *p3 = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coordP3;
    coordP3.latitude = 35.304164;
    coordP3.longitude= -120.66287;
    
    p3.coordinate=coordP3;
    
    [locations addObject:(p3)];
    
    
    MKPointAnnotation *p4 = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coordP4;
    coordP4.latitude = 35.30306;
    coordP4.longitude= -120.661222;
    
    p4.coordinate=coordP4;
    
    [locations addObject:(p4)];
    
    
    
    MKPointAnnotation *p5 = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coordP5;
    coordP5.latitude = 35.302198;
    coordP5.longitude= -120.660616;
    
    p5.coordinate=coordP5;
    
    [locations addObject:(p5)];
    
    MKPointAnnotation *p6 = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coordP6;
    coordP6.latitude = 35.301331;
    coordP6.longitude= -120.661254;
    
    p6.coordinate=coordP6;
    
    [locations addObject:(p6)];
    
    return locations;
}

-(NSMutableArray*) getRouteThreeMile
{
    
    self.locMgr = [[CLLocationManager alloc] init];
    self.locMgr.distanceFilter = kCLDistanceFilterNone;
    self.locMgr.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
    
    NSMutableArray * locations = [[NSMutableArray alloc] init];
    
    MKPointAnnotation *startPoint = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D startP;
    startP.latitude = _locMgr.location.coordinate.latitude;
    startP.longitude = _locMgr.location.coordinate.longitude;
    
    startPoint.coordinate=startP;
    
    [locations addObject:startPoint];
    
    MKPointAnnotation *p1 = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coordP1;
    coordP1.latitude = 35.30208;
    coordP1.longitude= -120.664473;
    
    p1.coordinate=coordP1;
    
    [locations addObject:(p1)];
    
    
    MKPointAnnotation *p2 = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coordP2;
    coordP2.latitude = 35.301695;
    coordP2.longitude= -120.666382;
    
    p2.coordinate=coordP2;
    
    [locations addObject:(p2)];
    
    MKPointAnnotation *p3 = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coordP3;
    coordP3.latitude = 35.300022;
    coordP3.longitude= -120.666136;
    
    p3.coordinate=coordP3;
    
    [locations addObject:(p3)];
    
    
    MKPointAnnotation *p4 = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coordP4;
    coordP4.latitude = 35.29877;
    coordP4.longitude= -120.665749;
    
    p4.coordinate=coordP4;
    
    [locations addObject:(p4)];
    
    
    
    MKPointAnnotation *p5 = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coordP5;
    coordP5.latitude = 35.297439;
    coordP5.longitude= -120.666329;
    
    p5.coordinate=coordP5;
    
    [locations addObject:(p5)];
    
    MKPointAnnotation *p6 = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coordP6;
    coordP6.latitude = 35.295539;
    coordP6.longitude= -120.665739;
    
    p6.coordinate=coordP6;
    
    [locations addObject:(p6)];
    
    MKPointAnnotation *p7 = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coordP7;
    coordP7.latitude = 35.294865;
    coordP7.longitude= -120.664269;
    
    p7.coordinate=coordP7;
    
    [locations addObject:(p7)];
    
    MKPointAnnotation *p8 = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coordP8;
    coordP8.latitude = 35.296327;
    coordP8.longitude= -120.661769;
    
    p8.coordinate=coordP8;
    
    [locations addObject:(p8)];
   
    MKPointAnnotation *p9 = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coordP9;
    coordP9.latitude = 35.297833;
    coordP9.longitude= -120.662938;
    
    p9.coordinate=coordP9;
    
    [locations addObject:(p9)];
    
    MKPointAnnotation *p10 = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coordP10;
    coordP10.latitude = 35.298945;
    coordP10.longitude= -120.662209;
    
    p10.coordinate=coordP10;
    
    [locations addObject:(p10)];

    return locations;
}


- (IBAction)runClicked:(UIButton *)sender
{
    _myRoute = [self getRouteHalfMile];
    [self performSegueWithIdentifier:@"runClicked" sender:self];
}

@end
