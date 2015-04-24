//
//  main.m
//  SmartSchool
//
//  Created by saifing_84 on 15/4/15.
//  Copyright (c) 2015年 guweidong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <BmobSDK/Bmob.h>
int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSString *appKey = @"d04f284cf6885fb257571779535fc49a";
        [Bmob registerWithAppKey:appKey];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
