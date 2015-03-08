//
//  Profiles.h
//  Moments
//
//  Created by Dhwanit Mehta on 12/11/14.
//  Copyright (c) 2014 Dhwanit Mehta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Profiles : NSObject

@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *profileImageURL;
@property(strong,nonatomic) NSMutableArray *pictureURLs;
@property(strong,nonatomic) NSMutableArray *pictureThumbs;
@property(strong,nonatomic) NSMutableArray *ids;

-(id)initWithName:(NSString*)name profileURL:(NSString*) profile;

-(void) addImageWithURL:(NSString*)url;

-(void) addThumbWithURL:(NSString*)url;

-(void) addIdsofPictures:(NSString*)ids;



+(id) profile;

@end
