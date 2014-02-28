//
//  ImageCell.m
//  EpicFail
//
//  Created by Nai Chng on 20/2/14.
//  Copyright (c) 2014 NYC. All rights reserved.
//

#import "ImageCell.h"

@interface ImageCell ()


@end

@implementation ImageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIActivityIndicatorView *):(UIActivityIndicatorView *)spinner
{
    if (!_spinner) {
        _spinner = [[UIActivityIndicatorView alloc] init];
    }
    [_spinner startAnimating];
    return _spinner;
}

@end
