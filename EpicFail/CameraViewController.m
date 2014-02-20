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

@interface CameraViewController ()
@property (strong, nonatomic) IBOutlet UITextView *description;
@property (strong, nonatomic) IBOutlet UIImageView *capturedImage;
//@property (nonatomic, strong) UIImagePickerController *imagePicker;
@end

@implementation CameraViewController

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
    NSData *imageData = UIImageJPEGRepresentation(self.capturedImage.image, 0.05f);
    
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
    
    // Save PFFile
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hide old HUD, show completed HUD (see example for code)
            
            // Create a PFObject around a PFFile and associate it with the current user
            PFObject *userPhoto = [PFObject objectWithClassName:@"UserPhoto"];
            [userPhoto setObject:imageFile forKey:@"imageFile"];
            
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
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    self.capturedImage.image = image;
    [picker dismissViewControllerAnimated:NO completion:nil];
    
    // Resize image
    UIGraphicsBeginImageContext(CGSizeMake(640, 960));
    [image drawInRect: CGRectMake(0, 0, 640, 960)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
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
