//
//  DetailImage.h
//  Moments
//
//  Created by Dhwanit Mehta on 12/15/14.
//  Copyright (c) 2014 Dhwanit Mehta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSCheckMark.h"

@interface DetailImage : UIViewController

@property(strong,nonatomic) IBOutlet UIImageView *image;

@property(strong,nonatomic) UIImage *selectedImage;

@property(strong,nonatomic) NSString *ids;

@property (strong,nonatomic) IBOutlet SSCheckMark *checkView;

-(IBAction)tapped;
@end
