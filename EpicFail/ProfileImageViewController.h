//
//  ProfileImageViewController.h
//  EpicFail
//
//  Created by Nai Chng on 28/2/14.
//  Copyright (c) 2014 NYC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ProfileImageViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) PFObject *object;
@end
