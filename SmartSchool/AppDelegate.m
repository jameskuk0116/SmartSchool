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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    _tabBarController = [[AKTabBarController alloc] initWithTabBarHeight:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 70 : 50];
    
    [_tabBarController setMinimumHeightToDisplayTitle:40.0];
    
    NewsMainViewController *newsView = [[NewsMainViewController alloc]init];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newsView];
    navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    
    [_tabBarController setViewControllers:[NSMutableArray arrayWithObjects:
                                           newsView,
                                           [[TaskMainViewController alloc] init],
                                           [[MapsMainViewController alloc] init],
                                           [[TalkMainViewController alloc] init],
                                           [[MineMainViewController alloc] init],nil]];
    // Tabs Colors settings
    [_tabBarController setTabColors:@[[UIColor whiteColor],
                                      [UIColor whiteColor]]]; // MAX 2 Colors
    _tabBarController.tabStrokeColor = [UIColor whiteColor];
    //分隔线颜色
    _tabBarController.tabEdgeColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    _tabBarController.hidesBottomBarWhenPushed = YES;
    //图标颜色
    [_tabBarController setIconColors:@[[UIColor colorWithRed:149.0/255.0 green:146.0/255.0 blue:147.0/255.0 alpha:1.0],
                                       [UIColor colorWithRed:149.0/255.0 green:146.0/255.0 blue:147.0/255.0 alpha:1.0]]]; // MAX 2 Colors
    //选中图标颜色
    [_tabBarController setSelectedIconColors:@[[UIColor colorWithRed:242.0/255.0 green:104.0/255.0 blue:5.0/255.0 alpha:1.0],
                                               [UIColor colorWithRed:242.0/255.0 green:104.0/255.0 blue:5.0/255.0 alpha:1.0]]]; // MAX 2 Colors
    //文字颜色
    [_tabBarController setTextColor:[UIColor colorWithRed:149.0/255.0 green:146.0/255.0 blue:147.0/255.0 alpha:1.0]];
    //选中文字颜色
    [_tabBarController setSelectedTextColor:[UIColor colorWithRed:242.0/255.0 green:104.0/255.0 blue:5.0/255.0 alpha:1.0]];
    //文字字号
    _tabBarController.textFont = [UIFont fontWithName:@"Helvetica-Bold" size:11.0];
    [_window setRootViewController:_tabBarController];
    [_window makeKeyAndVisible];
    
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
