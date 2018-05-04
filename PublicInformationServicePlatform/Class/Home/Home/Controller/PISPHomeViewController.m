//
//  PISPHomeViewController.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/3/28.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPHomeViewController.h"

#import "PISPDemoViewController.h"

#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#import "YANScrollMenu.h"

#import "PISPHomeHeadTableViewCell.h"
#import "PISPHomeMenuTableViewCell.h"
#import "PISPHomeTitleHeaderView.h"
#import "PISPHomeScenicTableViewCell.h"
#import "PISPHomeMoreFooterView.h"
#import "PISPHomeAnotherMenuTableViewCell.h"
#import "PISPHomeSurroundingTableViewCell.h"

#import "PISPHomeMenuModel.h"
#import "PISPWeatherModel.h"
#import "PISPPeopleCountModel.h"
#import "PISPNotMissScenicSpotModel.h"

static NSString *Head = @"Head";
static NSString *Menu = @"Menu";
static NSString *Scenic = @"了解景区";
static NSString *AnotherMenu = @"AnotherMenu";
static NSString *Surrounding = @"周边好玩";

@interface PISPHomeViewController ()<UITableViewDataSource, UITableViewDelegate, PISPHomeHeadTableViewCellDelegate, PISPHomeMenuTableViewCellDelegate, PISPHomeScenicTableViewCellDelegate, UIScrollViewDelegate, UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableView_bottom;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray<NSString *> *sectionHeaderTitles;
@property (nonatomic, strong) NSMutableArray<PISPHomeMenuModel *> *menuModels;

@property (strong, nonatomic) UISearchController *searchController;

@property (nonatomic, strong) NSArray *imageURLStringsGroup;
@property (nonatomic, strong) NSArray *titlesGroup;

@property (nonatomic, strong) PISPWeatherModel *weatherModel;
@property (nonatomic, strong) PISPPeopleCountModel *peopleCountModel;
@property (nonatomic, strong) NSMutableArray<PISPNotMissScenicSpotModel *> *notMissScenicSpotModels;

@end

@implementation PISPHomeViewController

#pragma mark - Init
- (NSArray<NSString *> *)sectionHeaderTitles
{
    if (!_sectionHeaderTitles)
    {
        if (HideHomeSurroundingSection)
        {
            _sectionHeaderTitles = [[NSArray alloc] initWithObjects:Head,Menu,Scenic,AnotherMenu, nil];
        }
        else
        {
            _sectionHeaderTitles = [[NSArray alloc] initWithObjects:Head,Menu,Scenic,AnotherMenu,Surrounding, nil];
        }
    }
    return _sectionHeaderTitles;
}

- (NSMutableArray<PISPHomeMenuModel *> *)menuModels
{
    if (!_menuModels)
    {
        NSArray<NSString *> *imageNames = [[NSArray alloc] initWithObjects:@"home_entrance_spot",@"home_entrance_book",@"home_entrance_camera",@"home_entrance_scenic",@"home_entrance_panorama",@"home_entrance_service",@"home_entrance_robot",@"home_entrance_report", nil];
        NSArray<NSString *> *descriptions = [[NSArray alloc] initWithObjects:@"了解景区",@"预订服务",@"识你所见",@"探风景",@"720全景",@"出行服务",@"智能机器人",@"一键报警", nil];
        NSMutableArray<PISPHomeMenuModel *> *array = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < imageNames.count; i++)
        {
            PISPHomeMenuModel *model = [[PISPHomeMenuModel alloc] init];
            model.itemImage = [UIImage imageNamed:imageNames[i]];
            model.itemDescription = descriptions[i];
            [array addObject:model];
        }
        _menuModels = array;
    }
    return _menuModels;
}

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
        _searchController.searchBar.placeholder = @"请输入关键字进行搜索";
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

- (PISPPeopleCountModel *)peopleCountModel
{
    if (!_peopleCountModel)
    {
        _peopleCountModel = [[PISPPeopleCountModel alloc] init];
    }
    return _peopleCountModel;
}

#pragma mark - SetupUI
- (void)setupUI
{
    self.navBarBgAlpha = @"0.0";
    
//    self.navigationItem.titleView = self.searchController.searchBar;
    
    [self setupTableView];
}

