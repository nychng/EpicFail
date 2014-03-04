//
//  ProfileImageViewController.m
//  EpicFail
//
//  Created by Nai Chng on 28/2/14.
//  Copyright (c) 2014 NYC. All rights reserved.
//

#import "ProfileImageViewController.h"


@interface ProfileImageViewController ()


@end

@implementation ProfileImageViewController

- (PFObject *)_object
{
    if (!_object) {
        _object = [[PFObject alloc] init];
    }
    return _object;
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
    [self loadImage];
}

- (void)loadImage {
    PFFile *file = [self.object objectForKey:@"imageFile"];
    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            self.image.image = [UIImage imageWithData:data];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
