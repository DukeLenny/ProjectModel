//
//  PISPTravelGuideViewController.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/9.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPTravelGuideViewController.h"

#import "UIViewController+Cloudox.h"

#import "PISPTravelGuideModel.h"
#import "PISPTravelGuideTableViewCell.h"

@interface PISPTravelGuideViewController ()<UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate>

@property (strong, nonatomic) UISearchController *searchController;

@end

@implementation PISPTravelGuideViewController

#pragma mark - Init
- (void)setupProperties
{
    [super setupProperties];
    
    self.interfaceName = @"travelStrategy/list";
    self.parameters[@"chanelId"] = @"";
    self.parameters[@"title"] = @"";
    [self.parameters addDefaultParameters];
    
    self.modelClass = [PISPTravelGuideModel class];
}

- (void)setupTableView
{
    [super setupTableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PISPTravelGuideTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([PISPTravelGuideTableViewCell class])];
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.searchController.searchBar.bounds.size.height)];
    [tableHeaderView addSubview:self.searchController.searchBar];
//    self.tableView.tableHeaderView = tableHeaderView;
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.and.bottom.and.trailing.equalTo(self.view);
        make.top.mas_equalTo([self topBarHeight]);
    }];
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
//        _searchController.searchBar.tintColor = NavigationBarBarTintColor;
//        _searchController.searchBar.barTintColor = [UIColor whiteColor];
        _searchController.searchBar.searchBarStyle = UISearchBarStyleProminent;
//        [_searchController.searchBar setImage:[UIImage imageNamed:@"home_search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        //        [_searchController.searchBar setImage:[UIImage imageNamed:@"SearchBarIconClear"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
//        UITextField *searchField = [_searchController.searchBar valueForKey:@"_searchField"];
//        searchField.textColor = [UIColor blackColor];
//        [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_searchController.searchBar sizeToFit];
    }
    return _searchController;
}

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColorFromRGB(0xF2F2F2);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navBarBgAlpha = @"1.0";
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    UITextField *searchField = [self.searchController.searchBar valueForKey:@"_searchField"];
    searchField.layer.cornerRadius = searchField.bounds.size.height / 2.0;
    searchField.layer.masksToBounds = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PISPTravelGuideTableViewCell *cell = (PISPTravelGuideTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PISPTravelGuideTableViewCell class]) forIndexPath:indexPath];
    PISPTravelGuideModel *model = self.models[indexPath.row];
    cell.model = model;
    
    GetWeakSelf
    cell.viewTaped = ^{
        [weakSelf.navigationController pushWebViewControllerWithURLString:[NSString stringWithFormat:@"%@notes-detail.html?id=%ld",WebBaseURLString,model.ID]];
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

@end
