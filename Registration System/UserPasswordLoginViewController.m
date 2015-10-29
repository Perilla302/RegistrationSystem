//
//  UserPasswordLoginViewController.m
//  Registration System
//
//  Created by Hongjin Su on 10/22/15.
//  Copyright © 2015 Hongjin Su. All rights reserved.
//

#import "UserPasswordLoginViewController.h"
#import "WelcomeViewController.h"
#import "RegisterViewController.h"
#import <sqlite3.h>

@interface UserPasswordLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField_username;
@property (weak, nonatomic) IBOutlet UITextField *textField_password;
@property (strong, nonatomic) NSMutableArray *array_username;
@property (strong, nonatomic) NSMutableArray *array_password;
@property (strong, nonatomic) NSMutableArray *array_first;
@property (strong, nonatomic) NSMutableArray *array_last;
@property (nonatomic) int j;

@end

@implementation UserPasswordLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ButtonAction_UPLogin:(id)sender {
    
    [self checkUsernamePassword];
}

#pragma mark The method to check if username and password exists
- (void)checkUsernamePassword {

    const char *dbpath = [_DatabasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_ContactDB) == SQLITE_OK) {
        
        NSString *querySQL = @"SELECT * FROM reginfo"; // * is to display all the data
        
        const char *query_stmt = [querySQL UTF8String];
        
        NSLog(@"%d", sqlite3_prepare_v2(_ContactDB, query_stmt, -1, &statement, NULL));
        
        if (sqlite3_prepare_v2(_ContactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            
            _array_first =[NSMutableArray new];
            _array_last =[NSMutableArray new];
            _array_username =[NSMutableArray new];
            _array_password =[NSMutableArray new];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                NSString *first = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]; // To take firstname info out
                NSString *last = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)]; // To take lastname info out
                NSString *username = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)]; // To take username info out
                NSString *password = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)]; // To take password info out
                
                //                NSLog(@"The firstname is %@", first);
                //                NSLog(@"The lastname is %@", last);
                //                NSLog(@"The email is %@", email);
                // To store all the info to the arrays
                [_array_first addObject:first];
                [_array_last addObject:last];
                [_array_username addObject:username];
                [_array_password addObject:password];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_ContactDB);
    }
    
    // To check if the username exists
    BOOL username = NO;
    NSString *str_username = _textField_username.text;
    for (int i = 0; i < [_array_username count]; i++) {
        if ([str_username isEqualToString:_array_username[i]]) {
            username = YES;
            _j = i;
            break;
        }
    }
    // To check if the password matches
    if (username == YES) {
        NSString *str_password = _textField_password.text;
        if (![str_password isEqualToString:_array_password[_j]]) {
            UIAlertController *alertCont =[UIAlertController alertControllerWithTitle:@"Warning!" message:@"Username and Password Does Not Match!" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okButton =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            
            [alertCont addAction:okButton];
            
            [self presentViewController:alertCont animated:YES completion:nil];
            _textField_username.text = @"";
            _textField_password.text = @"";
        }
    }
    else {
        UIAlertController *alertCont =[UIAlertController alertControllerWithTitle:@"Warning!" message:@"The Username Does Not Exist! Please Register First!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okButton =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        
        [alertCont addAction:okButton];
        
        [self presentViewController:alertCont animated:YES completion:nil];
        _textField_username.text = @"";
        _textField_password.text = @"";
    }
}

#pragma mark UITextFeild Delegate Methods
//return the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    //NSLog(@"return");
    return YES;
}

#pragma mark Touch Event Methods
// To touch the screen and resign the keyboard
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_textField_username resignFirstResponder];
    [_textField_password resignFirstResponder];
    //NSLog(@"touchbegin");
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier]isEqualToString:@"UPLoginModal"]) {
        WelcomeViewController *objWVC = [segue destinationViewController];
        objWVC.str_firstName = _array_first[_j];
        objWVC.str_lastName = _array_last[_j];
    }
//    else if ([[segue identifier]isEqualToString:@"UPLoginToRegisterModal"]) {
//        RegisterViewController *objRVC = [segue destinationViewController];
//        objRVC.DatabasePath = _DatabasePath;
//        objRVC.ContactDB = _ContactDB;
//    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
