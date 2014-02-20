//
//  FirstViewController.m
//  EpicFail
//
//  Created by Nai Chng on 17/2/14.
//  Copyright (c) 2014 NYC. All rights reserved.
//

#import "ProfileViewController.h"
#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface ProfileViewController ()
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;

@end

@implementation ProfileViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView
{
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            NSDictionary *userData = (NSDictionary *)result;
            self.nameLabel.text = userData[@"name"];
            self.profilePictureView.profileID = userData[@"id"];
        }}];
}


@end

