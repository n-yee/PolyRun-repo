//
//  pickerController.m
//  PolyRun
//
//  Created by Ruchita Patel on 11/12/13.
//  Copyright (c) 2013 Nathan Yee. All rights reserved.
//

#import "pickerController.h"
#import "ViewController.h"
#import "Checkpoint.h"


@interface pickerController ()
@property NSMutableArray *locations;
@property NSMutableArray *route;

@end

@implementation pickerController


- (void)viewDidLoad
{
    [super viewDidLoad];
    arrStatus = [[NSArray alloc] initWithObjects:@"0", @"1",@"2",@"3", @"4",@"5", @"6", @"7", @"8", @"9", nil];
    
    decimal = [[NSArray alloc] initWithObjects:@".0", @".5", nil];
    
    self.locMgr = [[CLLocationManager alloc] init];
    self.locMgr.distanceFilter = kCLDistanceFilterNone;
    self.locMgr.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locations = [[NSMutableArray alloc] init];
    self.route = [[NSMutableArray alloc] init];
    [self addAllPoints];
    
    
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

-(void) sortAllPoints
{
    bool swapped = false;
    do
    {
        swapped = false;
        for(int i = 1; i < self.locations.count; i++)
        {
            if(self.locations[i-1] > self.locations[i])
            {
                Checkpoint *temp = self.locations[i];
                self.locations[i] = self.locations[i-1];
                self.locations[i-1] = temp;
                swapped = true;
            }
        }
    }while(swapped == true);
    
    for(int i = 1; i < self.locations.count; i++)
    {
        Checkpoint *temp = self.locations[i];
        Checkpoint *temp2 = self.locations[i-1];
        temp.distance = [temp.loc distanceFromLocation:temp2.loc];
    }

}

-(void) addAllPoints
{
    [self addPoint:self.locMgr.location.coordinate.latitude :self.locMgr.location.coordinate.longitude];
    [self addPoint: 35.302666: -120.666575];
    [self addPoint:35.302666: -120.666575];
    [self addPoint:35.301747: -120.666382];
    [self addPoint:35.30065: -120.666254];
    [self addPoint:35.300083: -120.666103];
    [self addPoint:35.299173: -120.66591];
    [self addPoint:35.298262: -120.665588];
    [self addPoint:35.296555: -120.664998];
    [self addPoint:35.297001: -120.663625];
    [self addPoint:35.297789: -120.66296];
    [self addPoint:35.29877: -120.662434];
    [self addPoint:35.298858: -120.660868];
    [self addPoint:35.299033: -120.659677];
    [self addPoint:35.298288: -120.659087];
    [self addPoint:35.297894: -120.658765];
    [self addPoint:35.298446: -120.658014];
    [self addPoint:35.299068: -120.656823];
    [self addPoint:35.300425: -120.656244];
    [self addPoint: 35.301519: -120.656533];
    [self addPoint:35.303034: -120.657349];
    [self addPoint:35.303472: -120.658454];
    [self addPoint:35.303376: -120.659773];
    [self addPoint:35.303297: -120.661136];
    [self addPoint:35.30412: -120.66222];
    [self addPoint:35.303962: -120.663475];
    [self addPoint:35.303411: -120.664762];
    [self addPoint:35.302894: -120.666039];
    [self addPoint:35.303069: -120.663239];
    [self addPoint:35.301668: -120.662863];
    [self addPoint:35.30081: -120.662659];
    [self addPoint:35.302526: -120.662123];
    [self addPoint:35.302763: -120.660921];
    [self addPoint: 35.302789: -120.65957];
    [self addPoint: 35.302272: -120.658754];
    [self addPoint:35.301712: -120.658239];
    [self addPoint:35.300968: -120.658035];
    [self addPoint:35.300241: -120.658143];
    [self addPoint:35.299611: -120.65854];
    [self addPoint:35.29933: -120.663764];
    [self addPoint:35.299558: -120.662692];
    [self addPoint:35.299602: -120.661758];
    [self addPoint:35.299873: -120.660471];
    [self addPoint:35.300609: -120.659044];
    [self addPoint:35.301502: -120.659248];
    [self addPoint:35.301712: -120.660138];
    [self addPoint:35.301388: -120.661168];
    [self addPoint:35.30088: -120.661951];
}

-(void) addPoint : (double) latitude : (double) longitude
{
    Checkpoint *addThis = [[Checkpoint alloc] init];
    addThis.loc = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude ];
    addThis.distance = [self.locMgr.location distanceFromLocation:addThis.loc];

    [self.locations addObject:addThis];

}

- (IBAction)runClicked:(UIButton *)sender
{
    
    
    float myMiles = [_miles floatValue] * 1609.34;
    
    [self sortAllPoints];
    
    int currentIndex = 0;
    Checkpoint *checkThis = self.locations[0];
    while(myMiles > checkThis.distance)
    {
        myMiles -= checkThis.distance;
        currentIndex++;
        [self.route addObject:checkThis.loc];
        if(currentIndex < self.locations.count)
        {
        checkThis = self.locations[currentIndex];
        }
        else
        {
            break;
        }
    }
    NSMutableArray *tmpRoute = [[NSMutableArray alloc] init];
    for(int i = 0; i < self.route.count; i++)
    {
    
        
        CLLocation *temp2 = self.route[i];
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        
        CLLocationCoordinate2D temp = temp2.coordinate;

        point.coordinate = temp;
        [tmpRoute addObject:point];
    }
    
    _myRoute=tmpRoute;
        
    
    [self performSegueWithIdentifier:@"runClicked" sender:self];
}

@end
