//
//  ViewController.m
//  SmartSchool
//
//  Created by saifing_84 on 15/4/15.
//  Copyright (c) 2015年 guweidong. All rights reserved.
//

#import "ViewController.h"
#import <BmobSDK/Bmob.h>
#import "NewsMainViewController.h"
#import "TaskMainViewController.h"
#import "MapsMainViewController.h"
#import "TalkMainViewController.h"
#import "MineMainViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Create and initialize the height of the tab bar to 50px.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTabBar{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // If the device is an iPad, we make it taller.
    _tabBarController = [[AKTabBarController alloc] initWithTabBarHeight:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 70 : 50];
    
    [_tabBarController setMinimumHeightToDisplayTitle:40.0];
    
    
//    FirstViewController *tableViewController = [[FirstViewController alloc] initWithStyle:UITableViewStylePlain];
    NewsMainViewController *newsView = [[NewsMainViewController alloc]init];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newsView];
    navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    
    [_tabBarController setViewControllers:[NSMutableArray arrayWithObjects:
                                           newsView,
                                           [[TaskMainViewController alloc] init],
                                           [[MapsMainViewController alloc] init],
                                           [[TalkMainViewController alloc] init],
                                           [[MineMainViewController alloc] init],nil]];
    
//    _tabBarController.defaultBadge = [JSCustomBadge customBadgeWithString:@""
//                                                          withStringColor:[UIColor whiteColor]
//                                                           withInsetColor:[UIColor redColor]
//                                                           withBadgeFrame:YES
//                                                      withBadgeFrameColor:[UIColor whiteColor]
//                                                                withScale:1.0f
//                                                              withShining:NO];
    
    [_window setRootViewController:_tabBarController];
    [_window makeKeyAndVisible];
}
@end
