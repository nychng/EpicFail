//
//  LoginViewController.h
//  EpicFail
//
//  Created by Nai Chng on 17/2/14.
//  Copyright (c) 2014 NYC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
- (IBAction)loginButtonTouchHandler:(id)sender;

@end
