//
//  CameraViewController.m
//  EpicFail
//
//  Created by Nai Chng on 19/2/14.
//  Copyright (c) 2014 NYC. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()
@property (nonatomic, strong) UIImagePickerController *imagePicker;

@end

@implementation CameraViewController

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
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.imagePicker = [[UIImagePickerController alloc] init];
    [self startCameraControllerFromViewController: self
                                    usingDelegate: self];

    [super viewDidLoad];


}

- (BOOL)startCameraControllerFromViewController:(UIViewController*)controller
                                   usingDelegate:(id <UIImagePickerControllerDelegate,
                                                  UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    cameraUI.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    
    cameraUI.allowsEditing = NO;
    cameraUI.delegate = delegate;
    [controller presentViewController: cameraUI animated: YES completion:nil];
    return YES;
}


@end
