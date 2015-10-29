//
//  WelcomeViewController.m
//  Registration System
//
//  Created by Hongjin Su on 10/22/15.
//  Copyright © 2015 Hongjin Su. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label_welcome;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _label_welcome.lineBreakMode = NSLineBreakByWordWrapping;
    _label_welcome.numberOfLines = 0;
    _label_welcome.text = [NSString stringWithFormat:@"Welcome! %@ %@!", _str_firstName, _str_lastName];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
