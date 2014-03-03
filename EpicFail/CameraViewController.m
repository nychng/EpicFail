//
//  CameraViewController.m
//  EpicFail
//
//  Created by Nai Chng on 19/2/14.
//  Copyright (c) 2014 NYC. All rights reserved.
//

#import "CameraViewController.h"
#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import <ImageIO/ImageIO.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface CameraViewController ()
@property (strong, nonatomic) IBOutlet UITextView *description;
@property (strong, nonatomic) IBOutlet UIImageView *capturedImage;
//@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@end

@implementation CameraViewController

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

- (void)setupLocationManager
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [self.locationManager startUpdatingLocation];
}

- (IBAction)cancel:(id)sender {
    self.capturedImage.image = nil;
    self.description.text = nil;
    [self.tabBarController setSelectedIndex:0];
}

- (IBAction)save:(id)sender {
    [self uploadImage];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidLoad];
    [self startCameraControllerFromViewController:self usingDelegate:self];
}

- (void)uploadImage
{
    [self setupLocationManager];
    self.location = self.locationManager.location;
    
    CLLocationCoordinate2D coord;
    coord.longitude = self.location.coordinate.longitude;
    coord.latitude = self.location.coordinate.latitude;
    // or a one shot fill
    coord = [self.location coordinate];
    
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coord.latitude
                                                  longitude:coord.longitude];
    
    NSData *imageData = UIImageJPEGRepresentation(self.capturedImage.image, 0.05f);
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
    
    // Save PFFile
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hide old HUD, show completed HUD (see example for code)
            
            // Create a PFObject around a PFFile and associate it with the current user
            PFObject *userPhoto = [PFObject objectWithClassName:@"UserPhoto"];
            [userPhoto setObject:imageFile forKey:@"imageFile"];
            [userPhoto setObject:geoPoint forKey:@"location"];
            
            // Set the access control list to current user for security purposes
            userPhoto.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
            
            PFUser *user = [PFUser currentUser];
            [userPhoto setObject:user forKey:@"user"];
            
            [userPhoto setObject:self.description.text forKey:@"description"];
            
            [userPhoto saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    //[self refresh:nil];
                }
                else{
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
        else{
            //[HUD hide:YES];
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    } progressBlock:^(int percentDone) {
        // Update your progress spinner here. percentDone will be between 0 and 100.
        //HUD.progress = (float)percentDone/100;
    }];
    
    [self.tabBarController setSelectedIndex:0];
}

- (BOOL)startCameraControllerFromViewController:(UIViewController *)controller
                                  usingDelegate: (id <UIImagePickerControllerDelegate,
                                                  UINavigationControllerDelegate>)delegate {
    
    if ((![UIImagePickerController isSourceTypeAvailable:
           UIImagePickerControllerSourceTypeCamera]) || !delegate || !controller) {
        return NO;
    }
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    cameraUI.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    cameraUI.allowsEditing = YES;
    cameraUI.delegate = self;
    [controller presentViewController:cameraUI animated:NO completion:nil];
    
    return YES;
}

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    UIImage *image =  [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:NO completion:nil];
    self.capturedImage.image = image;
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //dismisses the camera controller and push back to the home screen
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.tabBarController setSelectedIndex:0];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


@end
