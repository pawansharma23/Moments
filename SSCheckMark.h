//
//  SSCheckMark.h
//  Moments
//
//  Created by Dhwanit Mehta on 12/15/14.
//  Copyright (c) 2014 Dhwanit Mehta. All rights reserved.
//

#import <UIKit/UIKit.h>

//reference for this code:https://stackoverflow.com/questions/18977527/how-do-i-display-the-standard-checkmark-on-a-uicollectionviewcell/19332828#19332828

typedef NS_ENUM( NSUInteger, SSCheckMarkStyle )
{
    SSCheckMarkStyleOpenCircle,
    SSCheckMarkStyleGrayedOut
};

@interface SSCheckMark : UIView

@property (readwrite) bool checked;
@property (readwrite) SSCheckMarkStyle checkMarkStyle;

-(void)tapped:(NSString*)ids photo:(UIImage*)img;

-(void)check:(NSString*)ids;

@end