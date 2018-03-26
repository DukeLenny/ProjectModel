//
//  QYRefreshHeader.h
//  FourBigArea
//
//  Created by LiDinggui on 2017/1/13.
//  Copyright © 2017年 LiDinggui. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

static NSString *HeaderRefreshStateIdleTitle = @"下拉即可刷新";
static NSString *HeaderRefreshStatePullingTitle = @"松开立即刷新";
static NSString *HeaderRefreshStateRefreshingTitle = @"正在刷新...";

@interface JKRefreshHeader : MJRefreshHeader

@end
