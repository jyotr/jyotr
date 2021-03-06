//
//  ViewController.m
//  jyotr_map
//
//  Created by Armen Mkrtchian on 03/08/13.
//  Copyright (c) 2013 Armen Mkrtchian. All rights reserved.
//

#import "ViewController.h"
#import "ApproveViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "MHNatGeoViewControllerTransition.h"

@interface ViewController ()

@end

@implementation ViewController {
    CLLocationManager *locationManager;
    MWDatePicker *datePicker;
    UIView *geocoderView;
    UILabel *addressLabel;
    UIButton *submitButton;
    NSDate *selectedDate;
    CLLocationCoordinate2D selectedCoordinate;
    int markerCount;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //Set Position of camera
    GMSCameraPosition *yerevan = [GMSCameraPosition cameraWithTarget:CLLocationCoordinate2DMake(40.1767815, 44.5243508)
                                                                zoom:18
                                                             bearing:0
                                                        viewingAngle:45];
    
    self.googleMapView = [GMSMapView mapWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, 410) camera:yerevan];
    
    //Set my location
    self.googleMapView.myLocationEnabled = YES;
    
    //Set Compass button
    self.googleMapView.settings.compassButton = YES;
    
    //Set my location button
    self.googleMapView.settings.myLocationButton = NO;
    
    //Set Bearing
    //    [self.googleMapView animateToBearing:1];
    
    //Set Map type
    /*
     Normal
     kGMSTypeNormal
     Typical road map. Roads, some man-made features, and important natural features such as rivers are shown. Road and feature labels are also visible. This is the default map mode in Google Maps for iOS.
     
     Hybrid
     kGMSTypeHybrid
     Satellite photograph data with road maps added. Road and feature labels are also visible. This map type can be enabled on the Google Maps app for iOS by turning on the Satellite view.
     
     Satellite
     kGMSTypeSatellite
     Satellite photograph data. Road and feature labels are not visible. This mode is not available in Google Maps for iOS.
     
     Terrain
     kGMSTypeTerrain
     Topographic data. The map includes colors, contour lines and labels, and perspective shading. Some roads and labels are also visible.
     
     None
     kGMSTypeNone
     No map tiles. The base map tiles will not be rendered. This mode is useful in conjunction with [tile layers][tilelayer]. The display of traffic data will be disabled when the map type is set to none.
     */
    self.googleMapView.mapType = kGMSTypeNormal;
    
    //Set indoor mode
    self.googleMapView.indoorEnabled = NO;
    
    //Set Accessibility
    self.googleMapView.accessibilityElementsHidden = NO;
    
    //Assign map to view
    self.googleMapView.delegate = self;
    
    [self.view addSubview:self.googleMapView];
    
    
    //Start location updates
    [self startStandardUpdates];
    [self startHeadingEvents];
    
        
    //Geocoder view init
    geocoderView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 200, 40)];
    geocoderView.backgroundColor = [UIColor blackColor];
    
    addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 40)];
    addressLabel.backgroundColor = [UIColor clearColor];
    addressLabel.textColor = [UIColor whiteColor];
    
    addressLabel.font = [UIFont systemFontOfSize:16.0f];
    
    addressLabel.text = @"";
    [geocoderView addSubview:addressLabel];

    
    markerCount = 0;
    
    
    //Header view init
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    topLabel.backgroundColor = [UIColor whiteColor];
    topLabel.textColor = [UIColor blackColor];
    
    topLabel.font = [UIFont systemFontOfSize:25.0f];
    topLabel.textAlignment = UITextAlignmentCenter;
    topLabel.numberOfLines = 2;
    topLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    topLabel.text = @"Select Place for Dating";
    [topView addSubview:topLabel];
    
    [self.view addSubview:topView];
    
    
    //DatePicker init
    datePicker = [[MWDatePicker alloc] initWithFrame:CGRectMake(0, 410, 270, 50)];
    [datePicker setDelegate:self];
    [datePicker setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]];
    [datePicker setFontColor:[UIColor whiteColor]];
    [datePicker update];
    
    [datePicker setDate:[NSDate date] animated:YES];
    
    
    [self.view addSubview:datePicker];
    
    //Submit button init
    
    submitButton = [[UIButton alloc] init];
    submitButton.backgroundColor = [UIColor colorWithRed:5/255.0f green:252/255.0f blue:181/255.0f alpha:1.0f];
