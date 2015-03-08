//
//  Friends.h
//  Moments
//
//  Created by Dhwanit Mehta on 12/11/14.
//  Copyright (c) 2014 Dhwanit Mehta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Profiles.h"

@interface Friends : UITableViewController<UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate>

@property(strong,nonatomic)    NSMutableArray *profiles;

@property (strong,nonatomic) NSArray *searchResults;

@property (assign,nonatomic) BOOL isSearch;

@end
