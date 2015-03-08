//
//  SettingsView.h
//  Moments
//
//  Created by Dhwanit Mehta on 12/16/14.
//  Copyright (c) 2014 Dhwanit Mehta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface SettingsView : UIViewController <FBLoginViewDelegate>

@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePicture;

@property (strong,nonatomic) IBOutlet FBLoginView *loginView;
@property (strong, nonatomic) IBOutlet UILabel *username;

@end
