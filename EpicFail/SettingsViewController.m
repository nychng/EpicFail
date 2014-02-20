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
#import "AppDelegate.h"

@interface SettingsViewController ()
@property (strong, nonatomic) IBOutlet UITableViewCell *logoutCell;


@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

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

    if (buttonIndex == 0) {

    } else if (buttonIndex == 1) {  // user clicked logout
        [PFUser logOut]; // Log out

//        [self.navigationController popToRootViewControllerAnimated:YES];
//
//        NSLog(@"%@", self.navigationController.storyboard);
        
        AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
        
        UIViewController* rootController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginViewController"];
        
        UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:rootController];
        appDelegateTemp.window.rootViewController = navigation;


        
    }
}


@end
