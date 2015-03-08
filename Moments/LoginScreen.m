//
//  ViewController.m
//  Moments
//
//  Created by Dhwanit Mehta on 12/11/14.
//  Copyright (c) 2014 Dhwanit Mehta. All rights reserved.
//

#import "LoginScreen.h"
#import "Friends.h"

@interface LoginScreen ()

@end

//reference for notification usage https://stackoverflow.com/questions/23447325/ios-objective-c-wait-for-async-process

@implementation LoginScreen
- (IBAction)loginClicked:(id)sender {
    self.loginButton.userInteractionEnabled = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(fetchDidComplete)
                                                 name:@"fetchDidComplete"
                                               object:nil];
    if (self.isLoggedIn) {
        self.hiddenView.hidden = NO;
        [self.loading startAnimating];
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile",@"user_photos",@"user_friends"] allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            [self createProfilePictureDict];
        }];
    }
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [[FBSession activeSession]handleOpenURL:url];
}

-(void)fetchDidComplete{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"fetchDidComplete"
                                                  object:nil];

    UIStoryboard *storyboard = self.storyboard;
    UINavigationController *navVC = [storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
    if ([self.profiles count]!=0) {
        Friends *friend = [[navVC viewControllers] objectAtIndex:0];
        friend.profiles = self.profiles;
        [self.loading stopAnimating];
        self.hiddenView.hidden = YES;
        [self presentViewController:navVC animated:YES completion:nil];
    }
    else{
        [self.loading stopAnimating];
        self.hiddenView.hidden = YES;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Moments" message:@"Some Error Occured\nCould not get Data\nTry Again Later!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)createTagedPictureDict{
    [FBRequestConnection startWithGraphPath:@"me/photos?fields=tags,source,from,picture.type(large)&limit=1000" parameters:nil HTTPMethod:@"GET" completionHandler:^( FBRequestConnection *connection, id result, NSError *error){
        NSDictionary *dict = [result objectForKey:@"data"];
        for(NSDictionary *i in dict){
            NSDictionary *tags_data = [[i objectForKey:@"tags"] objectForKey:@"data"];
            for(NSDictionary *k in tags_data){
                NSString *name = [k objectForKey:@"name"];
                NSString *source = [i objectForKey:@"source"];
                NSString *thumb = [i objectForKey:@"picture"];
                NSString *ids = [i objectForKey:@"id"];
                for(Profiles *p in self.profiles)
                    if([p.name caseInsensitiveCompare:name] == NSOrderedSame){
                        [p addImageWithURL:source];
                        [p addThumbWithURL:thumb];
                        [p addIdsofPictures:ids];
                    }
                }
            }
            self.fetchComplete = true;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"fetchDidComplete"
                              object:self
                            userInfo:nil];
        }
     ];
}

-(void)createProfilePictureDict{
    [FBRequestConnection startWithGraphPath:@"me/taggable_friends?fields=picture.type(square),name&limit=5000" parameters:nil HTTPMethod:@"GET" completionHandler:^(FBRequestConnection *connection, id result, NSError *error){
        if(error){
            NSLog(@"error %@",error);
        }
        NSDictionary *dict = [result objectForKey:@"data"];
        for (NSDictionary *i in dict) {
            NSString *name = [i objectForKey:@"name"];
            NSString *picture = [[[i objectForKey:@"picture"] objectForKey:@"data"]objectForKey:@"url"];
            Profiles *p = [[Profiles alloc]initWithName:name profileURL:picture];
            [self.profiles addObject:p];
        }
        [self createTagedPictureDict];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginButton.userInteractionEnabled = YES;
    self.isLoggedIn = true;
    [self.navigationItem setHidesBackButton:YES animated:YES];
    self.navigationController.navigationBarHidden =YES;
    [FBSession class];
    self.fetchComplete = false;
    [self.loading stopAnimating];
    self.hiddenView.hidden = YES;
    self.profiles =[[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error
{
    NSString *alertMessage, *alertTitle;
    
    if ([FBErrorUtility shouldNotifyUserForError:error])
    {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        self.isLoggedIn = false;
        
    }
    else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession)
    {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        self.isLoggedIn = false;
        
    }
    else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled)
    {
        NSLog(@"user cancelled login");
        self.isLoggedIn = false;
        
    }
    else
    {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
        self.isLoggedIn = false;
    }
    
    if (alertMessage)
    {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

@end
