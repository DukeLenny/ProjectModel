//
//  PISPScenicSpotAnnouncementViewController.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/9.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPScenicSpotAnnouncementViewController.h"

#import "UIViewController+Cloudox.h"

#import "PISPScenicSpotAnnouncementTableViewCell.h"
#import "PISPScenicSpotAnnouncementModel.h"

@interface PISPScenicSpotAnnouncementViewController ()

@end

@implementation PISPScenicSpotAnnouncementViewController

#pragma mark - Init
- (void)setupProperties
{
    [super setupProperties];
    
    self.interfaceName = @"siteNotice/list";
    self.parameters[@"chanelId"] = @"";
    self.parameters[@"title"] = @"";
    [self.parameters addDefaultParameters];
    self.modelClass = [PISPScenicSpotAnnouncementModel class];
}

- (void)setupTableView
{
    [super setupTableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PISPScenicSpotAnnouncementTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([PISPScenicSpotAnnouncementTableViewCell class])];
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 20.0)];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.and.bottom.and.trailing.equalTo(self.view);
        make.top.mas_equalTo([self topBarHeight]);
    }];
}

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColorFromRGB(0xF2F2F2);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navBarBgAlpha = @"1.0";
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
    PISPScenicSpotAnnouncementTableViewCell *cell = (PISPScenicSpotAnnouncementTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PISPScenicSpotAnnouncementTableViewCell class]) forIndexPath:indexPath];
    PISPScenicSpotAnnouncementModel *model = self.models[indexPath.row];
    cell.model = model;
    
    GetWeakSelf
    cell.viewTaped = ^{
        [weakSelf.navigationController pushWebViewControllerWithURLString:[NSString stringWithFormat:@"%@notice-detail.html?id=%ld",WebBaseURLString,model.ID]];
    };
    
    return cell;
}

@end
