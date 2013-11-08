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
@property NSUserDefaults *defaults;
@property CLLocation *initialLoc;
@property int seconds;
@property int minutes;
@property int hours;
@property bool startTimer;
@end


@implementation ViewController
//#define THE_SPAN 0.005f;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initateZoom];
    
    NSMutableArray *myRoute = [self getRoute];
    
    [self setRoute:myRoute];

    
    
}

// start then locates user and places blue dot
-(void) initateZoom
{
    self.MapView.mapType = MKMapTypeHybrid; // sets the mapview to hybrid
    self.alreadyZoomed = NO;
    self.locMgr = [[CLLocationManager alloc] init];
    self.locMgr.distanceFilter = kCLDistanceFilterNone;
    self.locMgr.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locMgr.delegate = self;
    [self.locMgr startUpdatingLocation];
    _defaults = [NSUserDefaults standardUserDefaults];
    _seconds = 0;
    _minutes = 0;
    _hours = 0;
    _startTimer = false;
    
    self.MapView.showsUserLocation = YES;
    
    
}



//zooms in on current user location
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

// checks speed and starts the timer
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *loc = [locations firstObject];
    NSLog(@"lat: %lf, long: %lf, speed:%lf", loc.coordinate.latitude, loc.coordinate.longitude, loc.speed);
    
    if (self.alreadyZoomed == NO) {
        [self zoomToLocation:loc.coordinate];
        self.alreadyZoomed = YES;
    }
    
    if (loc.speed > 0.5 && !_startTimer) {
        _startTimer = true;
        _initialLoc = loc;
    }
    
    
    if(_startTimer && loc.speed < 6)
    {
        _seconds++;
        if(_seconds >= 60)
        {
            _minutes++;
            _seconds = 0;
        }
        
        if(_minutes >= 60)
        {
            _hours++;
            _minutes = 0;
        }
        
        self.timer.text = [NSString stringWithFormat:@"%i, %i, %i", _hours, _minutes, _seconds];
    }
    else if (loc.speed > 6) {
        self.timer.text = @"Cheater.";
        _hours = 0;
        _minutes = 0;
        _seconds = 0;
    }
    
    if([loc distanceFromLocation:_initialLoc] < 5 && _minutes > 2)
    {
        _startTimer = false;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSMutableArray*) getRoute
{
    
    NSMutableArray * locations = [[NSMutableArray alloc] init];
    
    
    MKPointAnnotation *startPoint = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coordStart;
    coordStart.latitude = self.MapView.userLocation.location.coordinate.latitude;
    coordStart.longitude= self.MapView.userLocation.location.coordinate.longitude;
    
    startPoint.coordinate=coordStart;
    
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


- (void) setRoute: (NSArray *) path
{
    
    CLLocationCoordinate2D coords[path.count];
    
    for (NSInteger i = 0; i < path.count; i++) {
        CLLocation *location = [path objectAtIndex:i];
        CLLocationCoordinate2D coordinate = location.coordinate;
        
        coords[i] = coordinate;
    }

    
    MKPolyline *polyLine = [MKPolyline polylineWithCoordinates:coords count:path.count];
    
    self.MapView.delegate = self;
    
    [self.MapView addAnnotations:path];
    
    [self.MapView addOverlay:polyLine];
    
}


//create overlay object
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    MKPolylineView *polylineView = [[MKPolylineView alloc] initWithPolyline:overlay];
    polylineView.strokeColor = [UIColor greenColor];
    polylineView.lineWidth = 7.0;
    
    return polylineView;
}



@end
