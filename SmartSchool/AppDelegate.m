//
//  AppDelegate.m
//  SmartSchool
//
//  Created by saifing_84 on 15/4/15.
//  Copyright (c) 2015年 guweidong. All rights reserved.
//

#import "AppDelegate.h"
#import "NewsMainViewController.h"
#import "TaskMainViewController.h"
#import "MapsMainViewController.h"
#import "TalkMainViewController.h"
#import "MineMainViewController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.backgroundColor = [UIColor whiteColor];
    NewsMainViewController *newsView = [[NewsMainViewController alloc]init];
    TaskMainViewController *taskView = [[TaskMainViewController alloc] init];
    MapsMainViewController *mapsView = [[MapsMainViewController alloc] init];
    TalkMainViewController *talksView = [[TalkMainViewController alloc] init];
    MineMainViewController *mineView = [[MineMainViewController alloc] init];
    
    _newsNavViewController = [[UINavigationController alloc] initWithRootViewController:newsView];
    _newsNavViewController.tabBarItem.title = @"微信";
    _newsNavViewController.tabBarItem.image = [UIImage imageNamed:@"icon_tabbar_news"];
    _newsNavViewController.tabBarItem.badgeValue = @"3";
    
    _taskNavViewController = [[UINavigationController alloc] initWithRootViewController:taskView];
    _mapsNavViewController = [[UINavigationController alloc] initWithRootViewController:mapsView];
    _talkNavViewController = [[UINavigationController alloc] initWithRootViewController:talksView];
    _mineNavViewController = [[UINavigationController alloc] initWithRootViewController:mineView];
    
    if ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7) {
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.0]];
        //设置状态栏
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        _newsNavViewController.navigationBar.translucent = NO;
        _taskNavViewController.navigationBar.translucent = NO;
        _mapsNavViewController.navigationBar.translucent = NO;
        _talkNavViewController.navigationBar.translucent = NO;
        _mineNavViewController.navigationBar.translucent = NO;
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:242.0/255.0 green:104.0/255.0 blue:5.0/255.0 alpha:1.0]];
    }
    
    [_tabBarController setViewControllers:[NSMutableArray arrayWithObjects:
                                           _newsNavViewController,
                                           _taskNavViewController,
                                           _mapsNavViewController,
                                           _talkNavViewController,
                                           _mineNavViewController,
                                           nil]];
    
    _tabBarController.hidesBottomBarWhenPushed = YES;
    _tabBarController.selectedIndex = 0;
    _tabBarController.delegate = self;
    _window.userInteractionEnabled = YES;
    [_window setRootViewController:_tabBarController];
    [_window makeKeyAndVisible];
#pragma mark - 设置TabBarController
    
    // 创建TabBarController
    UITabBarController * tabBarController = [[UITabBarController alloc]init];
    
    //CGRect frame = CGRectMake(0, 20, 320, 44);
    //tabBarController.tabBar.frame = frame;
    
    // 设置着色
    _tabBarController.tabBar.tintColor = [UIColor greenColor];
    // 设置选中图片时候
    _tabBarController.tabBar.selectedImageTintColor = [UIColor brownColor];
    // 设置背景图片(自己没有图片,不进行设置)
    
    
    tabBarController.selectedIndex = 3;
    
    
    self.window.rootViewController = tabBarController;
    
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
