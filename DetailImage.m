//
//  DetailImage.m
//  Moments
//
//  Created by Dhwanit Mehta on 12/15/14.
//  Copyright (c) 2014 Dhwanit Mehta. All rights reserved.
//

#import "DetailImage.h"

@interface DetailImage ()

@end

@implementation DetailImage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self set:self.selectedImage];
    [self.image setImage:self.selectedImage];
    self.image.contentMode = UIViewContentModeScaleAspectFit;
    [self.checkView check:self.ids];
    self.checkView.layer.zPosition=1;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)set:(UIImage*)img{
    self.image = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.image];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)tapped{
    [self.checkView tapped:self.ids photo:self.image.image];
}

@end
