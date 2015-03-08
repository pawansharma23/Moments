//
//  SettingsView.m
//  Moments
//
//  Created by Dhwanit Mehta on 12/16/14.
//  Copyright (c) 2014 Dhwanit Mehta. All rights reserved.
//

#import "SettingsView.h"
#import "LoginScreen.h"

@interface SettingsView ()

@end

@implementation SettingsView

- (void)viewDidLoad {
    [super viewDidLoad];
    [FBSession class];
    [FBLoginView class];
    [FBProfilePictureView class];
    self.loginView.readPermissions = @[@"public_profile"];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Settings";
}

-(BOOL) application:(UIApplication*) application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
    self.username.text = user.name;
    self.profilePicture.profileID = user.objectID;
}

-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Logut" message:@"Successfully logged out of Facebook" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [self performSegueWithIdentifier:@"toLoginScreen" sender:self];
//    LoginScreen *loginScreen = [[LoginScreen alloc]init];
//    [self.navigationController pushViewController:loginScreen animated:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"toLoginScreen"]) {
        LoginScreen *loginScreen = (LoginScreen*)segue.destinationViewController;
    }
}

@end
