//
//  LoginViewController.h
//  SmartSchool
//
//  Created by gwd on 15/5/11.
//  Copyright (c) 2015年 guweidong. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameLbl;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *passwdLbl;
- (IBAction)clickLoginBtn:(UIButton *)sender;

@end
