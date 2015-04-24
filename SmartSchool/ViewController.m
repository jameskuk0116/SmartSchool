//
//  ViewController.m
//  SmartSchool
//
//  Created by saifing_84 on 15/4/15.
//  Copyright (c) 2015年 guweidong. All rights reserved.
//

#import "ViewController.h"
#import <BmobSDK/Bmob.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    BmobObject *gameScore = [BmobObject objectWithClassName:@"GameScore"];
    [gameScore setObject:@"小明" forKey:@"playerName"];
    [gameScore setObject:@78 forKey:@"score"];
    [gameScore setObject:[NSNumber numberWithBool:YES] forKey:@"cheatMode"];
    [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        //进行操作
    }];
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"GameScore"];
    bquery.limit = 3;
    bquery.skip = 3;
    //查找GameScore表所有数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            //打印playerName
            NSLog(@"obj.playerName = %@", [obj objectForKey:@"playerName"]);
            //打印objectId,createdAt,updatedAt
            NSLog(@"obj.objectId = %@", [obj objectId]);
            NSLog(@"obj.createdAt = %@", [obj createdAt]);
            NSLog(@"obj.updatedAt = %@", [obj updatedAt]);
        }
    }];
    
    BmobUser *bUser = [[BmobUser alloc] init];
    [bUser setUserName:@"小明"];
    [bUser setPassword:@"123456"];
    [bUser setObject:@18 forKey:@"age"];
    [bUser setEmail:@"790032475@qq.com"];
    [bUser signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        
    }];
    
    [BmobUser loginWithUsernameInBackground:@"小明"
                                   password:@"123456"
                                      block:^(BmobUser *user, NSError *error) {
                                          if (error) {
                                              //登录失败的原因
                                              NSLog(@"logIn error %@",[error description]);
                                          }else{
                                              NSLog(@"login successful");
                                              //用户的objectId
                                              NSLog(@"%@",user.objectId);
                                          }
                                      }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
