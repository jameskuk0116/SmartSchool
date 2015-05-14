//
//  BaseViewController.m
//  SmartSchool
//
//  Created by saifing_82 on 15/5/4.
//  Copyright (c) 2015年 guweidong. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"

@interface BaseViewController ()
{
    MBProgressHUD *_hud;
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName,nil]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  显示HUD
 *
 *  @param HUDtitle 要显示的内容
 */
-(void)showHUDWithTitle:(NSString *)HUDtitle{
    [_hud hide:YES];
    
    _hud = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:_hud];
    _hud.labelText = HUDtitle;
    _hud.removeFromSuperViewOnHide = YES;
    [_hud show:YES];
}

/**
 *  隐藏HUD
 */
- (void)hideHUD
{
    [_hud hide:YES afterDelay:0.5];
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
