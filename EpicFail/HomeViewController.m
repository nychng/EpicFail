//
//  SecondViewController.m
//  EpicFail
//
//  Created by Nai Chng on 17/2/14.
//  Copyright (c) 2014 NYC. All rights reserved.
//

#import "HomeViewController.h"
#import "ImageCell.h"
#import <Parse/Parse.h>
#import "TTTTimeIntervalFormatter.h"

@interface HomeViewController ()
@property (nonatomic, strong) NSMutableArray *imageList;


@end

@implementation HomeViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self fetchImages];
}

- (IBAction)refresh:(id)sender {
    [self fetchImages];
}


- (void)fetchImages
{
    PFQuery *query = [PFQuery queryWithClassName:@"UserPhoto"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"user"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects.count > 0) {
            for (PFObject *eachObject in objects) {
                [self.imageList addObject:[eachObject objectId]];
            }
            self.imageList = [NSMutableArray arrayWithArray:objects];
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
            [self.refreshControl removeFromSuperview];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.imageList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";

    ImageCell *cell = (ImageCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[ImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    PFObject *object = self.imageList[indexPath.row];
    PFFile *file = [object objectForKey:@"imageFile"];
    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:data];
            cell.image.image = image;
            [cell.spinner stopAnimating];
            [cell.spinner removeFromSuperview];
        }
    }];
    
    cell.description.text = [object objectForKey:@"description"];

    NSDate *date = object.createdAt;
    TTTTimeIntervalFormatter *timeIntervalFormatter = [[TTTTimeIntervalFormatter alloc] init];
    NSString *dateString = [timeIntervalFormatter stringForTimeInterval:[date timeIntervalSinceNow]]; // "just now"
    cell.date.text = dateString;
    
    PFUser *user = [object objectForKey:@"user"];
    cell.name.text = [user objectForKey:@"username"];
  
    return cell;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