//    [submitButton setImage:[UIImage imageNamed:@"submitButton.png"] forState:UIControlStateNormal];
//    [submitButton setImage:[UIImage imageNamed:@"submitButton.png"] forState:UIControlStateSelected];
//    [submitButton setImage:[UIImage imageNamed:@"submitButton.png"] forState:UIControlStateHighlighted];
    submitButton.showsTouchWhenHighlighted = YES;
    submitButton.frame = CGRectMake(270, 410, 50, 50);
    [submitButton addTarget:self action:@selector(submitDate) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:submitButton];
    
}

- (void)submitDate {
    ApproveViewController *approveVC = [[ApproveViewController alloc] init];
    approveVC.selectedCoordinate = selectedCoordinate;
    approveVC.selectedDate = selectedDate;
    [self presentNatGeoViewController:approveVC completion:^(BOOL finished) {
        NSLog(@"Present complete!");
    }];
//    [self.navigationController pushViewController:approveVC animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GMSMapViewDelegate

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    NSLog(@"You tapped at %f,%f", coordinate.latitude, coordinate.longitude);
    [self createMarkerWithCoordinates:coordinate];
    selectedCoordinate = coordinate;
    
    
}

- (void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture {
    NSLog(@"mapView willMove:");
    NSLog(gesture ? @"Yes" : @"No");
}

- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position {
    //    NSLog(@"mapView didChangeCameraPosition: %@", position);
}

- (void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position {
    NSLog(@"mapView idleAtCameraPosition: %@", position);
}

- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
    return geocoderView;
}

#pragma mark - Map Helper

-(void)drawCircleWithCenter:(CLLocationCoordinate2D)circleCenter andRadius:(CGFloat)radius {
    GMSCircle *circ = [GMSCircle circleWithPosition:circleCenter
                                             radius:radius];
    
    circ.fillColor = [UIColor colorWithRed:0.25 green:0 blue:0 alpha:0.05];
    circ.strokeColor = [UIColor redColor];
    circ.strokeWidth = 5;
    circ.map = self.googleMapView;
}

-(void)drawPolygonWithCenter:(CLLocationCoordinate2D)polygonCenter andRadius:(CGFloat)radius {
    GMSMutablePath *path = [GMSMutablePath path];
    [path addCoordinate:CLLocationCoordinate2DMake(polygonCenter.longitude, polygonCenter.latitude)];
    [path addCoordinate:CLLocationCoordinate2DMake(polygonCenter.longitude, polygonCenter.latitude)];
    [path addCoordinate:CLLocationCoordinate2DMake(polygonCenter.longitude, polygonCenter.latitude)];
    [path addCoordinate:CLLocationCoordinate2DMake(polygonCenter.longitude, polygonCenter.latitude)];
    [path addCoordinate:CLLocationCoordinate2DMake(polygonCenter.longitude, polygonCenter.latitude)];
    
    GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
    rectangle.map = self.googleMapView;
}

-(void)createMarkerWithCoordinates:(CLLocationCoordinate2D)coordinate {
//    [self drawCircleWithCenter:coordinate andRadius:100];
    [self.googleMapView clear];
    GMSMarker *marker = [GMSMarker markerWithPosition:coordinate];
    marker.title = @"Loading";
    marker.snippet = @"";
    marker.animated = YES;
    //            marker.icon = [GMSMarker markerImageWithColor:[UIColor whiteColor]];
    markerCount++;
    switch (markerCount) {
        case 1:
            marker.icon = [UIImage imageNamed:@"marker_blue.png"];
            break;
        case 2:
            marker.icon = [UIImage imageNamed:@"marker_green.png"];
            break;
        case 3:
            marker.icon = [UIImage imageNamed:@"marker_pink.png"];
            markerCount = 0;
            break;
            
        default:
            break;
    }
    
    
    marker.infoWindowAnchor = CGPointMake(0.5, 0.0);
    
    marker.map = self.googleMapView;
    

    
    id handler = ^(GMSReverseGeocodeResponse *response, NSError *error) {
        if (error == nil) {
            GMSReverseGeocodeResult *result = response.firstResult;
            NSLog(@"result.addressLine1 %@", result.addressLine1);
            NSLog(@"result.addressLine2 %@", result.addressLine2);
            addressLabel.text = result.addressLine1;
            marker.title = result.addressLine1;
            marker.snippet = result.addressLine2;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
                self.googleMapView.selectedMarker = marker;
            });
            
        
        }
    };
    GMSGeocoder *geocoder_ = [GMSGeocoder geocoder];
    [geocoder_ reverseGeocodeCoordinate:coordinate completionHandler:handler];
}

