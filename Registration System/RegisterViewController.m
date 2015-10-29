//
//  RegisterViewController.m
//  Registration System
//
//  Created by Hongjin Su on 10/22/15.
//  Copyright © 2015 Hongjin Su. All rights reserved.
//

#import "RegisterViewController.h"
#import "WelcomeViewController.h"
#import <sqlite3.h>

@interface RegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField_firstName;
@property (weak, nonatomic) IBOutlet UITextField *textField_lastName;
@property (weak, nonatomic) IBOutlet UITextField *textField_EmailID;
@property (weak, nonatomic) IBOutlet UITextField *textField_phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *textField_address;
@property (weak, nonatomic) IBOutlet UITextField *textField_username;
@property (weak, nonatomic) IBOutlet UITextField *textField_password;
@property (weak, nonatomic) IBOutlet UIButton *button_register;
@property (weak, nonatomic) IBOutlet UILabel *label_saveStatus;
@property (strong, nonatomic) NSMutableArray *array_emails;
@property (strong, nonatomic) NSMutableArray *array_username;
//@property (strong, nonatomic) NSMutableArray *array_first;
//@property (strong, nonatomic) NSMutableArray *array_last;
@property (nonatomic) int j;
@property (nonatomic) int k;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _button_register.enabled = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ButtonAction_Register:(id)sender {
    
    // To delete all the spaces
    NSString *string_firstName = [_textField_firstName.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *string_lastName = [_textField_lastName.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *string_emailID = [_textField_EmailID.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *string_phoneNumber = [_textField_phoneNumber.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *string_address = [_textField_address.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *string_username = [_textField_username.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *string_password = [_textField_password.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // To check if anyone is empty
    if ([string_firstName isEqualToString:@""] || [string_lastName isEqualToString:@""] || [string_emailID isEqualToString:@""] || [string_phoneNumber isEqualToString:@""] || [string_address isEqualToString:@""] || [string_username isEqualToString:@""] || [string_password isEqualToString:@""]) {
        
        UIAlertController *alertCont =[UIAlertController alertControllerWithTitle:@"Warning!" message:@"Information Should Not Be Empty." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okButton =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        
        [alertCont addAction:okButton];
        
        [self presentViewController:alertCont animated:YES completion:nil];
    }
    [self checkTheEmail];
//    [self performSelector:@selector(onTick2:) withObject:nil afterDelay:3.0];
//    [self delay:3.0];
}

#pragma mark UITextFeild Delegate Methods
//return the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark Touch Event Methods
// To touch the screen and resign the keyboard
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_textField_firstName resignFirstResponder];
    [_textField_lastName resignFirstResponder];
    [_textField_EmailID resignFirstResponder];
    [_textField_phoneNumber resignFirstResponder];
    [_textField_address resignFirstResponder];
    [_textField_username resignFirstResponder];
    [_textField_password resignFirstResponder];
}

#pragma mark Display alert controller
// The alert for the time slot
- (void)displayAlert_ForInvaliedDate
{
    UIAlertController *alertCont =[UIAlertController alertControllerWithTitle:@"Warning!" message:@"Please Enter the Information in the Correct Form" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okButton =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alertCont addAction:okButton];
    
    [self presentViewController:alertCont animated:YES completion:nil];
}



#pragma mark End Text Field Editing
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    // To check if the text field is empty
    NSString *stringT = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (![stringT isEqualToString:@""]) {
        // To delete all the spaces
        NSString *string_firstName = [_textField_firstName.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *string_lastName = [_textField_lastName.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *string_emailID = [_textField_EmailID.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *string_phoneNumber = [_textField_phoneNumber.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *string_address = [_textField_address.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *string_username = [_textField_username.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *string_password = [_textField_password.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        // To check if anyone is empty
        if (!([string_firstName isEqualToString:@""] || [string_lastName isEqualToString:@""] || [string_emailID isEqualToString:@""] || [string_phoneNumber isEqualToString:@""] || [string_address isEqualToString:@""] || [string_username isEqualToString:@""] || [string_password isEqualToString:@""])) {
            _button_register.enabled = YES;
        }
        return YES;
    }
    else {
        
        UIAlertController *alertCont =[UIAlertController alertControllerWithTitle:@"Warning!" message:@"Information Should Not Be Empty." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okButton =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        
        [alertCont addAction:okButton];
        
        [self presentViewController:alertCont animated:YES completion:nil];
        
        return NO;
    }
}

#pragma mark To check if the email exists
- (void)checkTheEmail {

    const char *dbpath = [_DatabasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_ContactDB) == SQLITE_OK) {
        
        NSString *querySQL = @"SELECT * FROM reginfo"; // * is to display all the data
        
        const char *query_stmt = [querySQL UTF8String];
        
        //NSLog(@"%d", sqlite3_prepare_v2(_ContactDB, query_stmt, -1, &statement, NULL));
        
        // To take out all the email info
        if (sqlite3_prepare_v2(_ContactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
//            
//            _array_first =[NSMutableArray new];
//            _array_last =[NSMutableArray new];
            _array_emails =[NSMutableArray new];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
//                NSString *first = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]; // To take firstname info out
//                NSString *last = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)]; // To take lastname info out
                NSString *email = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)]; // To take email info out
                
                //                NSLog(@"The firstname is %@", first);
                //                NSLog(@"The lastname is %@", last);
                //                NSLog(@"The email is %@", email);
                // To store all the info to the arrays
//                [_array_first addObject:first];
//                [_array_last addObject:last];
                [_array_emails addObject:email];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_ContactDB);
    }
    
    // To check if the email exists
    BOOL gotYou = NO;
    NSString *str_email = _textField_EmailID.text;
    for (int i = 0; i < [_array_emails count]; i++) {
        if ([str_email isEqualToString:_array_emails[i]]) {
            gotYou = YES;
            _j = i;
            break;
        }
    }
    
    //NSLog(@"_j = %d, the first name is %@, the last name is %@", _j, _array_first[_j], _array_last[_j]);
    if (gotYou == YES) {
        UIAlertController *alertCont =[UIAlertController alertControllerWithTitle:@"Warning!" message:@"The Email Already Exists! Please Login or Use a Different Email Address!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okButton =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        
        [alertCont addAction:okButton];
        
        [self presentViewController:alertCont animated:YES completion:nil];
        _textField_EmailID.text = @"";
    }
    else {
        [self checkTheUsername];
    }
}

#pragma mark To check if the username exists
- (void)checkTheUsername {

    const char *dbpath = [_DatabasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_ContactDB) == SQLITE_OK) {
        
        NSString *querySQL = @"SELECT * FROM reginfo"; // * is to display all the data
        
        const char *query_stmt = [querySQL UTF8String];
        
        NSLog(@"%d", sqlite3_prepare_v2(_ContactDB, query_stmt, -1, &statement, NULL));
        
        if (sqlite3_prepare_v2(_ContactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
//            
//            _array_first =[NSMutableArray new];
//            _array_last =[NSMutableArray new];
            _array_username =[NSMutableArray new];
//            _array_password =[NSMutableArray new];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
//                NSString *first = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]; // To take firstname info out
//                NSString *last = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)]; // To take lastname info out
                NSString *username = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)]; // To take username info out
//                NSString *password = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)]; // To take password info out
                
                //                NSLog(@"The firstname is %@", first);
                //                NSLog(@"The lastname is %@", last);
                //                NSLog(@"The email is %@", email);
                // To store all the info to the arrays
//                [_array_first addObject:first];
//                [_array_last addObject:last];
                [_array_username addObject:username];
//                [_array_password addObject:password];
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
            _k = i;
            break;
        }
    }
    // To check if the password matches
    if (username == YES) {
        UIAlertController *alertCont =[UIAlertController alertControllerWithTitle:@"Warning!" message:@"The Username Already Exists! Please Login or Use a Different Username!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okButton =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        
        [alertCont addAction:okButton];
        
        [self presentViewController:alertCont animated:YES completion:nil];
        _textField_username.text = @"";
//        NSString *str_password = _textField_password.text;
//        if (![str_password isEqualToString:_array_password[_j]]) {
//            UIAlertController *alertCont =[UIAlertController alertControllerWithTitle:@"Warning!" message:@"Username and Password Does Not Match!" preferredStyle:UIAlertControllerStyleAlert];
//            
//            UIAlertAction *okButton =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
//            
//            [alertCont addAction:okButton];
//            
//            [self presentViewController:alertCont animated:YES completion:nil];
//            _textField_username.text = @"";
//            _textField_password.text = @"";
//        }
//    }
//    else {
//        UIAlertController *alertCont =[UIAlertController alertControllerWithTitle:@"Warning!" message:@"The Username Does Not Exist! Please Register First!" preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction *okButton =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
//        
//        [alertCont addAction:okButton];
//        
//        [self presentViewController:alertCont animated:YES completion:nil];
//        _textField_username.text = @"";
//        _textField_password.text = @"";
    }
    else {
        [self saveTheData];
    }
}

#pragma mark To save the info in the database
- (void)saveTheData {

    sqlite3_stmt   *statement;
    const char *dbpath = [_DatabasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_ContactDB) == SQLITE_OK) {
        
        NSString *string_firstName = _textField_firstName.text;
        NSString *string_lastName = _textField_lastName.text;
        NSString *string_emailID = _textField_EmailID.text;
        NSString *string_phoneNumber = _textField_phoneNumber.text;
        NSString *string_address = _textField_address.text;
        NSString *string_username = _textField_username.text;
        NSString *string_password = _textField_password.text;
        
        
        
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO REGINFO (FirstName, LastName, Email, PhoneNumber, Address, UserName, Password) VALUES (\"%@\", \"%@\", \"%@\",\"%@\", \"%@\", \"%@\", \"%@\")", string_firstName, string_lastName, string_emailID, string_phoneNumber, string_address, string_username, string_password];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_ContactDB, insert_stmt,-1, &statement, NULL);
        //NSLog(@"Arrived here %@",[_DatabasePath description]);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            
            _label_saveStatus.text = @"App Info added";
            [self performSelector:@selector(onTick:) withObject:nil afterDelay:3.0];
        }
        else {
            NSLog(@"%d",sqlite3_step(statement));
            _label_saveStatus.text = @"Failed to add App Info";
            [self performSelector:@selector(onTick2:) withObject:nil afterDelay:3.0];
        }
        sqlite3_finalize(statement);
        sqlite3_close(_ContactDB);
    }
}

// To count to 3 and database label is DISPEARED! :D
- (void) onTick:(NSTimer *)timer {
    
    _label_saveStatus.text = @"";
}

- (void) onTick2:(NSTimer *)timer {
    
}

//-(void)delay:(double)value{
//    double delayInSeconds = value;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        NSLog(@"Do some work");
//    });
//}

//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier]isEqualToString:@"RegisterLoginModal"]) {
        //[self performSelector:@selector(onTick2:) withObject:nil afterDelay:3.0];
        WelcomeViewController *objWVC = [segue destinationViewController];
        objWVC.str_firstName = _textField_firstName.text;
        objWVC.str_lastName = _textField_lastName.text;
    }
}

@end
