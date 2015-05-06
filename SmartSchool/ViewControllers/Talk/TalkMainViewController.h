//
//  TalkMainViewController.h
//  SmartSchool
//
//  Created by saifing_82 on 15/5/4.
//  Copyright (c) 2015年 guweidong. All rights reserved.
//

#import "BaseViewController.h"
#import "RCChatListViewController.h"
#import "RCConversation.h"


@interface TalkMainViewController : RCChatListViewController

/**
 *  会话数据模型
 */
@property (strong,nonatomic) RCConversation *conversation;

@end
