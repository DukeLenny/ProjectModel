//
//  PISPUnderstandingScenicSpotViewController.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/8.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPUnderstandingScenicSpotViewController.h"

#import "UIViewController+Cloudox.h"
#import "YANScrollMenu.h"
#import "PISPHomeMenuModel.h"
#import "PISPScenicSpotAnnouncementModel.h"

static const CGFloat MenuSectionItemHeight = 104.0;

static const NSInteger MenuSectionMaxColumnCount = 3;
static const NSInteger MenuSectionMaxRowCount = 4;
#define MenuSectionMaxItemCount (MenuSectionMaxColumnCount * MenuSectionMaxRowCount)

@interface PISPUnderstandingScenicSpotViewController ()<YANScrollMenuDelegate, YANScrollMenuDataSource>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabel_top;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UIView *notificationView;
@property (weak, nonatomic) IBOutlet UILabel *notificationContentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollMenuView_height;
@property (weak, nonatomic) IBOutlet UIView *scrollMenuView;

@property (nonatomic, strong) YANScrollMenu *scrollMenu;
@property (nonatomic, strong) NSMutableArray<NSArray<PISPHomeMenuModel *> *> *dataSource;

@property (nonatomic, strong) PISPScenicSpotAnnouncementModel *scenicSpotAnnouncementModel;

@end

@implementation PISPUnderstandingScenicSpotViewController

#pragma mark - Event
- (void)notificationViewTaped
{
    [self performSegueWithIdentifier:@"UnderstandingScenicSpot2ScenicSpotAnnouncement" sender:nil];
}

#pragma mark - Init
- (NSMutableArray<NSArray<PISPHomeMenuModel *> *> *)dataSource
{
    if (!_dataSource)
    {
        NSArray<NSString *> *itemImageNames = @[@"spot_icon_introduction",@"spot_icon_notice",@"spot_icon_tickets",@"spot_icon_time",@"spot_icon_traffic",@"spot_icon_culture",@"spot_icon_announcement",@"spot_icon_strategy",@"spot_icon_custom",@"spot_icon_faq",@"spot_icon_img",@"spot_icon_video"];
        NSArray<NSString *> *itemDescriptions = @[@"景区简介",@"游览须知",@"票务政策",@"开放时间",@"景区交通",@"景区文化",@"景区公告",@"游玩攻略",@"民风民俗",@"FAQ专区",@"景区画册",@"宣传视频"];
        NSMutableArray<PISPHomeMenuModel *> *array = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < itemImageNames.count; i++)
        {
            PISPHomeMenuModel *model = [[PISPHomeMenuModel alloc] init];
            model.itemImage = [UIImage imageNamed:itemImageNames[i]];
            model.itemDescription = itemDescriptions[i];
            [array addObject:model];
        }
        _dataSource = [NSMutableArray doubleDimensionalArrayWithOneDimensionalArray:[NSArray arrayWithArray:array] everySectionMaxItemCount:MenuSectionMaxItemCount];
    }
    return _dataSource;
}

- (void)setScenicSpotAnnouncementModel:(PISPScenicSpotAnnouncementModel *)scenicSpotAnnouncementModel
{
    _scenicSpotAnnouncementModel = scenicSpotAnnouncementModel;
    
    self.notificationContentLabel.text = [NSString ifIsEmptyWithStr:scenicSpotAnnouncementModel.title];
}

#pragma mark - SetupUI
- (void)setupUI
{
    AutomaticallyAdjustsScrollViewInsets_NO(self.scrollView, self);
    
    self.nameLabel_top.constant = self.topBarHeight + 20.0;
    
    [self setupYANScrollMenu];
    
    [self setupYANMenuItem];
    
    [self.notificationView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(notificationViewTaped)]];
}

- (void)setupYANScrollMenu
{
    self.scrollMenu = [[YANScrollMenu alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 451.0) delegate:self];
    self.scrollMenu.backgroundColor = [UIColor clearColor];
    [self.scrollMenuView addSubview:self.scrollMenu];
}

- (void)setupYANMenuItem
{
    UIImage *iconImage = [UIImage imageNamed:@"spot_icon_introduction"];
    MenuItem.iconSize = iconImage.size;
    MenuItem.space = 8.0;
    MenuItem.iconCornerRadius = iconImage.size.height / 2.0;
    MenuItem.textColor = [UIColor whiteColor];
    MenuItem.textFont = [UIFont systemFontOfSize:14.0];
    MenuItem.backgroundColor = [UIColor clearColor];
}

#pragma mark - RequestData
- (void)requestData
{
    [self.scrollMenu reloadData];
    
    self.scrollMenuView_height.constant = self.scrollMenu.mj_h;
    
    [self getSiteNoticeList];
}

