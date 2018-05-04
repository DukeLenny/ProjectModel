//
//  QYJQRefreshAutoFooter.h
//  QuanYuJingQu
//
//  Created by LiDinggui on 2017/1/16.
//  Copyright © 2017年 DAQSoft. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

static NSString *FooterRefreshStateIdleTitle = @"点击或上拉可以加载更多";
static NSString *FooterRefreshStateRefreshingTitle = @"正在加载更多...";
static NSString *FooterRefreshStateNoMoreDataTitle = @"已经全部加载完毕";

@interface JKRefreshAutoFooter : MJRefreshAutoFooter

@end
