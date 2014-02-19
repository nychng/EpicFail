//
//  FirstViewController.m
//  EpicFail
//
//  Created by Nai Chng on 17/2/14.
//  Copyright (c) 2014 NYC. All rights reserved.
//

#import "MainViewController.h"
#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface MainViewController ()
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;
@property (strong, nonatomic) id<FBGraphUser> loggedInUser;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


//    FBLoginView *loginView = [[FBLoginView alloc] init];
//    loginView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"modalLogin"]) {
        // do something
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    self.nameLabel.text = user.name;
    self.profilePictureView.profileID = user.id;
    self.loggedInUser = user;
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    self.statusLabel.text = @"You're logged in as";
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.profilePictureView.profileID = nil;
    self.nameLabel.text = @"";
    self.statusLabel.text= @"You're not logged in!";
}
@end