- (void)getSiteNoticeList
{
    NSMutableDictionary *parameters = [NSMutableDictionary parameters];
    parameters[@"title"] = @"";
    parameters[@"limitPage"] = PageSize;
    parameters[@"chanelId"] = @"";
    parameters[@"page"] = @"1";
    [DLNetworkManager getRequestWithInterfaceName:@"siteNotice/list" parameters:parameters success:^(id responseObject) {
        NSNumber *code = responseObject[@"code"];
        NSString *message = responseObject[@"message"];
        if ([code.description isEqualToString:@"0"])
        {
            NSArray *datas = responseObject[@"datas"];
            if (datas.count > 0)
            {
                self.scenicSpotAnnouncementModel = [PISPScenicSpotAnnouncementModel mj_objectArrayWithKeyValuesArray:datas][0];
            }
            else
            {
                self.scenicSpotAnnouncementModel = nil;
            }
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:message];
        }
    } failure:nil];
}

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [self requestData];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.notificationView.layer.cornerRadius = self.notificationView.bounds.size.height / 2.0;
    self.notificationView.layer.masksToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navBarBgAlpha = @"0.0";
    [self setupYANMenuItem];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - YANScrollMenuDelegate
- (CGSize)itemSizeOfScrollMenu:(YANScrollMenu *)menu
{
    return CGSizeMake(SCREEN_WIDTH / MenuSectionMaxColumnCount, MenuSectionItemHeight);
}

- (BOOL)shouldAutomaticUpdateFrameInScrollMenu:(YANScrollMenu *)menu
{
    return YES;
}

- (void)scrollMenu:(YANScrollMenu *)menu didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PISPHomeMenuModel *model = self.dataSource[indexPath.section][indexPath.item];
    if ([model.itemDescription isEqualToString:@"景区公告"])
    {
        [self performSegueWithIdentifier:@"UnderstandingScenicSpot2ScenicSpotAnnouncement" sender:nil];
    }
    else if ([model.itemDescription isEqualToString:@"游玩攻略"])
    {
        [self performSegueWithIdentifier:@"UnderstandingScenicSpot2TravelGuide" sender:nil];
    }
    else if ([model.itemDescription isEqualToString:@"景区画册"])
    {
        [self performSegueWithIdentifier:@"UnderstandingScenicSpot2ScenicPictureAlbum" sender:nil];
    }
    else if ([model.itemDescription isEqualToString:@"宣传视频"])
    {
        [self performSegueWithIdentifier:@"UnderstandingScenicSpot2PromotionalVideo" sender:nil];
    }
    else if ([model.itemDescription isEqualToString:@"景区简介"])
    {
        [self.navigationController pushWebViewControllerWithURLString:[WebBaseURLString stringByAppendingString:DetailHtmlCode(@"jqjj")]];
    }
    else if ([model.itemDescription isEqualToString:@"游览须知"])
    {
        [self.navigationController pushWebViewControllerWithURLString:[WebBaseURLString stringByAppendingString:DetailHtmlCode(@"ylxz")]];
    }
    else if ([model.itemDescription isEqualToString:@"票务政策"])
    {
        [self.navigationController pushWebViewControllerWithURLString:[WebBaseURLString stringByAppendingString:DetailHtmlCode(@"pwzc")]];
    }
    else if ([model.itemDescription isEqualToString:@"开放时间"])
    {
        [self.navigationController pushWebViewControllerWithURLString:[WebBaseURLString stringByAppendingString:DetailHtmlCode(@"kfsj")]];
    }
    else if ([model.itemDescription isEqualToString:@"景区交通"])
    {
        [self.navigationController pushWebViewControllerWithURLString:[WebBaseURLString stringByAppendingString:@"scenic-traffic.html"]];
    }
    else if ([model.itemDescription isEqualToString:@"景区文化"])
    {
        [self.navigationController pushWebViewControllerWithURLString:[WebBaseURLString stringByAppendingString:DetailHtmlCode(@"jqwh")]];
    }
    else if ([model.itemDescription isEqualToString:@"民风民俗"])
    {
        [self.navigationController pushWebViewControllerWithURLString:[WebBaseURLString stringByAppendingString:DetailHtmlCode(@"mfms")]];
    }
    else if ([model.itemDescription isEqualToString:@"FAQ专区"])
    {
        [self.navigationController pushWebViewControllerWithURLString:[WebBaseURLString stringByAppendingString:@"faq.html"]];
    }
    
}

- (CGFloat)heightOfHeaderInScrollMenu:(YANScrollMenu *)menu
{
    return 0.0;
}

#pragma mark - YANScrollMenuDataSource
- (NSUInteger)scrollMenu:(YANScrollMenu *)menu numberOfItemsInSection:(NSInteger)section
{
    return section < self.dataSource.count ? self.dataSource[section].count : 0;
}

- (NSUInteger)numberOfSectionsInScrollMenu:(YANScrollMenu *)menu
{
    return self.dataSource.count;
}

- (id<YANObjectProtocol>)scrollMenu:(YANScrollMenu *)scrollMenu objectAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < self.dataSource.count)
    {
        if (indexPath.item < self.dataSource[indexPath.section].count)
        {
            return self.dataSource[indexPath.section][indexPath.item];
        }
    }
    return nil;
}

@end
