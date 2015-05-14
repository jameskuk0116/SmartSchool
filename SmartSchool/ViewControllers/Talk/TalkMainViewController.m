//
//  TalkMainViewController.m
//  SmartSchool
//
//  Created by saifing_82 on 15/5/4.
//  Copyright (c) 2015年 guweidong. All rights reserved.
//

#import "TalkMainViewController.h"
#import "RCIM.h"
#import "RCChatViewController.h"

@interface TalkMainViewController ()

@end

@implementation TalkMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"聊天"];
    [self setUI];
    self.navigationItem.hidesBackButton = YES;
    
    /**
     *  用token去连接获取长连接
     *
     *  @param userId nil
     *
     *  @return nil
     */
    [RCIM connectWithToken:@"ZtaxrZfT994dL0u9V8l2gIviFRF+0gv+xIt4Zy8jC33yU0suoeqp8jR5Z2D1v7x5GZe5sr4/Wx74TrC5RmLOZaS4NtEZTpcu" completion:^(NSString *userId) {
        
        /**
         *  同步组群
         */
        [self syncGroups];

    } error:^(RCConnectErrorCode status) {
        // 此处处理连接错误。
        NSLog(@"Login failed.");
    }];

}

-(void)setUI{
    /**
     *  添加客服按钮
     */
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 55, 30);
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:@"帮一下" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget: self action: @selector(rightBarButtonItemPressed:) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = btnItem;
}

/**
 *  同步组群
 */
-(void)syncGroups{
    RCIMClient *client = [[RCIMClient alloc]init];
//    [client syncGroups:@[] completion:^{
//        
//    } error:^(RCErrorCode status) {
//        
//    }];
    
    [client joinGroup:@"cn.guweidong.xawl.all" groupName:@"文理学院" completion:^{
        [self refreshChatListView];
        [self.conversationListView reloadData];
    } error:^(RCErrorCode status) {
        [self refreshChatListView];
        [self.conversationListView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  点击客服跳转
 *
 *  @param sender 点击的按钮
 */
-(void)rightBarButtonItemPressed:(UIButton *)sender{
    // 创建客服聊天视图控制器。
    RCChatViewController *chatViewController = [[RCIM sharedRCIM]createCustomerService:@"KEFU1430906042741" title:@"帮帮忙" completion:^(){
        // 创建 ViewController 后，调用的 Block，可以用来实现自定义行为。
    }];
    
    // 把客服聊天视图控制器添加到导航栈。
    chatViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatViewController animated:YES];
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
    /**
     *  添加页面切换动画
     */
    [super viewWillDisappear:YES];
    CATransition *transition = [CATransition animation];
    [transition setDuration:0.2];
    [transition setType:@"fromBottom"];
    [self.tabBarController.view.layer addAnimation:transition forKey:nil];
}

/**
 *  view自动代理回调方法，结束编辑
 *
 *  @param touches nil
 *  @param event   nil
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
