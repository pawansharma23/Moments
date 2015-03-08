//
//  ImageCell.m
//  Moments
//
//  Created by Dhwanit Mehta on 12/15/14.
//  Copyright (c) 2014 Dhwanit Mehta. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell


//reference https://stackoverflow.com/questions/20566393/uicollectionview-images-not-showing
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_imageView];
    return self;
}

@end
