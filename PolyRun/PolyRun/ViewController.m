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
@property (weak, nonatomic) IBOutlet UIButton *mileButton;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
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
    double cmpr_long = round(100000.0f * _myLoc.coordinate.longitude)/ 100000.0;
    double cmpr_lat = round(100000.0f * _myLoc.coordinate.latitude)/ 100000.0;

    int nextPoint = 0;
    bool gotPoint = false;
    

    //Check this is eats up proccessing time
    
    while (nextPoint <= point.count) {
        
        MKPointAnnotation *tmpPoint = point[nextPoint];
        
        if ((tmpPoint.coordinate.latitude == cmpr_lat) && (tmpPoint.coordinate.longitude == cmpr_long))
        {
            gotPoint=true;
        }
 
    }

    
    return gotPoint;

}

// checks speed and starts the timer
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *loc = [locations firstObject];
    _myLoc = loc;
    NSLog(@"lat: %lf, long: %lf, speed:%lf", _myLoc.coordinate.latitude, _myLoc.coordinate.longitude, loc.speed);
    
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
    
    if([loc distanceFromLocation:_myLoc] < 5 && _minutes > 2)
    {
        _startTimer = false;
    }
    
    if ([self checkPoint: _routePoints])
    {
        //set next point
        NSUserDefaults *tmpPin = [NSUserDefaults standardUserDefaults];
        [tmpPin setInteger:[tmpPin integerForKey:@"totalNumberOfPins"] +1 forKey:@"totalNumberOfPins"];
        [tmpPin synchronize];
    }

    
    // Put annotataion check in here either method or the actual code
    //also have a method that sets the next point location so that the when the call back is called it can compare its location with the nextpoint
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
    
    MKPolyline *polyLine = [MKPolyline polylineWithCoordinates:coords count:path.count+1];
    
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




- (double) round: (double) num
{
    if (num>=0) {
        num+=0.5;
        
    }
    else {
        num-=0.5;
    }
    
    double roundNum = num;
    
    return roundNum;
    
}

-(IBAction)unwindToRoutePicker:(UIStoryboardSegue *)sender
{
    
    // pickerController *myPicker = [[pickerController alloc] initWithNibName:@"pickerController" bundle:nil];
    
    pickerController *myPicker = sender.sourceViewController;
    
    self.timer.hidden = NO;
    self.mileButton.hidden = YES;
    
    _routePoints = myPicker.myRoute;
    
    [self setRoute:myPicker.myRoute];
    
}


@end
