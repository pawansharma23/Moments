//
//  ImageBrowser.h
//  Moments
//
//  Created by Dhwanit Mehta on 12/15/14.
//  Copyright (c) 2014 Dhwanit Mehta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Profiles.h"
#import "ImageCell.h"

@interface ImageBrowser : UIViewController <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong,nonatomic) Profiles *selectedProfile;

@property(nonatomic, strong) IBOutlet UICollectionView *collectionView;

@property (strong,nonatomic) NSArray *photos;

@property(strong,nonatomic)NSString *selectedImage;

@property(strong,nonatomic) NSString *ids;

-(IBAction)tapped:(id)sender;

@end
