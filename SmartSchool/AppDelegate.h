//
//  AppDelegate.h
//  SmartSchool
//
//  Created by saifing_84 on 15/4/15.
//  Copyright (c) 2015年 guweidong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>//引入所有的头文件

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController* mapsNavViewController;
@property (nonatomic, strong) UINavigationController* taskNavViewController;
@property (nonatomic, strong) UINavigationController* mineNavViewController;
@property (nonatomic, strong) UINavigationController* newsNavViewController;
@property (nonatomic, strong) UINavigationController* talkNavViewController;
@property (nonatomic, strong) UITabBarController *tabBarController;

@end

