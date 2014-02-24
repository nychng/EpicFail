//
//  PictureMapViewController.h
//  EpicFail
//
//  Created by Nai Chng on 24/2/14.
//  Copyright (c) 2014 NYC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface PictureMapViewController : UIViewController
<MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *map;

@end
