//
//  EmailLoginViewController.m
//  Registration System
//
//  Created by Hongjin Su on 10/22/15.
//  Copyright © 2015 Hongjin Su. All rights reserved.
//

#import "WelcomeViewController.h"
#import "EmailLoginViewController.h"
#import "UserPasswordLoginViewController.h"
#import "RegisterViewController.h"
#import <sqlite3.h>

@interface EmailLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField_emailID;
@property (strong, nonatomic) NSMutableArray *array_emails;
@property (strong, nonatomic) NSMutableArray *array_first;
@property (strong, nonatomic) NSMutableArray *array_last;
@property (nonatomic) int j;

@end

@implementation EmailLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ButtonAction_EmailLogin:(id)sender {
    [self checkTheEmail];
}

#pragma mark The method to check if emailID exists
- (void)checkTheEmail {

    const char *dbpath = [_DatabasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_ContactDB) == SQLITE_OK) {
        
        NSString *querySQL = @"SELECT * FROM reginfo"; // * is to display all the data
        
        const char *query_stmt = [querySQL UTF8String];
        
        //NSLog(@"%d", sqlite3_prepare_v2(_ContactDB, query_stmt, -1, &statement, NULL));
        
        // To take out all the email info
        if (sqlite3_prepare_v2(_ContactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            
            _array_first =[NSMutableArray new];
            _array_last =[NSMutableArray new];
            _array_emails =[NSMutableArray new];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                NSString *first = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]; // To take firstname info out
                NSString *last = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)]; // To take lastname info out
                NSString *email = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)]; // To take email info out
                
//                NSLog(@"The firstname is %@", first);
//                NSLog(@"The lastname is %@", last);
//                NSLog(@"The email is %@", email);
                // To store all the info to the arrays
                [_array_first addObject:first];
                [_array_last addObject:last];
                [_array_emails addObject:email];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_ContactDB);
    }
    
    // To check if the email exists
    BOOL gotYou = NO;
    NSString *str_email = _textField_emailID.text;
    for (int i = 0; i < [_array_emails count]; i++) {
        if ([str_email isEqualToString:_array_emails[i]]) {
            gotYou = YES;
            _j = i;
            break;
        }
    }
    
    //NSLog(@"_j = %d, the first name is %@, the last name is %@", _j, _array_first[_j], _array_last[_j]);
    // If the email does not exist, an alert come out and it cannot process to the next screen
    if (gotYou == NO) {
        UIAlertController *alertCont =[UIAlertController alertControllerWithTitle:@"Warning!" message:@"The Email Does Not Exist! Please Register First!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okButton =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        
        [alertCont addAction:okButton];
        
        [self presentViewController:alertCont animated:YES completion:nil];
        _textField_emailID.text = @"";
    }
//    NSLog(@"%lu", (unsigned long)[_array_first count]);
//    for (int i = 0; i < [_array_first count]; i++) {
//        NSLog(@"first: %@", _array_first[i]);
//    }
//    
//    NSLog(@"%lu", (unsigned long)[_array_last count]);
//    for (int i = 0; i < [_array_last count]; i++) {
//        NSLog(@"last: %@", _array_last[i]);
//    }
//
//
//    NSLog(@"%lu", (unsigned long)[_array_emails count]);
//    for (int i = 0; i < [_array_emails count]; i++) {
//        NSLog(@"email: %@", _array_emails[i]);
//    }
    
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
    [_textField_emailID resignFirstResponder];
    //NSLog(@"touchbegin");
}



 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
     if ([[segue identifier]isEqualToString:@"EmailLoginModal"]) {
         WelcomeViewController *objWVC = [segue destinationViewController];
         objWVC.str_firstName = _array_first[_j];
         objWVC.str_lastName = _array_last[_j];
     }
     else if ([[segue identifier]isEqualToString:@"Email_UPLoginModal"]) {
         UserPasswordLoginViewController *objUPLVC = [segue destinationViewController];
         objUPLVC.DatabasePath = _DatabasePath;
         objUPLVC.ContactDB = _ContactDB;
     }
//     else if ([[segue identifier]isEqualToString:@"EmailLoginToRegisterModal"]) {
//         RegisterViewController *objRVC = [segue destinationViewController];
//         objRVC.DatabasePath = _DatabasePath;
//         objRVC.ContactDB = _ContactDB;
//     }
 }


@end
