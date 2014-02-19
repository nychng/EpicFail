//
//  SettingsViewController.m
//  EpicFail
//
//  Created by Nai Chng on 19/2/14.
//  Copyright (c) 2014 NYC. All rights reserved.
//

#import "SettingsViewController.h"
#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface SettingsViewController ()
@property (strong, nonatomic) IBOutlet UITableViewCell *logoutCell;


@end

@implementation SettingsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == self.logoutCell) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Are You Sure?"
                                                        message:@"123"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Logout", nil];
        [alert show];
    }

}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // user clicked cancel
    if (buttonIndex == 0) {

    } else if (buttonIndex == 1) {  // user clicked logout
        NSLog(@"%@", [PFUser currentUser]);
        [PFUser logOut]; // Log out
        NSLog(@"%@", [PFUser currentUser]);
        //LoginViewController *viewController = [[LoginViewController alloc] init];
        //[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
        //[self.navigationController popToViewController:(UIViewController *)viewController animated:YES];
        //[self.navigationController popToRootViewControllerAnimated:YES];
        [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
