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
#import "ProfileImageCell.h"
#import "ProfileImageViewController.h"

@interface ProfileViewController ()
@property (strong, nonatomic) IBOutlet UILabel *pictureCount;
@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;
@property (strong, nonatomic) NSMutableArray *imageList;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation ProfileViewController

- (NSMutableArray *)_imageList
{
    if (!_imageList) {
        _imageList = [[NSMutableArray alloc] init];
    }
    return _imageList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self fetchImageObjects];
}

- (void)fetchImageObjects {
    PFQuery *query = [PFQuery queryWithClassName:@"UserPhoto"];
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects.count > 0) {
            self.imageList = [NSMutableArray arrayWithArray:objects];
            [self.collectionView reloadData];
        }
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.imageList count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    ProfileImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier
                                                                           forIndexPath:indexPath];

    PFObject *object = self.imageList[indexPath.row];
    PFFile *file = [object objectForKey:@"imageFile"];
    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            cell.imageView.image = [UIImage imageWithData:data];
            [cell.spinner stopAnimating];
            [cell.spinner removeFromSuperview];
        }
    }];
    
    return cell;
}

- (void)setupView
{
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            NSDictionary *userData = (NSDictionary *)result;
            self.title = userData[@"name"];
            self.profilePictureView.profileID = userData[@"id"];
        }}];
    
    // Get picture count
    PFQuery *query = [PFQuery queryWithClassName:@"UserPhoto"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (!error) {
            self.pictureCount.text = [NSString stringWithFormat:@"%d", number];
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender  {
    if ([segue.identifier isEqualToString:@"profileImageView"]) {
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] lastObject];
        ProfileImageViewController *pivc = [segue destinationViewController];
        pivc.object = self.imageList[indexPath.row];
    }
}


@end