- (UIImage *)createMapSnapshot:(GMSMapView *)mapView{
    UIGraphicsBeginImageContext(mapView.frame.size);
    [mapView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenShotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenShotImage;
}

#pragma mark - Movement
-(void)updateLocationWithCoordinate:(CLLocationCoordinate2D)coordinate {
    GMSCameraUpdate *camUpdate = [GMSCameraUpdate setTarget:coordinate];
    [self.googleMapView animateWithCameraUpdate:camUpdate];
    GMSCameraPosition *fancy = [GMSCameraPosition cameraWithLatitude:coordinate.latitude longitude:coordinate.longitude zoom:18 bearing:0 viewingAngle:45];
    [self.googleMapView setCamera:fancy];
}

-(void)updateHeading:(CLLocationDirection)heading {
    [self.googleMapView animateToBearing:heading];
}

#pragma mark - CoreLocation Notifications
- (void)startStandardUpdates
{
    NSLog(@"startStandardUpdates");
    // Create the location manager if this object does not
    // already have one.
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // Set a movement threshold for new events.
    locationManager.distanceFilter = 50;
    
    [locationManager startUpdatingLocation];
}

- (void)startHeadingEvents {
    if (!locationManager) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
    }
    
    // Start heading updates.
    if ([CLLocationManager headingAvailable]) {
        locationManager.headingFilter = 5;
        [locationManager startUpdatingHeading];
    }
}

#pragma mark - CoreLocation delegate
// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              location.coordinate.latitude,
              location.coordinate.longitude);
        [self updateLocationWithCoordinate:location.coordinate];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    
    if (newHeading.headingAccuracy < 0)
        return;
    
    // Use the true heading if it is valid.
    CLLocationDirection  theHeading = ((newHeading.trueHeading > 0) ?
                                       newHeading.trueHeading : newHeading.magneticHeading);
    
    NSLog(@"trueHeading %+.6f, magneticHeading %+.6f\n",
          newHeading.trueHeading,
          newHeading.magneticHeading);
    
    [self updateHeading:theHeading];
}

#pragma mark - MWDatePickerDelegate
-(void)datePicker:(MWDatePicker *)picker didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"datePicker didSelectRow %i, inComponent %i", row, component);
    NSLog(@"%@",[picker getDate]);
    selectedDate = [picker getDate];
}

- (UIColor *) backgroundColorForDatePicker:(MWDatePicker *)picker
{
    return [UIColor blackColor];
}


- (UIColor *) datePicker:(MWDatePicker *)picker backgroundColorForComponent:(NSInteger)component
{
    
    switch (component) {
        case 0:
            return [UIColor blackColor];
        case 1:
            return [UIColor blackColor];
        case 2:
            return [UIColor blackColor];
        default:
            return 0; // never
    }
}


- (UIColor *) viewColorForDatePickerSelector:(MWDatePicker *)picker
{
    return [UIColor grayColor];
}

@end
