//
//  ViewController.m
//  RGCardViewLayout
//
//  Created by ROBERA GELETA on 1/23/15.
//  Copyright (c) 2015 ROBERA GELETA. All rights reserved.
//
#define TAG 99

#import "TaskMainViewController.h"
#import "TaskMainCollectionViewCell.h"
#import <BmobSDK/Bmob.h>
#import "UIImageView+WebCache.h"
@interface TaskMainViewController ()<UICollectionViewDataSource>{
    NSMutableArray *_dataArr;
}
@end

@implementation TaskMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setTitle:@"任 务"];
    _dataArr = [[NSMutableArray alloc]init];
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getData{
    [self showHUDWithTitle:@"正在加载中..."];
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Task"];
    [bquery orderByAscending:@"Sort"];
    [bquery setLimit:9999999];
    //查找表的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [self hideHUD];
        [_dataArr addObjectsFromArray:array];
        [_collectionView reloadData];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  _dataArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TaskMainCollectionViewCell *cell = (TaskMainCollectionViewCell  *)[collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    [self configureCell:cell withIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(TaskMainCollectionViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    UIView  *subview = [cell.contentView viewWithTag:TAG];
    [subview removeFromSuperview];

    BmobObject *obj = _dataArr[indexPath.section];
    cell.mainLabel.text = [obj objectForKey:@"TaskName"];
    cell.secendLabel.text = [obj objectForKey:@"TaskLocationName"];
    cell.priceLabel.text = [NSString stringWithFormat:@"￥:%@",[obj objectForKey:@"Money"]];
    NSString *urlStr = [obj objectForKey:@"Image"];
    NSURL *url = [NSURL URLWithString:urlStr];
    [cell.imageView sd_setImageWithURL:url];
    cell.gotoMapBtn.tag = indexPath.section;
    [cell.gotoMapBtn addTarget:self action:@selector(clickGotoBtn:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)clickGotoBtn:(UIButton *)sender{
    BmobObject *obj = _dataArr[sender.tag];
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:[obj objectForKey:@"TaskLocation"],@"TaskLocation",[obj objectForKey:@"TaskLocationName"],@"TaskLocationName", nil];
    
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"gotoMap" object:nil userInfo:dict];
    
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    CATransition *transition = [CATransition animation];
    [transition setDuration:0.2];
    [transition setType:@"fromBottom"];
    [self.tabBarController.view.layer addAnimation:transition forKey:nil];
}
@end
