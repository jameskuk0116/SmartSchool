//
//  NewsMainViewController.m
//  SmartSchool
//
//  Created by saifing_82 on 15/5/4.
//  Copyright (c) 2015年 guweidong. All rights reserved.
//

#import "NewsMainViewController.h"
#import <BmobSDK/Bmob.h>
#import "NewsTableViewCell.h"
#import "ImagePlayerView.h"
#import "WebViewController.h"
#import "MJRefresh.h"

@interface NewsMainViewController ()<UITableViewDelegate,UITableViewDataSource,ImagePlayerViewDelegate>
{
    /**
     *  新闻数组
     */
    NSMutableArray *_newsArr;
    
    /**
     *  图片轮播器
     */
    ImagePlayerView *_imagePlayerView;
    
    /**
     *  轮播器使用的数组
     */
    NSMutableArray *_imgArr;
}
@end

@implementation NewsMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    /**
     *  设置标题
     */
    [self setTitle:@"新 闻"];
    
    /**
     *  设置UI和对象初始化
     */
    [self setUI];

    /**
     *  获取数据
     */
    [self getData];
    [self getDataWithStart:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUI{
    /**
     初始化
     */
    _newsArr = [[NSMutableArray alloc]init];
    _imgArr = [[NSMutableArray alloc]init];
    _imageURLs = [[NSMutableArray alloc]init];
    
    /**
     去除tableview的plain样式多余的分割线和group样式默认的头部
     */
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(CGFLOAT_MIN,CGFLOAT_MIN,CGFLOAT_MIN, CGFLOAT_MIN)];
    [view setBackgroundColor:[UIColor clearColor]];
    [_tableView setTableHeaderView:view];
    [_tableView setTableFooterView:view];
    
    
    /**
     设置imagePlayerView
     */
    _imagePlayerView = [[ImagePlayerView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    _imagePlayerView.imagePlayerViewDelegate = self;
    // set auto scroll interval to x seconds
    _imagePlayerView.scrollInterval = 5.0f;
    
    // adjust pageControl position
    _imagePlayerView.pageControlPosition = ICPageControlPosition_BottomCenter;
    
    // hide pageControl or not
    _imagePlayerView.hidePageControl = NO;
    
    // adjust edgeInset
    _imagePlayerView.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    /**
     *  设置刷新头部
     */
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self getDataWithStart:0];
    }];
    
    /**
     *  设置加载更多尾部
     */
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        NSString *count = [NSString stringWithFormat:@"%lu",(unsigned long)_newsArr.count];
        [self getDataWithStart:[count intValue]];
    }];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    /**
     *  添加页面切换动画
     */
    CATransition *transition = [CATransition animation];
    [transition setDuration:0.2];
    [transition setType:@"fromBottom"];
    [self.tabBarController.view.layer addAnimation:transition forKey:nil];
}

/**
 *  获取新闻数据
 *
 *  @param start 分页，要跳过多少数据
 */
-(void)getDataWithStart:(int)start{
    [self showHUDWithTitle:@"正在加载中..."];
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"News"];
    [bquery orderByDescending:@"createdAt"];
    [bquery setLimit:5];
    [bquery setSkip:start];
    //查找表的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        /**
         *  隐藏HUD
         */
        [self hideHUD];
        
        /**
         *  停止刷新
         */
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        if (start == 0) {
            [_newsArr removeAllObjects];
        }
        [_newsArr addObjectsFromArray:array];
        
        /**
         *  拿到数据，刷新列表
         */
        [_tableView reloadData];
    }];
}

/**
 *  获取轮播器数据
 */
-(void)getData{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"News"];
    [bquery orderByDescending:@"createdAt"];
    [bquery setLimit:5];
    [bquery setSkip:0];
    //查找表的数据
    [_imageURLs removeAllObjects];
    [_imgArr removeAllObjects];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for ( BmobObject *obj in array) {
            NSString *urlStr = [obj objectForKey:@"NewsImage"];
            NSURL *url = [NSURL URLWithString:urlStr];
            [_imageURLs addObject:url];
        }
        [_imgArr addObjectsFromArray:array];
        
        /**
         *  刷新轮播器
         */
        [_imagePlayerView reloadData];
    }];
}

#pragma mark - tableView代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _newsArr.count + 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
        [cell setBackgroundColor:[UIColor orangeColor]];
        [cell addSubview:_imagePlayerView];
        return cell;
    }else{
        BmobObject *obj = _newsArr[indexPath.section - 1];
        static NSString *CellIdentifier = @"cell1";
        NewsTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
        cell =[[[NSBundle mainBundle] loadNibNamed:@"NewsTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        cell.NewsName.text = [obj objectForKey:@"NewsName"];
        
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
        //获取时间
        NSString *currentDateStr = [dateFormatter stringFromDate:obj.createdAt];
        cell.NewsTime.text = [NSString stringWithFormat:@"发表时间:%@",currentDateStr];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BmobObject *obj = _newsArr[indexPath.section -1];
    WebViewController *web = [[WebViewController alloc]init];
    web.hidesBottomBarWhenPushed = YES;
    web.htmlStr = [obj objectForKey:@"Content"];
    [self.navigationController pushViewController:web animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }else if (section == 1) {
        return 10;
    }else{
        return 5;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 200;
    }else{
      NewsTableViewCell *cell =[[[NSBundle mainBundle] loadNibNamed:@"NewsTableViewCell" owner:self options:nil] objectAtIndex:0];
        return cell.frame.size.height;
    }
}

#pragma mark - ImagePlayerViewDelegate
- (NSInteger)numberOfItems
{
    return self.imageURLs.count;
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    // recommend to use SDWebImage lib to load web image
    //    [imageView setImageWithURL:[self.imageURLs objectAtIndex:index] placeholderImage:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[self.imageURLs objectAtIndex:index]]];
    });
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    NSLog(@"did tap index = %d", (int)index);
    BmobObject *obj = _imgArr[index];
    WebViewController *web = [[WebViewController alloc]init];
    web.htmlStr = [obj objectForKey:@"Content"];
    web.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:web animated:YES];
}
@end
