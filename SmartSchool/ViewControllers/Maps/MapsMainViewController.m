//
//  MapsMainViewController.m
//  SmartSchool
//
//  Created by saifing_82 on 15/5/4.
//  Copyright (c) 2015年 guweidong. All rights reserved.
//

#import "MapsMainViewController.h"

@interface MapsMainViewController ()<BMKMapViewDelegate>

@end

@implementation MapsMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"地图"];
    
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.frame];
    CLLocationCoordinate2D coor2;
    coor2.longitude = 108.913629;
    coor2.latitude = 34.221686;
    _mapView.centerCoordinate = coor2;
    _mapView.zoomLevel = 17;
    _mapView.scrollEnabled = YES;
    self.view = _mapView;
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
-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.longitude = 108.913629;
    coor.latitude = 34.221686;
    annotation.coordinate = coor;
    annotation.title = @"西安文理学院";
    [_mapView addAnnotation:annotation];
    
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

-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

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

- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKPolygon class]]){
        BMKPolygonView* polygonView = [[BMKPolygonView alloc] initWithOverlay:overlay];
        polygonView.strokeColor = [[UIColor orangeColor] colorWithAlphaComponent:1];
        polygonView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.1];
        polygonView.lineWidth = 5.0;
        
        return polygonView;
    }
    return nil;
}
@end
