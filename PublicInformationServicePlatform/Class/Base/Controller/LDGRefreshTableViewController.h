//
//  QYJQRefreshTableViewController.h
//  QuanYuJingQu
//
//  Created by LiDinggui on 2017/1/16.
//  Copyright © 2017年 DAQSoft. All rights reserved.
//

#import "LDGBaseViewController.h"

typedef NS_ENUM(NSInteger, LDGRefreshControlType) {
    LDGRefreshControlTypeCustom = 0,
    LDGRefreshControlTypeNormal
};

@interface LDGRefreshTableViewController : LDGBaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (weak, nonatomic) __kindof UIView *noDataView;
@property (strong, nonatomic) NSMutableArray *models;

@property (assign, nonatomic) BOOL needPullDownRefreshing;
@property (assign, nonatomic) BOOL needPullUpRefreshing;

@property (assign, nonatomic) LDGRefreshControlType refreshControlType;

@property (assign, nonatomic) UITableViewStyle tableViewStyle;

@property (assign, nonatomic) BOOL responseCache;
@property (assign, nonatomic) BOOL showLoadingHUD;

@property (assign, nonatomic) NSInteger page;

- (void)setupNoDataView;//子类重写时不用调super

- (void)endRefreshingWithCount:(NSNumber *)count;
- (void)showPromptStatus;
- (void)disposeNULLResponse;
- (void)disposeSuccess:(id)responseObject;////////////子类重写时不用调super
- (void)disposeError:(id)error;

- (void)loadNewData;
- (void)loadMoreData;
- (void)requestData;//子类重写时不用调super

///////////////////////////////////////////以下属性和方法为常用的设置/////////////////////////////////////////

@property (copy, nonatomic) NSString *interfaceName;

@property (strong, nonatomic) NSMutableDictionary *parameters;

@property (strong, nonatomic) Class modelClass;

- (void)setupProperties NS_REQUIRES_SUPER;
- (void)setupTableView NS_REQUIRES_SUPER;//子类重写时主要做注册自定义cell操作

@end
