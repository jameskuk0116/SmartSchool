//
//  MapsMainViewController.m
//  SmartSchool
//
//  Created by saifing_82 on 15/5/4.
//  Copyright (c) 2015年 guweidong. All rights reserved.
//

#import "MapsMainViewController.h"
#import <BmobSDK/Bmob.h>
#import "HMSegmentedControl.h"

#define K_GotoSchoolBtn_Hight 30
#define K_GotoSchoolBtn_width 60
@interface MapsMainViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>{
    HMSegmentedControl *_segmentedControl1;
    NSMutableArray *_dataArr;
    BMKPointAnnotation *_annotation;
    BMKLocationService *_locService;
}
@end

@implementation MapsMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"地 图"];
    
    _dataArr = [[NSMutableArray alloc]init];
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, _viewForShow.frame.size.width, _viewForShow.frame.size.height)];
    _mapView.scrollEnabled = YES;
    [_viewForShow addSubview:_mapView];
    
    [self setRegion];
    [self getData];
    [self getUserLoc];
    [self setGoToSchoolBtn];
}

-(void)setGoToSchoolBtn{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width- (0 + 20 + K_GotoSchoolBtn_width), [UIScreen mainScreen].bounds.size.height - (49 + 64 + 20 + K_GotoSchoolBtn_Hight), K_GotoSchoolBtn_width, K_GotoSchoolBtn_Hight)];
    [btn setTitle:@"去学校" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goSchool) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor orangeColor];
    [btn.layer setMasksToBounds:YES];
    [btn.layer setCornerRadius:5.0];
    [self.view addSubview:btn];
}

-(void)goSchool{
    /**
     *  地图中心点设定
     */
    CLLocationCoordinate2D coor2;
    coor2.longitude = 108.913629;
    coor2.latitude = 34.221686;
    _mapView.centerCoordinate = coor2;
    _mapView.zoomLevel = 17;
}

-(void)getUserLoc{
    //设置定位精确度，默认：kCLLocationAccuracyBest
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    [BMKLocationService setLocationDistanceFilter:10.f];
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}
/**
 *  描出学校边界
 */
-(void)setRegion{
    CLLocationCoordinate2D coords[7] = {0};
    coords[0].longitude = 108.908437;
    coords[0].latitude = 34.217701;//108.908437,34.217701
    coords[1].longitude = 108.908509;
    coords[1].latitude = 34.219611;//108.908509,34.219611
    coords[2].longitude = 108.912893;
    coords[2].latitude = 34.226208;//108.912893,34.226208
    coords[3].longitude = 108.919037;
    coords[3].latitude = 34.223462;//108.919037,34.223462
    coords[4].longitude = 108.916208;
    coords[4].latitude = 34.219641;//108.916208,34.219641
    coords[5].longitude = 108.914555;
    coords[5].latitude = 34.220387;//108.914555,34.220387
    coords[6].longitude = 108.91226;
    coords[6].latitude = 34.217645;//108.91226,34.217645
    
    BMKPolygon* polygon = [BMKPolygon polygonWithCoordinates:coords count:7];
    
    [_mapView addOverlay:polygon];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getData{
    [self showHUDWithTitle:@"正在加载中..."];
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Buliding"];
    [bquery setLimit:9999999];
    //查找表的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [self hideHUD];
        [_dataArr addObjectsFromArray:array];
        [self setSegmentController];
    }];
}

-(void)setSegmentController{
    NSMutableArray *titleNameArr = [[NSMutableArray alloc]init];
    for (BmobObject *obj in _dataArr) {
        NSString *title = [obj objectForKey:@"BulidingName"];
        [titleNameArr addObject:title];
    }
    _segmentedControl1 = [[HMSegmentedControl alloc] initWithSectionTitles:titleNameArr];
    _segmentedControl1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    _segmentedControl1.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40);
    _segmentedControl1.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _segmentedControl1.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    _segmentedControl1.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentedControl1.verticalDividerEnabled = YES;
    _segmentedControl1.selectionIndicatorColor = [UIColor colorWithRed:1.000 green:0.627 blue:0.000 alpha:1.000];
    _segmentedControl1.backgroundColor = [UIColor orangeColor];
    _segmentedControl1.verticalDividerColor = [UIColor colorWithRed:1.000 green:0.627 blue:0.000 alpha:1.000];
    _segmentedControl1.verticalDividerWidth = 1.0f;
    [_segmentedControl1 setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        return attString;
    }];
    [_segmentedControl1 addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentedControl1];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    [self goSchool];
    
    if (_annotation != nil) {
        [_mapView removeAnnotation:_annotation];
    }
    if (_TaskLocation) {
        NSArray *loc = [_TaskLocation componentsSeparatedByString:@","];
        _annotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.longitude = [loc[0] floatValue];
        coor.latitude = [loc[1] floatValue];
        _annotation.coordinate = coor;
        _annotation.title = _TaskLocationName;
        [_mapView addAnnotation:_annotation];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    
    _TaskLocation = nil;
    _TaskLocationName = nil;

    CATransition *transition = [CATransition animation];
    [transition setDuration:0.2];
    [transition setType:@"fromBottom"];
    [self.tabBarController.view.layer addAnimation:transition forKey:nil];
}

/**
 *   标注大头针时的回调
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

/**
 *   描边时的回调
 */
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKPolygon class]]){
        BMKPolygonView* polygonView = [[BMKPolygonView alloc] initWithOverlay:overlay];
        polygonView.strokeColor = [[UIColor orangeColor] colorWithAlphaComponent:1];
        polygonView.fillColor = [[UIColor orangeColor] colorWithAlphaComponent:0.05];
        polygonView.lineWidth = 5.0;
        
        return polygonView;
    }
    return nil;
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
    BmobObject *obj = _dataArr[segmentedControl.selectedSegmentIndex];
    NSString *title = [obj objectForKey:@"BulidingName"];
    NSArray *loc = [[obj objectForKey:@"BulidingLocation"] componentsSeparatedByString:@","];
    
    if (_annotation != nil) {
        [_mapView removeAnnotation:_annotation];
    }
    _annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.longitude = [loc[0] floatValue];
    coor.latitude = [loc[1] floatValue];
    _annotation.coordinate = coor;
    _annotation.title = title;
    [_mapView addAnnotation:_annotation];
}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //NSLog(@"heading is %@",userLocation.heading);
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    _mapView.showsUserLocation = YES;//显示定位图层
    [_mapView updateLocationData:userLocation];
}
@end
