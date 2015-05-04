//
//  MapsMainViewController.m
//  SmartSchool
//
//  Created by saifing_82 on 15/5/4.
//  Copyright (c) 2015年 guweidong. All rights reserved.
//

#import "MapsMainViewController.h"

@interface MapsMainViewController ()

@end

@implementation MapsMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSString *)tabImageName
{
    return @"icon_tabbar_map";
}

- (NSString *)activeTabImageName
{
    return @"icon_tabbar_map_selected";
}

- (NSString *)tabTitle
{
    return @"地图";
}
@end
