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
#import "RCIM.h"

@interface AppDelegate ()<UITabBarControllerDelegate>{
    
    BMKMapManager* _mapManager;
    MapsMainViewController *_mapsView;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoMap:) name:@"gotoMap" object:nil];
    
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.backgroundColor = [UIColor whiteColor];
    _tabBarController = [[UITabBarController alloc]init];
    NewsMainViewController *newsView = [[NewsMainViewController alloc]init];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TaskMain" bundle:nil];
    UIViewController *taskView = [storyboard instantiateViewControllerWithIdentifier:@"TaskMain"];

//    TaskMainViewController *taskView = [[TaskMainViewController alloc] init];
    _mapsView= [[MapsMainViewController alloc] init];
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
    _mapsNavViewController = [[UINavigationController alloc] initWithRootViewController:_mapsView];
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
        [[UINavigationBar appearance] setBarTintColor:[UIColor orangeColor]];
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
    _tabBarController.tabBar.selectedImageTintColor = [UIColor orangeColor];
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"lrb9zzH6TNDAmZqGqaH0n7oG"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }

    // 初始化 SDK，传入 App Key，deviceToken 暂时为空，等待获取权限。
    [RCIM initWithAppKey:@"vnroth0krco6o" deviceToken:nil];
    
#ifdef __IPHONE_8_0
    // 在 iOS 8 下注册苹果推送，申请推送权限。
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge
                                                                                         |UIUserNotificationTypeSound
                                                                                         |UIUserNotificationTypeAlert) categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
#else
    // 注册苹果推送，申请推送权限。
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
#endif
    return YES;
}

#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    // Register to receive notifications.
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    // Handle the actions.
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}
#endif

// 获取苹果推送权限成功。
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // 设置 deviceToken。
    [[RCIM sharedRCIM] setDeviceToken:deviceToken];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [BMKMapView willBackGround];
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
     [BMKMapView didForeGround];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)gotoMap:(NSNotification *)text{
    NSLog(@"%@",text.userInfo[@"TaskLocation"]);
    _mapsView.TaskLocation = text.userInfo[@"TaskLocation"];
    _mapsView.TaskLocationName = text.userInfo[@"TaskLocationName"];
    [_tabBarController setSelectedIndex:2];
}
@end
