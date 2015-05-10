//
//  MapsMainViewController.h
//  SmartSchool
//
//  Created by saifing_82 on 15/5/4.
//  Copyright (c) 2015年 guweidong. All rights reserved.
//

#import "BaseViewController.h"
#import <BaiduMapAPI/BMapKit.h>

@interface MapsMainViewController : BaseViewController

@property (nonatomic , strong) BMKMapView *mapView;

@property (weak, nonatomic) IBOutlet UIView *viewForShow;

@property (nonatomic , strong) NSString *TaskLocation;
@property (nonatomic , strong) NSString *TaskLocationName;

@end
