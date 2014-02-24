//
//  PictureMapViewController.m
//  EpicFail
//
//  Created by Nai Chng on 24/2/14.
//  Copyright (c) 2014 NYC. All rights reserved.
//

#import "PictureMapViewController.h"
#import <CoreLocation/CoreLocation.h>


@interface PictureMapViewController ()

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;

@end

@implementation PictureMapViewController

- (CLLocation *)location:(CLLocation *)location
{
    if (!_location) {
        _location = [[CLLocation alloc] init];
    }
    
    return _location;
}

- (CLLocationManager *)locationManager:(CLLocation *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    _locationManager.delegate = self;
    
    return _locationManager;
}

//- (void)getLocation:(id)sender {
//    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
//    [self.locationManager startUpdatingLocation];
//}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // update current location here
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupLocationManager];

}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self.map setCenterCoordinate:self.map.userLocation.location.coordinate animated:YES];
}


- (void)setupLocationManager
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
