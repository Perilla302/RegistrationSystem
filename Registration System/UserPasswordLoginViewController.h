//
//  UserPasswordLoginViewController.h
//  Registration System
//
//  Created by Hongjin Su on 10/22/15.
//  Copyright © 2015 Hongjin Su. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface UserPasswordLoginViewController : UIViewController

@property (strong, nonatomic) NSString * DatabasePath;
@property (nonatomic) sqlite3 *ContactDB;

@end
