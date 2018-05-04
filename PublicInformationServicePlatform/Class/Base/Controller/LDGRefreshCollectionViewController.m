//
//  LDGRefreshCollectionViewController.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/10.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "LDGRefreshCollectionViewController.h"

#define PageSizeKey @"limitPage"
#define PageKey @"page"
#define NoDataImageName @"no_data"

@interface LDGRefreshCollectionViewController ()

@end

@implementation LDGRefreshCollectionViewController

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
    
    [self setupCollectionView];
    
    [self setupNoDataView];
    
    [self setupRefreshControls];
}

- (void)setupProperties
{
    self.needPullDownRefreshing = YES;
    self.needPullUpRefreshing = YES;
    
    self.refreshControlType = LDGRefreshControlTypeNormal;
    
    self.responseCache = NO;
    self.showLoadingHUD = YES;
    
    self.parameters[PageSizeKey] = PageSize;
    self.parameters[PageKey] = @(self.page = 1);
}

- (void)setupCollectionView
{
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    collectionViewFlowLayout.minimumLineSpacing = 8.0;
    collectionViewFlowLayout.minimumInteritemSpacing = 8.0;
    collectionViewFlowLayout.itemSize = CGSizeMake(100.0, 100.0);
    collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0, 10.0, 0, 10.0);
    
    collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:collectionViewFlowLayout];
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    
    AutomaticallyAdjustsScrollViewInsets_NO(self.collectionView, self);
}

- (void)setupNoDataView
{
    UIImage *noDataImage = [UIImage imageNamed:NoDataImageName];
    UIButton *noDataButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [noDataButton setImage:noDataImage forState:UIControlStateNormal];
    [noDataButton addTarget:self action:@selector(noDataButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.collectionView addSubview:noDataButton];
    [noDataButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.collectionView);
        make.width.mas_equalTo(noDataImage.size.width);
        make.height.mas_equalTo(noDataImage.size.height);
    }];
    
    self.noDataView = noDataButton;
    self.noDataView.hidden = NO;
}

- (void)noDataButtonClick
{
    if (self.needPullDownRefreshing && self.collectionView.mj_header.state == MJRefreshStateIdle)
    {
        [self.collectionView.mj_header beginRefreshing];
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
        self.collectionView.mj_header = [JKRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        self.collectionView.mj_footer = [JKRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    else
    {
        MJRefreshNormalHeader *refreshNormalHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        [refreshNormalHeader setTitle:HeaderRefreshStateIdleTitle forState:MJRefreshStateIdle];
        [refreshNormalHeader setTitle:HeaderRefreshStatePullingTitle forState:MJRefreshStatePulling];
        [refreshNormalHeader setTitle:HeaderRefreshStateRefreshingTitle forState:MJRefreshStateRefreshing];
        refreshNormalHeader.lastUpdatedTimeLabel.hidden = YES;
        self.collectionView.mj_header = refreshNormalHeader;
        MJRefreshAutoNormalFooter *refreshAutoNormalFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        [refreshAutoNormalFooter setTitle:FooterRefreshStateIdleTitle forState:MJRefreshStateIdle];
        [refreshAutoNormalFooter setTitle:FooterRefreshStateRefreshingTitle forState:MJRefreshStateRefreshing];
        [refreshAutoNormalFooter setTitle:FooterRefreshStateNoMoreDataTitle forState:MJRefreshStateNoMoreData];
        self.collectionView.mj_footer = refreshAutoNormalFooter;
    }
    
    self.collectionView.mj_header.hidden = !self.needPullDownRefreshing;
    self.collectionView.mj_footer.hidden = YES;
    
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
    [DLNetworkManager getRequestWithInterfaceName:self.interfaceName parameters:self.parameters success:^(id responseObject) {
        
        [self disposeSuccess:responseObject];
        
    } failure:^(NSError *error) {
        
        [self disposeError:error];
        
    } showHUDWithStatus:self.showLoadingHUD ? HUD_LOADING_STATUS : nil cache:self.page == 1 ? self.responseCache : NO];
}

- (void)endRefreshingWithCount:(NSNumber *)count
{
    [self.collectionView.mj_header endRefreshing];
    
    if (self.page == 1)
    {
        [self.collectionView.mj_footer resetNoMoreData];
    }
    
    if ((count != nil && self.models.count == [count integerValue]) || self.models.count % [PageSize integerValue] != 0)
    {
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    }
    else
    {
        [self.collectionView.mj_footer endRefreshing];
    }
}

- (void)showPromptStatus
{
    self.noDataView.hidden = self.models.count > 0;
    
    self.collectionView.mj_footer.hidden = self.models.count <= 0 || !self.needPullUpRefreshing;
}

- (void)disposeNULLResponse
{
    if (self.page > 1)
    {
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    }
    
    if (self.page > 1)
    {
        self.page -= 1;
    }
}

- (void)disposeSuccess:(id)responseObject
{
    NSNumber *code = [responseObject valueForKey:@"code"];
    NSString *message = [responseObject valueForKey:@"message"];
    if (![code.description isEqualToString:@"0"])
    {
        [self disposeError:[NSString isEmptyWithStr:message] ? @"请求失败" : message];
        return;
    }
    
    NSNumber *total = responseObject[@"page"][@"total"];
    
    NSMutableArray *dataArray = [self.modelClass mj_objectArrayWithKeyValuesArray:responseObject[@"datas"]];
    
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
        
        [self.collectionView reloadData];
        
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

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.models.count;
}

//一般情况下子类需要重写此方法
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    
    UIImageView *imageView = nil;
    if (cell.backgroundView && [cell.backgroundView isKindOfClass:[UIImageView class]])
    {
        imageView = (UIImageView *)(cell.backgroundView);
    }
    else
    {
        imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        cell.backgroundView = imageView;
    }
    
    //model,image
    
    return cell;
}

#pragma mark - UICollectionViewDelegate


@end
