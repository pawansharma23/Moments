//
//  Profiles.m
//  Moments
//
//  Created by Dhwanit Mehta on 12/11/14.
//  Copyright (c) 2014 Dhwanit Mehta. All rights reserved.
//

#import "Profiles.h"

@implementation Profiles

-(id)init{
    return [self initWithName:@"nil" profileURL:@"nil"];
}

-(id)initWithName:(NSString *)name profileURL:(NSString *)profile{
    self = [super init];
    if(self != nil){
        self.pictureURLs = [[NSMutableArray alloc]init];
        self.pictureThumbs = [[NSMutableArray alloc]init];
        self.ids = [[NSMutableArray alloc]init];
        self.name = name;
        self.profileImageURL = profile;
    }
    return self;
}

-(void)addIdsofPictures:(NSString *)ids{
    [self.ids addObject:ids];
}

+(id)profile{
    Profiles *profile = [[Profiles alloc]init];
    
    return profile;
}

-(void)addThumbWithURL:(NSString *)url{
    [self.pictureThumbs addObject:url];
}

-(void)addImageWithURL:(NSString *)url{
    [self.pictureURLs addObject:url];
}

-(NSString *)description{
    NSString *retval = [NSString stringWithFormat:@"Name: %@,\nProfilePicURL: %@,\nTaggedPicsURLs: %@\nThumbnails: %@\nIDs: %@",self.name,self.profileImageURL,self.pictureURLs,self.pictureThumbs,self.ids];
    return retval;
}

@end
