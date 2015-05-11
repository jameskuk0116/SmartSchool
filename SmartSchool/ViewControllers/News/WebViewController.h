//
//  WebViewController.h
//  SmartSchool
//
//  Created by gwd on 15/5/12.
//  Copyright (c) 2015年 guweidong. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong ,nonatomic) NSString *htmlStr;
@end
