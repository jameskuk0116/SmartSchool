//
//  LoginViewController.m
//  SmartSchool
//
//  Created by gwd on 15/5/11.
//  Copyright (c) 2015年 guweidong. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUI{
    [_loginBtn.layer setMasksToBounds:YES];
    [_loginBtn.layer setCornerRadius:5.0];
}

- (IBAction)clickRegisBtn:(UIButton *)sender {
}

- (IBAction)clickLoginBtn:(UIButton *)sender {
}
@end
