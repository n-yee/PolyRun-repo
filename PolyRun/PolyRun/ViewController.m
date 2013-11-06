//
//  ViewController.m
//  PolyRun
//
//  Created by Nathan Yee on 10/24/13.
//  Copyright (c) 2013 Nathan Yee. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>



@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *MapView;
@property (weak, nonatomic) IBOutlet UILabel *timer;
@end


@implementation ViewController
//#define THE_SPAN 0.005f;
int seconds = 0;
int minutes = 0;
int hours = 0;
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.MapView.mapType = MKMapTypeHybrid; // sets the mapview to hybrid
    self.alreadyZoomed = NO;
    self.locMgr = [[CLLocationManager alloc] init];
    self.locMgr.distanceFilter = kCLDistanceFilterNone;
    self.locMgr.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locMgr.delegate = self;
    [self.locMgr startUpdatingLocation];
    
    self.MapView.showsUserLocation = YES;
}
- (void) zoomToLocation: (CLLocationCoordinate2D) center
{
    MKCoordinateRegion myregion;
    
    //Span - how far to zoom
    MKCoordinateSpan span;

    span.latitudeDelta = 0.01;
    span.longitudeDelta = 0.01;
    
    myregion.center = center;
    myregion.span = span;
    
    //set out map
    [self.MapView setRegion:myregion animated: YES];
    [self.MapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *loc = [locations firstObject];
    NSLog(@"lat: %lf, long: %lf, speed:%lf", loc.coordinate.latitude, loc.coordinate.longitude, loc.speed);
    
    if (self.alreadyZoomed == NO) {
        [self zoomToLocation:loc.coordinate];
        self.alreadyZoomed = YES;
    }
    if (loc.speed > 0.5 && loc.speed < 6 && seconds != 60) {
        [self startTimer];
        self.timer.text = [NSString stringWithFormat:@"%i:%i:%i", hours, minutes, seconds];
    }
    else if (loc.speed > 6) {
        self.timer.text = @"Cheater.";
        hours = 0;
        minutes = 0;
        seconds = 60;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) startTimer {
    if (seconds <59) seconds++;
    else if (seconds == 59 && minutes<59) {
        minutes++;
        seconds = 0;
    }
    else if (seconds == 59 && minutes == 59) {
        hours++;
        minutes = 0;
        seconds = 0;
    }
    self.timer.text = [NSString stringWithFormat:@"%i, %i, %i", hours, minutes, seconds];
}

@end
