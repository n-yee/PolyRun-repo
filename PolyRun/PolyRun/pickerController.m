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
    [self addPoint:35.302623 :-120.657166];
    [self addPoint:35.303092 :-120.65742];
    [self addPoint:35.303417 :-120.657936];
    [self addPoint:35.302831 :-120.65816];
    [self addPoint:35.302218 :-120.658471];
    [self addPoint:35.302804 :-120.659013];
    [self addPoint:35.303311 :-120.659515];
    [self addPoint:35.302963 :-120.660003];
    [self addPoint:35.302857 :-120.660881];
    [self addPoint:35.302678 :-120.661884];
    [self addPoint:35.301904 :-120.662034];
    [self addPoint:35.300976 :-120.661919];
    [self addPoint:35.300772 :-120.662686];
    [self addPoint:35.300744 :-120.663626];
    [self addPoint:35.300003 :-120.664054];
    [self addPoint:35.299264 :-120.663865];
    [self addPoint:35.298504 :-120.66359];
    [self addPoint:35.297653 :-120.663082];
    [self addPoint:35.298345 :-120.662902];
    [self addPoint:35.298903 :-120.662304];
    [self addPoint:35.299061 :-120.662891];
    [self addPoint:35.299663 :-120.662391];
    [self addPoint:35.299581 :-120.661774];
    [self addPoint:35.298889 :-120.661254];
    [self addPoint:35.299083 :-120.659634];
    [self addPoint:35.299782 :-120.659146];
    [self addPoint:35.300233 :-120.658105];
    [self addPoint:35.300322 :-120.659344];
    [self addPoint:35.300787 :-120.66109];
    [self addPoint:35.3012 :-120.659629];
    [self addPoint:35.30179 :-120.658228];
    [self addPoint:35.300361 :-120.657019];
    [self addPoint:35.299438 :-120.656501];
    [self addPoint:35.29933 :-120.656866];
    [self addPoint:35.300222 :-120.656198];
    [self addPoint:35.298832 :-120.655227];
    [self addPoint:35.297762 :-120.654015];
    [self addPoint:35.298193 : -120.653223];
    [self addPoint:35.298237 :-120.654084];
    [self addPoint:35.299622 :-120.65475];
    [self addPoint:35.30049 :-120.656608];
    [self addPoint:35.29904 :-120.658137];
    [self addPoint:35.302983 :-120.664121];
    [self addPoint:35.302436 :-120.664797];
    [self addPoint:35.300084 :-120.665409];
    [self addPoint: 35.298682 :-120.664395];
    [self addPoint:35.303628 :-120.662708];
    [self addPoint:35.305539 :-120.662989];
    [self addPoint:35.306764 :-120.663262];
    [self addPoint:35.308118 :-120.663722];
    [self addPoint:35.308205 :-120.663172];
    [self addPoint:35.308205 :-120.663172];
    [self addPoint:35.308327 :-120.6615];
    [self addPoint:35.30879 :-120.660457];
    [self addPoint:35.309265 :-120.659647];
    [self addPoint: 35.309053 :-120.658655];
    [self addPoint:35.308781 :-120.659848];
    [self addPoint:35.30863 :-120.659398];
    [self addPoint:35.308504 :-120.658652];
    [self addPoint:35.308339 :-120.657713];
    [self addPoint: 35.307937 :-120.658816];
    [self addPoint:35.307586 :-120.658113];
    [self addPoint:35.307365 :-120.658915];
    [self addPoint:35.30807 :-120.657274];
    [self addPoint:35.308662 :-120.65686];
    [self addPoint:35.308831 :-120.657738];
    [self addPoint:35.306498 :-120.658824];
    [self addPoint:35.30596 :-120.659602];
    [self addPoint:35.30562 :-120.660393];
    [self addPoint:35.304647 :-120.659191];
    [self addPoint:35.305047 :-120.65947];
    [self addPoint:35.305599 :-120.658961];
    [self addPoint:35.304403 :-120.658446];
    [self addPoint:35.304036 :-120.656399];
    [self addPoint:35.304981 :-120.656799];
    [self addPoint:35.305957 :-120.657282];
    [self addPoint:35.30455 :-120.657831];
    [self addPoint:35.303537 :-120.657595];
    [self addPoint:35.304623 :-120.659258];
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
    
    _myRoute = _route;
    
    
    
    [self performSegueWithIdentifier:@"runClicked" sender:self];
}

@end
