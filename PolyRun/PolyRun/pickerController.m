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

-(void) addAllPoints
{
    bool swapped = false;
    do
    {
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

-(void) addPoint : (double) latitude : (double) longitude
{
    Checkpoint *addThis = [[Checkpoint alloc] init];
    addThis.loc = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude ];
    addThis.distance = [self.locMgr.location distanceFromLocation:addThis.loc];

    [self.locations addObject:addThis];

}



- (IBAction)runClicked:(UIButton *)sender
{
    
    
    float myMiles = [_miles floatValue];
    [self addPoint:self.locMgr.location.coordinate.latitude :self.locMgr.location.coordinate.longitude];
    [self addAllPoints];
    
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
    
    _myRoute = _route;
    
    
    
    [self performSegueWithIdentifier:@"runClicked" sender:self];
}

@end
