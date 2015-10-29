//
//  ViewController.m
//  Registration System
//
//  Created by Hongjin Su on 10/22/15.
//  Copyright © 2015 Hongjin Su. All rights reserved.
//

#import "ViewController.h"
#import "RegisterViewController.h"
#import "EmailLoginViewController.h"
#import "MyObject.h"
#import <sqlite3.h>

@interface ViewController ()

@property (strong, nonatomic) NSString * databasePath;
@property (nonatomic) sqlite3 *contactDB;
@property (strong, nonatomic) NSMutableArray *array_ObjInfo;
@property (weak, nonatomic) IBOutlet UILabel *label_status;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Database call
    [self DatabaseCall];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//    double delayInSeconds = 2.0;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        [self performSegueWithIdentifier:@"splashScreenSegue" sender:self];
//    });
//}

#pragma mark The database
- (void)DatabaseCall {
    
    NSArray *dirPaths;
    NSString *docsDir;
    
    // Get the documents directory // Mandontary
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"RegInfo.db"]];
    
    // To declare a file manager object to search the file
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    // To see if the RegInfo.db is there
    if ([filemgr fileExistsAtPath: _databasePath ] == NO) {// this is first time, u r installing the app.
        // If not
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK) {
            
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS REGINFO (ID INTEGER PRIMARY KEY AUTOINCREMENT, FirstName TEXT, LastName TEXT, Email TEXT, PhoneNumber TEXT, Address TEXT, UserName TEXT, Password TEXT)";
            
            if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                
                _label_status.text = @"Failed to create table";
            }
            _label_status.text = @"Created database sucessfully";
            sqlite3_close(_contactDB);
            [self performSelector:@selector(onTick:) withObject:nil afterDelay:2.0];
        }
        else {
            
            _label_status.text = @"Failed to open/create database";
        }
    }
    else {
        
        _label_status.text = @"Data base already created";
        [self performSelector:@selector(onTick:) withObject:nil afterDelay:2.0];
    }
}

// To count to 3 and database label is DISPEARED! :D
- (void) onTick:(NSTimer *)timer {
    
    _label_status.text = @"";
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier]isEqualToString:@"RegisterModal"]) {
        RegisterViewController *objRVC = [segue destinationViewController];
        objRVC.DatabasePath = _databasePath;
        objRVC.ContactDB = _contactDB;
    }
    else if ([[segue identifier]isEqualToString:@"EmailLoginModal"]) {
        EmailLoginViewController *objELVC = [segue destinationViewController];
        objELVC.DatabasePath = _databasePath;
        objELVC.ContactDB = _contactDB;
    }
}

@end
