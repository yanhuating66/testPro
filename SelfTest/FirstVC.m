//
//  FirstVC.m
//  SelfTest
//
//  Created by 严华停 on 2020/1/13.
//  Copyright © 2020 apple. All rights reserved.
//

#import "FirstVC.h"

@interface FirstVC ()

@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor greenColor];
//    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];

    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    // Do any additional setup after loading the view.
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
