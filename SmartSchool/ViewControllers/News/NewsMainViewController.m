//
//  NewsMainViewController.m
//  SmartSchool
//
//  Created by saifing_82 on 15/5/4.
//  Copyright (c) 2015年 guweidong. All rights reserved.
//

#import "NewsMainViewController.h"

@interface NewsMainViewController ()

@end

@implementation NewsMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"新闻"];
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

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    CATransition *transition = [CATransition animation];
    [transition setDuration:0.2];
    [transition setType:@"fromBottom"];
    [self.tabBarController.view.layer addAnimation:transition forKey:nil];
}
@end
