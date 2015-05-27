//
//  LoginViewController.m
//  SmartSchool
//
//  Created by gwd on 15/5/11.
//  Copyright (c) 2015年 guweidong. All rights reserved.
//

#import "LoginViewController.h"
#import <BmobSDK/Bmob.h>
#import "TalkMainViewController.h"

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
    [self setTitle:@"聊 天"];
    [_loginBtn.layer setMasksToBounds:YES];
    [_loginBtn.layer setCornerRadius:5.0];
}

/**
 *  点击登录的按钮
 *
 *  @param sender 被点击的按钮
 */
- (IBAction)clickLoginBtn:(UIButton *)sender {
    if (![_userNameLbl.text isEqualToString:@""] && ![_passwdLbl.text isEqualToString:@""]) {
        [self showHUDWithTitle:@"正在登陆中..."];
        [BmobUser loginWithUsernameInBackground:_userNameLbl.text password:_passwdLbl.text block:^(BmobUser *user, NSError *error) {
            [self hideHUD];
            if (user || error == nil) {
                /**
                 如果正确，跳入聊天界面
                 */
                TalkMainViewController *view = [[TalkMainViewController alloc]init];
                view.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:view animated:YES];
            }else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请检查您输入的用户名或密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
