//
//  BaseViewController.h
//  SmartSchool
//
//  Created by saifing_82 on 15/5/4.
//  Copyright (c) 2015年 guweidong. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/**
 *  显示HUD
 *
 *  @param HUDtitle 显示内容
 */
-(void)showHUDWithTitle:(NSString *)HUDtitle;

/**
 *  隐藏HUD
 */
- (void)hideHUD;

@end
