//
//  AppDelegate.h
//  Moments
//
//  Created by Dhwanit Mehta on 12/11/14.
//  Copyright (c) 2014 Dhwanit Mehta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <FacebookSDK/FacebookSDK.h>
#import "Profiles.h"
#import "LoginScreen.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,FBLoginViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong,nonatomic) NSMutableArray *profiles;

@property (strong,nonatomic) LoginScreen *loginScreen;



- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

