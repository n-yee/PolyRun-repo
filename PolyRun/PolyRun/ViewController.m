//
//  ViewController.m
//  PolyRun
//
//  Created by Nathan Yee on 10/24/13.
//  Copyright (c) 2013 Nathan Yee. All rights reserved.
//

#import "ViewController.h"
#import "pickerController.h"
#import <MapKit/MapKit.h>



@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *MapView;
@property (weak, nonatomic) IBOutlet UILabel *timer;
@property NSUserDefaults *defaults;
@property CLLocation *timerStartLoc;
@property CLLocation *myLoc;
@property int seconds;
@property int minutes;
@property int hours;
@property bool startTimer;
@property bool gotPoints;
@property float distanceSet;
@property int nextPoint;
@property float distanceTravelled;
@property MKPolyline *polyLine;
@property (weak, nonatomic) IBOutlet UIButton *mileButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UILabel *tmpLabel;
@property (weak, nonatomic) IBOutlet UIButton *achievBtn;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _gotPoints=false;
    
    //Change to 1 if place next point is used
    _nextPoint=0;
    
    
    //CLLocationCoordinate2D tmp;
    //tmp.latitude = _locMgr.location.coordinate.latitude;
    //tmp.longitude = _locMgr.location.coordinate.longitude;
    
    //NSLog(@)
    
    double tmp=1.91351234;
    double rtmp= round(100000.0f *tmp)/100000.0f;
    
    NSLog(@"%f",rtmp);
    
    
    [self initateZoom];
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

-(bool) checkPoint: (NSArray *) point
{
    //double cmpr_long = round(100000.0f * _myLoc.coordinate.longitude)/ 100000.0;
    //double cmpr_lat = round(100000.0f * _myLoc.coordinate.latitude)/ 100000.0;
    
    CLLocation *myLoc = [[CLLocation alloc] initWithLatitude:_myLoc.coordinate.latitude longitude:_myLoc.coordinate.longitude];
    
    bool checkPointReached = false;
    
    //test this on a phone.
    MKPointAnnotation *tmpPoint = point[_nextPoint];
    
    
    CLLocation *pointLoc = [[CLLocation alloc] initWithLatitude:tmpPoint.coordinate.latitude longitude:tmpPoint.coordinate.longitude];
    
    
    CLLocationDistance dist = [pointLoc distanceFromLocation:myLoc];
    
    NSLog(@"long: %lf, lat: %lf, my location: long %lf lat %lf distance=%lf",pointLoc.coordinate.longitude,pointLoc.coordinate.latitude, _myLoc.coordinate.longitude,_myLoc.coordinate.latitude, dist);
    
    if ( dist <= 2.0)
    {
        checkPointReached=true;
    }
    
    if (checkPointReached)
    {
        _nextPoint++;
    }
    
    return checkPointReached;

}

// checks speed and starts the timer
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *loc = [locations firstObject];
    _myLoc = loc;
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
   // NSLog(@"lat: %lf, long: %lf, speed:%lf", _myLoc.coordinate.latitude, _myLoc.coordinate.longitude, loc.speed);
    
    if (self.alreadyZoomed == NO) {
        [self zoomToLocation:loc.coordinate];
        self.alreadyZoomed = YES;
    }
    
    if (loc.speed > 0.5 && !_startTimer) {
        _startTimer = true;
        _timerStartLoc = loc;
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
        
        self.timer.text = [NSString stringWithFormat:@"%02d: %02d: %02d", _hours, _minutes, _seconds];
    }
    else if (loc.speed > 6) {
        self.timer.text = @"Cheater.";
        _hours = 0;
        _minutes = 0;
        _seconds = 0;
    }
    
    if([loc distanceFromLocation:_myLoc] < 5 && _minutes > 2 && _distanceTravelled >= _distanceSet)
    {
        _startTimer = false;
        [defaults setObject: self.timer.text forKey: @"lastTime"];
    }
    if (_gotPoints)
    {
        
        if ([self checkPoint: _routePoints])
        {
            //set point record for achievments
            NSUserDefaults *tmpPin = [NSUserDefaults standardUserDefaults];
            [tmpPin setInteger:[tmpPin integerForKey:@"totalNumberOfPins"] +1 forKey:@"totalNumberOfPins"];
            [tmpPin synchronize];
            
            NSLog(@"checkpoint reached");
            
            _tmpLabel.text = @"check Point reached";
            
            //[self placeNextPoint:_nextPoint];
            
        }
    }

    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation {
    
    MKPinAnnotationView *newAnnotationPin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"stuff"];
    newAnnotationPin.pinColor = MKPinAnnotationColorGreen; // Or Red/Green
    return newAnnotationPin;
    
}

// Use this if we change are minds to add each point and not use the routes
/*
 - (void) placeNextPoint: (int) p
 {
 
 [self.MapView addAnnotation: _routePoints[p]];
 
 }
 */

- (void) setRoute: (NSArray *) path
{
    
    CLLocationCoordinate2D coords[path.count +1];
    
    
    
    for (NSInteger i = 0; i < path.count; i++) {
        CLLocation *location = [path objectAtIndex:i];
        CLLocationCoordinate2D coordinate = location.coordinate;
        
        
        
        coords[i] = coordinate;
        
        NSLog(@"Long: %@ lat: %@", [NSString stringWithFormat: @"%g", coords[i].longitude], [NSString stringWithFormat: @"%g", coords[i].latitude]);
        
    }

    coords[path.count] = coords[0];
    
    _polyLine = [MKPolyline polylineWithCoordinates:coords count:path.count+1];
    
    self.MapView.delegate = self;
    
    [self.MapView addAnnotations:path];
    
    [self.MapView addOverlay:_polyLine];
    
}


//create overlay object
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    MKPolylineView *polylineView = [[MKPolylineView alloc] initWithPolyline:overlay];
    polylineView.strokeColor = [UIColor greenColor];
    polylineView.lineWidth = 7.0;
    
    return polylineView;
}


-(IBAction)unwindToRoutePicker:(UIStoryboardSegue *)sender
{
    
    // pickerController *myPicker = [[pickerController alloc] initWithNibName:@"pickerController" bundle:nil];
    
    pickerController *myPicker = sender.sourceViewController;
    
    self.timer.hidden = NO;
    self.mileButton.hidden = YES;
    self.achievBtn.hidden = YES;
    self.cancelBtn.hidden = NO;
    
    _routePoints = myPicker.myRoute;
    _distanceSet = [myPicker.miles floatValue];
    _gotPoints = true;
    
    // Use in the placeNextPoint method is used
    //[self placeNextPoint:0;
    
    [self setRoute:myPicker.myRoute];
    
}
- (IBAction)cancelRun:(id)sender
{
    
    self.timer.hidden = YES;
    self.mileButton.hidden = NO;
    
    for (id object in _routePoints)
    {
        
        [_MapView removeAnnotation:object];
    }
    [_MapView removeOverlay:_polyLine];
    
    self.cancelBtn.hidden = YES;
}


@end
