//
//  CollageView.m
//  Moments
//
//  Created by Dhwanit Mehta on 12/16/14.
//  Copyright (c) 2014 Dhwanit Mehta. All rights reserved.
//

#import "CollageView.h"

@interface CollageView ()

@end

@implementation CollageView

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *img1 = [UIImage imageWithData:[[[NSUserDefaults standardUserDefaults]arrayForKey:@"photos"]objectAtIndex:0]];
    UIImage *img2 = [UIImage imageWithData:[[[NSUserDefaults standardUserDefaults]arrayForKey:@"photos"]objectAtIndex:1]];
    UIImage *img3 = [UIImage imageWithData:[[[NSUserDefaults standardUserDefaults]arrayForKey:@"photos"]objectAtIndex:2]];
    UIImage *img4 = [UIImage imageWithData:[[[NSUserDefaults standardUserDefaults]arrayForKey:@"photos"]objectAtIndex:3]];
    self.image1.contentMode = UIViewContentModeScaleAspectFit;
    self.image2.contentMode = UIViewContentModeScaleAspectFit;
    self.image3.contentMode = UIViewContentModeScaleAspectFit;
    self.image4.contentMode = UIViewContentModeScaleAspectFit;
    [self.image1 setImage:img1];
    [self.image2 setImage:img2];
    [self.image3 setImage:img3];
    [self.image4 setImage:img4];
    
    self.navigationItem.title = @"Moments Maker";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)sharePicture {
    UIImage *image = [self createImageFromContext];
    NSArray *postItems = @[image];
    UIActivityViewController *activityVC = [[UIActivityViewController
                                             alloc] initWithActivityItems:postItems
                                            applicationActivities:nil];
    [self presentViewController:activityVC animated:YES
                     completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIImage *)createImageFromContext{
    NSLog(@"createImageFromContext - dump view contents to image");
    CGRect contextRect = CGRectMake(0, 0, self.collageView.bounds.size.width,
                                    self.collageView.bounds.size.height);
    UIGraphicsBeginImageContext(contextRect.size);
    // get whatever the user drew in the view
    [self.collageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    // create a new image with it
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
