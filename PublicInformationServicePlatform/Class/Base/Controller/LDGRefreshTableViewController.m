//
//  QYJQRefreshTableViewController.m
//  QuanYuJingQu
//
//  Created by LiDinggui on 2017/1/16.
//  Copyright © 2017年 DAQSoft. All rights reserved.
//

#import "LDGRefreshTableViewController.h"

#define PageSizeKey @"rows"
#define PageKey @"page"
#define NoDataImageName @"no_data"

@interface LDGRefreshTableViewController ()



@end

@implementation LDGRefreshTableViewController

- (NSMutableDictionary *)parameters
{
    if (_parameters == nil)
    {
        _parameters = [[NSMutableDictionary alloc] init];
    }
    return _parameters;
}

- (NSMutableArray *)models
{
    if (_models == nil)
    {
        _models = [[NSMutableArray alloc] init];
    }
    return _models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupProperties];
    
    [self setupTableView];
    
    [self setupNoDataView];
    
    [self setupRefreshControls];
}

- (void)setupProperties
{
    self.needPullDownRefreshing = YES;
    self.needPullUpRefreshing = YES;
    
    self.refreshControlType = LDGRefreshControlTypeCustom;
    
    self.tableViewStyle = UITableViewStylePlain;
    
    self.responseCache = NO;
    self.showLoadingHUD = YES;
    
    self.parameters[PageSizeKey] = PageSize;
    self.parameters[PageKey] = @(self.page = 1);
}

- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:self.tableViewStyle];
    
    self.tableView.estimatedRowHeight = 0.0;
    self.tableView.estimatedSectionHeaderHeight = 0.0;
    self.tableView.estimatedSectionFooterHeight = 0.0;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (self.tableViewStyle == UITableViewStylePlain)
    {
        self.tableView.tableFooterView = [[UIView alloc] init];
    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        if (@available(iOS 11.0, *))
//        {
//            make.edges.mas_equalTo(self.view.safeAreaInsets);
//        }
//        else
//        {
            make.edges.equalTo(self.view);
//        }
    }];
    
//    self.tableView.estimatedRowHeight = 44;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    AutomaticallyAdjustsScrollViewInsets_NO(self.tableView, self);
}

- (void)setupNoDataView
{
    UIImage *noDataImage = [UIImage imageNamed:NoDataImageName];
    UIButton *noDataButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [noDataButton setImage:noDataImage forState:UIControlStateNormal];
    [noDataButton addTarget:self action:@selector(noDataButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:noDataButton];
    [noDataButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.tableView);
        make.width.mas_equalTo(noDataImage.size.width);
        make.height.mas_equalTo(noDataImage.size.height);
    }];
    
    self.noDataView = noDataButton;
    self.noDataView.hidden = NO;
}

- (void)noDataButtonClick
{
    if (self.needPullDownRefreshing && self.tableView.mj_header.state == MJRefreshStateIdle)
    {
        [self.tableView.mj_header beginRefreshing];
    }
    else
    {
        [self loadNewData];
    }
}

- (void)setupRefreshControls
{
    if (self.refreshControlType == LDGRefreshControlTypeCustom)
    {
        self.tableView.mj_header = [JKRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        self.tableView.mj_footer = [JKRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    else
    {
        MJRefreshNormalHeader *refreshNormalHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        [refreshNormalHeader setTitle:HeaderRefreshStateIdleTitle forState:MJRefreshStateIdle];
        [refreshNormalHeader setTitle:HeaderRefreshStatePullingTitle forState:MJRefreshStatePulling];
        [refreshNormalHeader setTitle:HeaderRefreshStateRefreshingTitle forState:MJRefreshStateRefreshing];
        refreshNormalHeader.lastUpdatedTimeLabel.hidden = YES;
        self.tableView.mj_header = refreshNormalHeader;
        MJRefreshAutoNormalFooter *refreshAutoNormalFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        [refreshAutoNormalFooter setTitle:FooterRefreshStateIdleTitle forState:MJRefreshStateIdle];
        [refreshAutoNormalFooter setTitle:FooterRefreshStateRefreshingTitle forState:MJRefreshStateRefreshing];
        [refreshAutoNormalFooter setTitle:FooterRefreshStateNoMoreDataTitle forState:MJRefreshStateNoMoreData];
        self.tableView.mj_footer = refreshAutoNormalFooter;
    }
    
    self.tableView.mj_header.hidden = !self.needPullDownRefreshing;
    self.tableView.mj_footer.hidden = YES;
    
    [self noDataButtonClick];
}

- (void)loadNewData
{
    self.parameters[PageKey] = @(self.page = 1);
    [self requestData];
}

- (void)loadMoreData
{
    self.parameters[PageKey] = @(self.page += 1);
    [self requestData];
}

- (void)requestData
{
    [DLNetworkManager postRequestWithInterfaceName:self.interfaceName parameters:self.parameters success:^(id responseObject) {
        
        [self disposeSuccess:responseObject];
        
    } failure:^(NSError *error) {
        
        [self disposeError:error];
        
    } showHUDWithStatus:self.showLoadingHUD ? HUD_LOADING_STATUS : nil cache:self.page == 1 ? self.responseCache : NO];
}

- (void)endRefreshingWithCount:(NSNumber *)count
{
    [self.tableView.mj_header endRefreshing];
    
    if (self.page == 1)
    {
        [self.tableView.mj_footer resetNoMoreData];
    }
    
    if ((count != nil && self.models.count == [count integerValue]) || self.models.count % [PageSize integerValue] != 0)
    {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    else
    {
        [self.tableView.mj_footer endRefreshing];
    }
}

- (void)showPromptStatus
{
    self.noDataView.hidden = self.models.count > 0;
    if (self.models.count <= 0)
    {
        [SVProgressHUD showInfoWithStatus:HUD_NODATA_STATUS];
    }
    self.tableView.mj_footer.hidden = self.models.count <= 0 || !self.needPullUpRefreshing;
}

- (void)disposeNULLResponse
{
    if (self.page > 1)
    {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    
    if (self.page > 1)
    {
        self.page -= 1;
    }
}

- (void)disposeSuccess:(id)responseObject
{
    NSString *state = [responseObject valueForKey:@"state"];
    NSString *msg = [responseObject valueForKey:@"msg"];
    if ([state isEqualToString:@"error"])
    {
        [self disposeError:[NSString isEmptyWithStr:msg] ? @"请求失败" : msg];
        return;
    }
    
    NSNumber *total = [responseObject valueForKey:@"total"];
    
    NSMutableArray *dataArray = [self.modelClass mj_objectArrayWithKeyValuesArray:responseObject[@"rows"]];
    
    if (dataArray.count > 0)
    {
        if (self.page == 1)
        {
            self.models = dataArray;
        }
        else
        {
            [self.models addObjectsFromArray:dataArray];
        }
        
        [self.tableView reloadData];
        
        [self endRefreshingWithCount:total];
    }
    else
    {
        [self endRefreshingWithCount:total];
        [self disposeNULLResponse];
    }
    
    [self showPromptStatus];
}

- (void)disposeError:(id)error//error可能为NSString,NSError
{
    if ([error isKindOfClass:[NSString class]])
    {
        [SVProgressHUD showErrorWithStatus:(NSString *)error];
    }
    
    [self endRefreshingWithCount:nil];
    
    if (self.page > 1)
    {
        self.page -= 1;
    }
    
    [self showPromptStatus];
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

#pragma  mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

//一般情况下子类需要重写此方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

@end
