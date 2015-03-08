//
//  LoginScreen.h
//  Moments
//
//  Created by Dhwanit Mehta on 12/11/14.
//  Copyright (c) 2014 Dhwanit Mehta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "Profiles.h"

@interface LoginScreen: UIViewController <FBLoginViewDelegate>

@property(strong,nonatomic)    NSMutableArray *profiles;
@property(assign,nonatomic) BOOL fetchComplete;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (strong, nonatomic) IBOutlet UIView *hiddenView;
@property (assign,nonatomic) BOOL isLoggedIn;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@end

