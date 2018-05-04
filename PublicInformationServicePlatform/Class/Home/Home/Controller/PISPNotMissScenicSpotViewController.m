//
//  PISPNotMissScenicSpotViewController.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/10.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPNotMissScenicSpotViewController.h"

#import <SDCycleScrollView/SDCycleScrollView.h>

#import "UIViewController+Cloudox.h"

#import "PISPNotMissScenicSpotModel.h"
#import "PISPNotMissScenicSpotTableViewCell.h"

#import "PISPBannerModel.h"

@interface PISPNotMissScenicSpotViewController ()<UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate, SDCycleScrollViewDelegate>

@property (strong, nonatomic) UISearchController *searchController;
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic, strong) NSArray *imageURLStringsGroup;
@property (nonatomic, strong) NSMutableArray<PISPBannerModel *> *bannerModels;

@end

@implementation PISPNotMissScenicSpotViewController

#pragma mark - Init
- (UISearchController *)searchController
{
    if (!_searchController)
    {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.delegate = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = NO;
        _searchController.searchBar.delegate = self;
        _searchController.searchBar.placeholder = @"搜索景点";
        _searchController.searchBar.tintColor = [UIColor whiteColor];
        _searchController.searchBar.barTintColor = [UIColor colorWithWhite:0.0 alpha:0.7];
        _searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
        [_searchController.searchBar setImage:[UIImage imageNamed:@"home_search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        //        [_searchController.searchBar setImage:[UIImage imageNamed:@"SearchBarIconClear"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
        UITextField *searchField = [_searchController.searchBar valueForKey:@"_searchField"];
        searchField.textColor = [UIColor whiteColor];
        [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_searchController.searchBar sizeToFit];
    }
    return _searchController;
}

- (void)setImageURLStringsGroup:(NSArray *)imageURLStringsGroup
{
    _imageURLStringsGroup = imageURLStringsGroup;
    
    self.cycleScrollView.imageURLStringsGroup = imageURLStringsGroup;
}

- (void)setupCycleScrollView
{
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.bannerView.bounds delegate:self placeholderImage:nil];
    
//    self.cycleScrollView.delegate = self;
    self.cycleScrollView.clipsToBounds = YES;
    self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
//    self.cycleScrollView.placeholderImage = [UIImage imageNamed:@"home_head_banner_defaultpic"];
    self.cycleScrollView.showPageControl = YES;
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    //    self.cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"home_circle_00_hover"];
    //    self.cycleScrollView.pageDotImage = [UIImage imageNamed:@"home_circle_00"];
    self.cycleScrollView.currentPageDotColor = [UIColor whiteColor];
    self.cycleScrollView.pageDotColor = [UIColor colorWithWhite:1.0 alpha:0.5];
//    self.cycleScrollView.titleLabelTextColor = [UIColor whiteColor];
//    self.cycleScrollView.titleLabelTextFont = [UIFont systemFontOfSize:10.0];
//    self.cycleScrollView.titleLabelBackgroundColor = [UIColor clearColor];
//    self.cycleScrollView.titleLabelHeight = 12.0;
//    self.cycleScrollView.titleLabelTextAlignment = NSTextAlignmentLeft;
    self.cycleScrollView.pageControlBottomOffset = 25.0;
    
    [self.bannerView addSubview:self.cycleScrollView];
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bannerView);
    }];
    
    
}

- (void)setupProperties
{
    [super setupProperties];
    
    self.needPullDownRefreshing = NO;
    
    self.interfaceName = @"index/children";
    [self.parameters addDefaultParameters];
    
    self.modelClass = [PISPNotMissScenicSpotModel class];
}

- (void)setupTableView
{
    [super setupTableView];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PISPNotMissScenicSpotTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([PISPNotMissScenicSpotTableViewCell class])];
    
//    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 20.0)];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.and.bottom.and.trailing.equalTo(self.view);
        make.top.mas_equalTo((SCREEN_WIDTH / (753.0 / 380.0)) - 24.0);
    }];
}

#pragma mark - RequestData
- (void)getSiteAdList
{
    NSMutableDictionary *parameters = [NSMutableDictionary parameters];
    parameters[@"posCode"] = @"";
    parameters[@"title"] = @"";
    parameters[@"page"] = @"1";
    parameters[@"limitPage"] = PageSize;
    [DLNetworkManager getRequestWithInterfaceName:@"siteAd/getSiteAdList" parameters:parameters success:^(id responseObject) {
        NSNumber *code = responseObject[@"code"];
        NSString *message = responseObject[@"message"];
        if ([code.description isEqualToString:@"0"])
        {
            self.bannerModels = [PISPBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"datas"]];
            [self reloadCycleScrollViewDataWithDatas:self.bannerModels];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:message];
        }
    } failure:nil];
}

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.navigationItem.titleView = self.searchController.searchBar;
    
    [self setupCycleScrollView];
    [self getSiteAdList];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    UITextField *searchField = [self.searchController.searchBar valueForKey:@"_searchField"];
    searchField.layer.cornerRadius = searchField.bounds.size.height / 2.0;
    searchField.layer.masksToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navBarBgAlpha = @"0.0";
    
    [self.cycleScrollView adjustWhenControllerViewWillAppera];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Tool
- (void)reloadCycleScrollViewDataWithDatas:(NSMutableArray<PISPBannerModel *> *)datas
{
    NSMutableArray<NSString *> *imageURLStringsGroup = [[NSMutableArray alloc] init];
    for (PISPBannerModel *model in datas)
    {
        [imageURLStringsGroup addObject:[[NSString ifIsEmptyWithStr:model.pics] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    }
    self.imageURLStringsGroup = imageURLStringsGroup;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PISPNotMissScenicSpotTableViewCell *cell = (PISPNotMissScenicSpotTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PISPNotMissScenicSpotTableViewCell class]) forIndexPath:indexPath];
    PISPNotMissScenicSpotModel *model = self.models[indexPath.row];
    cell.model = model;
    
    GetWeakSelf
    cell.buttonClicked = ^(UIButton *button) {
        switch (button.tag)
        {
            case 1:
            {
                //语音导览
            }
                break;
            case 2:
            {
                //720全景
                [weakSelf.navigationController pushWebViewControllerWithURLString:model.panoramaPathApp];
            }
                break;
            case 3:
            {
                //实景展播
                [weakSelf presentAVPlayerViewControllerWithVideoURLString:model.monitorPath];
            }
                break;
            case 4:
            {
                //AR
            }
                break;
                
            default:
                break;
        }
    };
    
    cell.viewTaped = ^{
        
    };
    
    return cell;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
}

#pragma mark - UISearchControllerDelegate
- (void)didPresentSearchController:(UISearchController *)searchController
{
    
}

- (void)didDismissSearchController:(UISearchController *)searchController
{
    
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    PISPBannerModel *bannerModel = self.bannerModels[index];
    [self.navigationController pushWebViewControllerWithURLString:bannerModel.url];
}

@end
