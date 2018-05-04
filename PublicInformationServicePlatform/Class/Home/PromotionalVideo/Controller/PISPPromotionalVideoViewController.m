//
//  PISPPromotionalVideoViewController.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/10.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPPromotionalVideoViewController.h"

#import "PISPPromotionalVideoModel.h"
#import "PISPPromotionalVideoTableViewCell.h"

#import "UIViewController+Cloudox.h"

@interface PISPPromotionalVideoViewController ()

@end

@implementation PISPPromotionalVideoViewController

#pragma mark - Init
- (void)setupProperties
{
    [super setupProperties];
    
    self.interfaceName = @"scenery/getSceneryVideo";
    
    self.parameters[@"name"] = @"";
    [self.parameters addDefaultParameters];
    
    self.modelClass = [PISPPromotionalVideoModel class];
}

- (void)setupTableView
{
    [super setupTableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PISPPromotionalVideoTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([PISPPromotionalVideoTableViewCell class])];
    
//    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 20.0)];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.and.bottom.and.trailing.equalTo(self.view);
        make.top.mas_equalTo([self topBarHeight]);
    }];
}

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
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
    PISPPromotionalVideoTableViewCell *cell = (PISPPromotionalVideoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PISPPromotionalVideoTableViewCell class]) forIndexPath:indexPath];
    PISPPromotionalVideoModel *model = self.models[indexPath.row];
    cell.model = model;
    
    GetWeakSelf
    cell.playVideoAction = ^(UIButton *button) {
        [weakSelf presentAVPlayerViewControllerWithVideoURLString:model.upload];
    };
    
    return cell;
}

@end
