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
    _tabBarController = [[UITabBarController alloc]init];
    NewsMainViewController *newsView = [[NewsMainViewController alloc]init];
    TaskMainViewController *taskView = [[TaskMainViewController alloc] init];
    MapsMainViewController *mapsView = [[MapsMainViewController alloc] init];
    TalkMainViewController *talksView = [[TalkMainViewController alloc] init];
    MineMainViewController *mineView = [[MineMainViewController alloc] init];
    
    UITabBarItem *newsItem=[[UITabBarItem alloc]initWithTitle:@"新闻" image:[UIImage imageNamed:@"icon_tabbar_news"] tag:1];
    UITabBarItem *taskItem=[[UITabBarItem alloc]initWithTitle:@"任务" image:[UIImage imageNamed:@"icon_tabbar_task"] tag:2];
    UITabBarItem *mapItem=[[UITabBarItem alloc]initWithTitle:@"地图" image:[UIImage imageNamed:@"icon_tabbar_map"] tag:3];
    UITabBarItem *talkItem=[[UITabBarItem alloc]initWithTitle:@"聊天" image:[UIImage imageNamed:@"icon_tabbar_talkwith"] tag:4];
    UITabBarItem *mineItem=[[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"icon_tabbar_user"] tag:5];
    
    _newsNavViewController = [[UINavigationController alloc] initWithRootViewController:newsView];
    _newsNavViewController.tabBarItem = newsItem;
    _taskNavViewController = [[UINavigationController alloc] initWithRootViewController:taskView];
    _taskNavViewController.tabBarItem = taskItem;
    _mapsNavViewController = [[UINavigationController alloc] initWithRootViewController:mapsView];
    _mapsNavViewController.tabBarItem = mapItem;
    _talkNavViewController = [[UINavigationController alloc] initWithRootViewController:talksView];
    _talkNavViewController.tabBarItem = talkItem;
    _mineNavViewController = [[UINavigationController alloc] initWithRootViewController:mineView];
    _mineNavViewController.tabBarItem = mineItem;
    
    if ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7) {
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

    // 设置选中图片时候
    _tabBarController.tabBar.selectedImageTintColor = [UIColor colorWithRed:0.389 green:1.000 blue:0.000 alpha:1.000];

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
