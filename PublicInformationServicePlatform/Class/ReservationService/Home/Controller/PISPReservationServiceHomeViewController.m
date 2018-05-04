//
//  PISPReservationServiceHomeViewController.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/3/28.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPReservationServiceHomeViewController.h"

#import "PISPReservationServiceHomeModel.h"
#import "PISPReservationServiceHomeTableViewCell.h"

@interface PISPReservationServiceHomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableView_top;

@property (nonatomic, strong) NSMutableArray<PISPReservationServiceHomeModel *> *models;

@end

@implementation PISPReservationServiceHomeViewController

- (NSMutableArray<PISPReservationServiceHomeModel *> *)models
{
    if (!_models)
    {
        NSArray<NSString *> *backgroundImageNames = nil;
        backgroundImageNames = @[@"book_index_tickets_normal",@"book_index_hotel_normal",@"book_index_goods_normal"];
//        backgroundImageNames = @[@"book_index_tickets_normal",@"book_index_hotel_normal",@"book_index_goods_normal",@"book_index_food_normal",@"book_index_fun_normal",@"book_index_guide_normal"];
        NSMutableArray<PISPReservationServiceHomeModel *> *array = [[NSMutableArray alloc] init];
        for (NSString *backgroundImageName in backgroundImageNames)
        {
            PISPReservationServiceHomeModel *model = [[PISPReservationServiceHomeModel alloc] init];
            model.backgroundImageName = backgroundImageName;
            model.backgroundImage = [UIImage imageNamed:backgroundImageName];
            [array addObject:model];
        }
        _models = array;
    }
    return _models;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 16.0)];
    tableHeaderView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = tableHeaderView;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    AutomaticallyAdjustsScrollViewInsets_NO(self.tableView, self);
    self.tableView_top.constant = self.topBarHeight;
    
    self.tableView.estimatedRowHeight = 100.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PISPReservationServiceHomeTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([PISPReservationServiceHomeTableViewCell class])];
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PISPReservationServiceHomeTableViewCell *cell = (PISPReservationServiceHomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PISPReservationServiceHomeTableViewCell class]) forIndexPath:indexPath];
    PISPReservationServiceHomeModel *model = self.models[indexPath.row];
    cell.model = model;
    GetWeakSelf
    cell.viewTaped = ^{
        if ([model.backgroundImageName isEqualToString:@"book_index_tickets_normal"])
        {
            //门票
            [weakSelf authenticateUserLoginWithBlock:^{
                [weakSelf.navigationController pushWebViewControllerWithURLString:JKBReservationURLString(JKBTicketReservationWid)];
            }];
        }
        else if ([model.backgroundImageName isEqualToString:@"book_index_hotel_normal"])
        {
            //酒店
            [weakSelf authenticateUserLoginWithBlock:^{
                [weakSelf.navigationController pushWebViewControllerWithURLString:JKBReservationURLString(JKBHotelReservationWid)];
            }];
        }
        else if ([model.backgroundImageName isEqualToString:@"book_index_goods_normal"])
        {
            //特产
            [weakSelf authenticateUserLoginWithBlock:^{
                [weakSelf.navigationController pushWebViewControllerWithURLString:JKBReservationURLString(JKBSpecialtyReservationWid)];
            }];
        }
    };
    return cell;
}

@end
