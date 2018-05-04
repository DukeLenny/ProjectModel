//
//  PISPKnowYouCanSeeViewController.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/11.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPKnowYouCanSeeViewController.h"

#import "UIViewController+Cloudox.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

#import "PISPKnowYouCanSeeModel.h"
#import "PISPKnowYouCanSeeTableViewCell.h"

#import "PISPBannerModel.h"

@interface PISPKnowYouCanSeeViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) NSArray *imageURLStringsGroup;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<PISPKnowYouCanSeeModel *> *models;

@property (nonatomic, strong) NSMutableArray<PISPBannerModel *> *bannerModels;

@end

@implementation PISPKnowYouCanSeeViewController

#pragma mark - Init
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

- (NSMutableArray<PISPKnowYouCanSeeModel *> *)models
{
    if (!_models)
    {
        NSArray<NSString *> *titles = @[@"识花草",@"识建筑",@"识文化"];
        NSArray<NSString *> *imageNames = @[@"spot_photograph_icon_plants",@"spot_photograph_icon_buildings",@"spot_photograph_icon_culture"];
        NSMutableArray<PISPKnowYouCanSeeModel *> *array = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < titles.count; i++)
        {
            PISPKnowYouCanSeeModel *model = [[PISPKnowYouCanSeeModel alloc] init];
            model.title = titles[i];
            model.imageName = imageNames[i];
            [array addObject:model];
        }
        _models = array;
    }
    return _models;
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

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupCycleScrollView];
    [self getSiteAdList];
    
    AutomaticallyAdjustsScrollViewInsets_NO(self.tableView, self);
    
    self.tableView.estimatedRowHeight = 100.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PISPKnowYouCanSeeTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([PISPKnowYouCanSeeTableViewCell class])];
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PISPKnowYouCanSeeTableViewCell *cell = (PISPKnowYouCanSeeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PISPKnowYouCanSeeTableViewCell class]) forIndexPath:indexPath];
    PISPKnowYouCanSeeModel *model = self.models[indexPath.row];
    cell.model = model;
    GetWeakSelf
    cell.viewTaped = ^{
        [weakSelf presentImagePickerControllerWithDataSource:model];
    };
    return cell;
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    PISPBannerModel *bannerModel = self.bannerModels[index];
    [self.navigationController pushWebViewControllerWithURLString:bannerModel.url];
}

#pragma mark - Tool
- (void)presentImagePickerControllerWithDataSource:(PISPKnowYouCanSeeModel *)model
{
    [self presentTZImagePickerControllerWithMaxImagesCount:1 columnNumber:4 selectedAssets:nil didFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
}

@end
