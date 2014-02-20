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

@interface HomeViewController ()
@property (nonatomic, strong) NSMutableArray *imageList;

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchImages];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchImages
{
    PFQuery *query = [PFQuery queryWithClassName:@"UserPhoto"];
    self.imageList = [NSMutableArray arrayWithArray:[query findObjects]];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        // If there are photos, we start extracting the data
//        // Save a list of object IDs while extracting this data
//        if (objects.count > 0) {
//            for (PFObject *eachObject in objects) {
//                [self.imageList addObject:[eachObject objectId]];
//            }
//            self.imageList = [NSMutableArray arrayWithArray:objects];
//        }
//    }];
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
    NSLog(@"%@", [object description]);
    PFFile *file = [object objectForKey:@"imageFile"];
    NSData *imageData = [file getData];
    UIImage *image = [UIImage imageWithData:imageData];
    cell.image.image = image;
    cell.description.text = [object objectForKey:@"description"];
  
    return cell;
}

@end
