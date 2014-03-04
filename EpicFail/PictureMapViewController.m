//
//  PictureMapViewController.m
//  EpicFail
//
//  Created by Nai Chng on 24/2/14.
//  Copyright (c) 2014 NYC. All rights reserved.
//

#import "PictureMapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>



@interface PictureMapViewController ()

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@property (nonatomic, strong) NSMutableArray *imageList;

@end

@implementation PictureMapViewController

# pragma - Getters

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

# pragma - Delegates & Data Sources

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // update current location here
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupLocationManager];
    [self fetchImages];

}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self.map setCenterCoordinate:self.map.userLocation.location.coordinate animated:YES];
}

//- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views
//{
//    MKAnnotationView *annotationView = [views objectAtIndex:0];
//    id<MKAnnotation> mp = [annotationView annotation];
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mp coordinate] ,350,350);
//    
//    [mv setRegion:region animated:YES];
//    
//    [self.map selectAnnotation:mp animated:YES];
//    
//}

# pragma - Helper Functions


- (void)populateMap
{
    for (PFObject *obj in self.imageList) {

        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        PFGeoPoint *coordinate = [obj objectForKey:@"location"];
        point.coordinate = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
        point.title = [obj objectForKey:@"description"];
        point.subtitle = @"I'm here!!!";
        
        [self.map addAnnotation:point];

    }
}

- (void)fetchImages
{
    PFQuery *query = [PFQuery queryWithClassName:@"UserPhoto"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects.count > 0) {
            self.imageList = [NSMutableArray arrayWithArray:objects];
            [self.map setRegion:self.map.region animated:TRUE];
            [self populateMap];
        }
    }];
}

- (void)setupLocationManager
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [self.locationManager startUpdatingLocation];
}


@end
