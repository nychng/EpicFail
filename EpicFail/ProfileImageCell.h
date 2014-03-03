//
//  ProfileImageCell.h
//  EpicFail
//
//  Created by Nai Chng on 28/2/14.
//  Copyright (c) 2014 NYC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileImageCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end