- (void)setupTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PISPHomeHeadTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([PISPHomeHeadTableViewCell class])];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([UITableViewHeaderFooterView class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PISPHomeMenuTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([PISPHomeMenuTableViewCell class])];
    [self.tableView registerClass:[PISPHomeTitleHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([PISPHomeTitleHeaderView class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PISPHomeScenicTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([PISPHomeScenicTableViewCell class])];
    [self.tableView registerClass:[PISPHomeMoreFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([PISPHomeMoreFooterView class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PISPHomeAnotherMenuTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([PISPHomeAnotherMenuTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PISPHomeSurroundingTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([PISPHomeSurroundingTableViewCell class])];
    
    AutomaticallyAdjustsScrollViewInsets_NO(self.tableView, self);
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
}

#pragma mark - RequestData
- (void)requestData
{
    [self getSceneryIndexImg];
    [self getSceneryWeatherInfo];
    [self getMaxCapacity];
    [self getRealTimeCount];
    [self getChildren];
}

//获取首页封面图
- (void)getSceneryIndexImg
{
    NSMutableDictionary *parameters = [NSMutableDictionary parameters];
    parameters[@"num"] = @"5";
    [DLNetworkManager getRequestWithInterfaceName:@"index/getSceneryIndexImg" parameters:parameters success:^(id responseObject) {
        NSNumber *code = responseObject[@"code"];
        NSString *message = responseObject[@"message"];
        if ([code.description isEqualToString:@"0"])
        {
            NSArray *datas = responseObject[@"datas"];
            NSMutableArray<NSString *> *names = [[NSMutableArray alloc] init];
            NSMutableArray<NSString *> *paths = [[NSMutableArray alloc] init];
            for (NSInteger i = 0; i < datas.count; i++)
            {
                NSDictionary *data = datas[i];
                [names addObject:[NSString ifIsEmptyWithStr:data[@"name"]]];
                [paths addObject:[[NSString ifIsEmptyWithStr:data[@"path"]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
            }
            self.titlesGroup = names;
            self.imageURLStringsGroup = paths;
            [self.tableView reloadData];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:message];
        }
    } failure:nil];
}

//获取景区实时天气
- (void)getSceneryWeatherInfo
{
    NSMutableDictionary *parameters = [NSMutableDictionary parameters];
    [DLNetworkManager getRequestWithInterfaceName:@"index/getSceneryWeatherInfo" parameters:parameters success:^(id responseObject) {
        NSNumber *code = responseObject[@"code"];
        NSString *message = responseObject[@"message"];
        if ([code.description isEqualToString:@"0"])
        {
            self.weatherModel = [PISPWeatherModel mj_objectWithKeyValues:responseObject[@"data"]];
            [self.tableView reloadData];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:message];
        }
    } failure:nil];
}

//景区最大承载量
- (void)getMaxCapacity
{
    NSMutableDictionary *parameters = [NSMutableDictionary parameters];
    [DLNetworkManager getRequestWithInterfaceName:@"index/getMaxCapacity" parameters:parameters success:^(id responseObject) {
        NSNumber *code = responseObject[@"code"];
        NSString *message = responseObject[@"message"];
        if ([code.description isEqualToString:@"0"])
        {
            self.peopleCountModel.maxCapacity = [(NSNumber *)(responseObject[@"data"]) integerValue];
            [self.tableView reloadData];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:message];
        }
    } failure:nil];
}

//景区实时人数
- (void)getRealTimeCount
{
    NSMutableDictionary *parameters = [NSMutableDictionary parameters];
    [DLNetworkManager getRequestWithInterfaceName:@"index/getRealTimeCount" parameters:parameters success:^(id responseObject) {
        NSNumber *code = responseObject[@"code"];
        NSString *message = responseObject[@"message"];
        if ([code.description isEqualToString:@"0"])
        {
            self.peopleCountModel.realTimeCount = [(NSNumber *)(responseObject[@"data"]) integerValue];
            [self.tableView reloadData];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:message];
        }
    } failure:nil];
}

//不能错过的景点
- (void)getChildren
{
    NSMutableDictionary *parameters = [NSMutableDictionary parameters];
    parameters[@"page"] = @"1";
    parameters[@"limitPage"] = PageSize;
    [DLNetworkManager getRequestWithInterfaceName:@"index/children" parameters:parameters success:^(id responseObject) {
        NSNumber *code = responseObject[@"code"];
        NSString *message = responseObject[@"message"];
        if ([code.description isEqualToString:@"0"])
        {
            self.notMissScenicSpotModels = [PISPNotMissScenicSpotModel mj_objectArrayWithKeyValuesArray:responseObject[@"datas"]];
            [self.tableView reloadData];
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
    
    [self setupUI];
    
    [self requestData];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
//    self.tableView_bottom.constant = [self bottomBarHeight];
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
    
//    self.navBarBgAlpha = @"0.0";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HomeViewWillAppear object:nil];
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.tableView.contentOffset.y < 0.0)
    {
//        [self.navigationController setNeedsNavigationBackground:0.0];
        self.navBarBgAlpha = @"0.0";
    }
    else if (self.tableView.contentOffset.y > self.topBarHeight)
    {
        self.navBarBgAlpha = @"1.0";
    }
    else
    {
        self.navBarBgAlpha = [NSString stringWithFormat:@"%.1lf",self.tableView.contentOffset.y / self.topBarHeight];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sectionHeaderTitle = self.sectionHeaderTitles[indexPath.section];
    if ([sectionHeaderTitle isEqualToString:Head])
    {
        PISPHomeHeadTableViewCell *cell = (PISPHomeHeadTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PISPHomeHeadTableViewCell class]) forIndexPath:indexPath];
        
        cell.titlesGroup = self.titlesGroup;
        cell.imageURLStringsGroup = self.imageURLStringsGroup;
        cell.weatherModel = self.weatherModel;
        cell.peopleCountModel = self.peopleCountModel;
        
        cell.delegate = self;
        
        return cell;
    }
    else if ([sectionHeaderTitle isEqualToString:Menu])
    {
        PISPHomeMenuTableViewCell *cell = (PISPHomeMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PISPHomeMenuTableViewCell class]) forIndexPath:indexPath];
        cell.delegate = self;
        cell.models = self.menuModels;
        
        return cell;
    }
    else if ([sectionHeaderTitle isEqualToString:Scenic])
    {
        PISPHomeScenicTableViewCell *cell = (PISPHomeScenicTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PISPHomeScenicTableViewCell class]) forIndexPath:indexPath];
        cell.models = self.notMissScenicSpotModels;
        
        cell.delegate = self;
        
        return cell;
    }
    else if ([sectionHeaderTitle isEqualToString:AnotherMenu])
    {
        PISPHomeAnotherMenuTableViewCell *cell = (PISPHomeAnotherMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PISPHomeAnotherMenuTableViewCell class]) forIndexPath:indexPath];
        
        GetWeakSelf
        cell.viewTaped = ^(UIView *view) {
            switch (view.tag)
            {
                case 1:
                {
                    //游览须知
                    [weakSelf.navigationController pushWebViewControllerWithURLString:[WebBaseURLString stringByAppendingString:DetailHtmlCode(@"ylxz")]];
                }
                    break;
                case 2:
                {
                    //票务政策
                    [weakSelf.navigationController pushWebViewControllerWithURLString:[WebBaseURLString stringByAppendingString:DetailHtmlCode(@"pwzc")]];
                }
                    break;
                case 3:
                {
                    //开放时间
                    [weakSelf.navigationController pushWebViewControllerWithURLString:[WebBaseURLString stringByAppendingString:DetailHtmlCode(@"kfsj")]];
                }
                    break;
                case 4:
                {
                    //景区交通
                    [weakSelf.navigationController pushWebViewControllerWithURLString:[WebBaseURLString stringByAppendingString:@"scenic-traffic.html"]];
                }
                    break;
                    
                default:
                    break;
            }
        };
        
        return cell;
    }
    else if ([sectionHeaderTitle isEqualToString:Surrounding])
    {
        PISPHomeSurroundingTableViewCell *cell = (PISPHomeSurroundingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PISPHomeSurroundingTableViewCell class]) forIndexPath:indexPath];
        
        GetWeakSelf
        cell.buttonClicked = ^(UIButton *button) {
            switch (button.tag)
            {
                case 1:
                {
                    //景区
                    
                    
                }
                    break;
                case 2:
                {
                    //酒店
                }
                    break;
                case 3:
                {
                    //美食
                }
                    break;
                case 4:
                {
                    //购物
                }
                    break;
                case 5:
                {
                    //娱乐
                }
                    break;
                    
                default:
                    break;
            }
        };
        
        return cell;
    }
    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionHeaderTitles.count;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString *sectionHeaderTitle = self.sectionHeaderTitles[section];
    NSArray<NSString *> *array = @[Head,Menu,AnotherMenu];
    if ([array containsObject:sectionHeaderTitle])
    {
        return CGFLOAT_MIN;
    }
    else
    {
        return UITableViewAutomaticDimension;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSString *sectionHeaderTitle = self.sectionHeaderTitles[section];
    NSArray<NSString *> *array = @[Head,Menu,AnotherMenu];
    if ([array containsObject:sectionHeaderTitle])
    {
        return 10.0;
    }
    else if ([sectionHeaderTitle isEqualToString:Surrounding])
    {
        return CGFLOAT_MIN;
    }
    else
    {
        return UITableViewAutomaticDimension;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200.0;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    NSString *sectionHeaderTitle = self.sectionHeaderTitles[section];
    NSArray<NSString *> *array = @[Head,Menu,AnotherMenu];
    if ([array containsObject:sectionHeaderTitle])
    {
        return 1.01;
    }
    else
    {
        return 60.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section
{
    NSString *sectionHeaderTitle = self.sectionHeaderTitles[section];
    NSArray<NSString *> *array = @[Head,Menu,AnotherMenu];
    if ([array containsObject:sectionHeaderTitle])
    {
        return 10.0;
    }
    else if ([sectionHeaderTitle isEqualToString:Surrounding])
    {
        return 1.01;
    }
    else
    {
        return 70.0;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *sectionHeaderTitle = self.sectionHeaderTitles[section];
    NSArray<NSString *> *array = @[Head,Menu,AnotherMenu];
    if ([array containsObject:sectionHeaderTitle])
    {
        return nil;
    }
    else
    {
        PISPHomeTitleHeaderView *view = (PISPHomeTitleHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([PISPHomeTitleHeaderView class])];
        NSString *title = self.sectionHeaderTitles[section];
        view.title = title;
        
        GetWeakSelf
        view.checkAllButtonClicked = ^(UIButton *button) {
            if ([title isEqualToString:Scenic])
            {
                [weakSelf performSegueWithIdentifier:@"Home2NotMissScenicSpot" sender:nil];
            }
        };
        
        return view;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSString *sectionHeaderTitle = self.sectionHeaderTitles[section];
    NSArray<NSString *> *array = @[Head,Menu,AnotherMenu];
    if ([array containsObject:sectionHeaderTitle])
    {
        UITableViewHeaderFooterView *view = (UITableViewHeaderFooterView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([UITableViewHeaderFooterView class])];
        view.contentView.backgroundColor = UIColorFromRGB(0xF5F5F5);
        return view;
    }
    else if ([sectionHeaderTitle isEqualToString:Surrounding])
    {
        return nil;
    }
    else
    {
        PISPHomeMoreFooterView *view = (PISPHomeMoreFooterView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([PISPHomeMoreFooterView class])];
        
        GetWeakSelf
        view.moreButtonClicked = ^(UIButton *button) {
            [weakSelf performSegueWithIdentifier:@"Home2NotMissScenicSpot" sender:nil];
        };
        
        return view;
    }
}

#pragma mark - PISPHomeHeadTableViewCellDelegate
- (void)didSelectCycleScrollViewItemAtIndex:(NSInteger)index
{
    
}

#pragma mark - PISPHomeMenuTableViewCellDelegate
- (void)didSelectScrollMenuItemAtIndexPath:(NSIndexPath *)indexPath
{
    //测试Push
//    [self.navigationController pushViewController:[[PISPDemoViewController alloc] init] animated:YES];
    NSInteger index = indexPath.section * MenuSectionMaxItemCount + indexPath.item;
    PISPHomeMenuModel *model = self.menuModels[index];
    if ([model.itemDescription isEqualToString:@"了解景区"])
    {
        [self performSegueWithIdentifier:@"Home2UnderstandingScenicSpot" sender:nil];
    }
    else if ([model.itemDescription isEqualToString:@"识你所见"])
    {
        [self performSegueWithIdentifier:@"Home2KnowYouCanSee" sender:nil];
    }
    else if ([model.itemDescription isEqualToString:@"出行服务"])
    {
        [self performSegueWithIdentifier:@"Home2TravelService" sender:nil];
    }
    else if ([model.itemDescription isEqualToString:@"一键报警"])
    {
        [self performSegueWithIdentifier:@"Home2AKeyAlarm" sender:nil];
    }
    else if ([model.itemDescription isEqualToString:@"预订服务"])
    {
        [self.tabBarController setSelectedIndex:1];
    }
}

#pragma mark - PISPHomeScenicTableViewCellDelegate
- (void)didSelectCollectionViewItemAtIndexPath:(NSIndexPath *)indexPath
{
    //测试弹出登录界面
    [self authenticateUserLoginWithBlock:nil];
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

@end
