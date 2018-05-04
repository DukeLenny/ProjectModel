//
//  PISPHomeMenuTableViewCell.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/2.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPHomeMenuTableViewCell.h"

#import "YANScrollMenu.h"

#import "PISPHomeMenuModel.h"

static const CGFloat CellHeight = 190.0;
//static const CGFloat HeightOfPageControl = 15.0;
static const CGFloat MenuSectionItemHeight = 80.0;

@interface PISPHomeMenuTableViewCell()<YANScrollMenuDelegate, YANScrollMenuDataSource>

@property (nonatomic, weak) IBOutlet UIView *view;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *view_height;

@property (nonatomic, assign) NSInteger sectionNum;
@property (nonatomic, assign) NSInteger lastSectionItemNum;

@property (nonatomic, strong) YANScrollMenu *scrollMenu;

@property (nonatomic, strong) NSMutableArray<NSArray<PISPHomeMenuModel *> *> *dataSource;

@end

@implementation PISPHomeMenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.sectionNum = 1;
    
    [self setupYANScrollMenu];
    
    [self setupYANMenuItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupYANMenuItem) name:HomeViewWillAppear object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HomeViewWillAppear object:nil];
}

- (void)setupYANScrollMenu
{
    self.scrollMenu = [[YANScrollMenu alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CellHeight) delegate:self];
    self.scrollMenu.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scrollMenu];
}

- (void)setupYANMenuItem
{
    UIImage *iconImage = [UIImage imageNamed:@"home_entrance_spot"];
    MenuItem.iconSize = iconImage.size;
    MenuItem.space = 5.0;
    MenuItem.iconCornerRadius = iconImage.size.height / 2.0;
    MenuItem.textColor = UIColorFromRGB(0x333333);
    MenuItem.textFont = [UIFont systemFontOfSize:14.0];
    MenuItem.backgroundColor = [UIColor clearColor];
}

- (void)setModels:(NSArray<PISPHomeMenuModel *> *)models
{
    _models = models;
    
    if (models.count <= 0)
    {
        self.sectionNum = 1;
        
        self.lastSectionItemNum = 0;
    }
    else
    {
        self.sectionNum = models.count / MenuSectionMaxItemCount;
        if (models.count % MenuSectionMaxItemCount)
        {
            self.sectionNum += 1;
            self.lastSectionItemNum = models.count % MenuSectionMaxItemCount;
        }
        else
        {
            self.lastSectionItemNum = MenuSectionMaxItemCount;
        }
    }
    
//    NSMutableArray<NSArray<PISPHomeMenuModel *> *> *bigArray = [[NSMutableArray alloc] init];
//    NSMutableArray<PISPHomeMenuModel *> *smallArray = [[NSMutableArray alloc] init];
//    NSInteger lastItemSection = 0;
//    for (NSInteger i = 0; i < models.count; i++)
//    {
//        NSInteger section = i / MenuSectionMaxItemCount;
////        NSInteger item = i % MenuSectionMaxItemCount;
//        if (section == lastItemSection)
//        {
//            [smallArray addObject:models[i]];
//        }
//        else
//        {
//            [bigArray addObject:[NSArray arrayWithArray:smallArray]];
//            smallArray = [[NSMutableArray alloc] init];
//            [smallArray addObject:models[i]];
//            lastItemSection = section;
//        }
//    }
//    [bigArray addObject:[NSArray arrayWithArray:smallArray]];
//    self.dataSource = bigArray;
    self.dataSource = [NSMutableArray doubleDimensionalArrayWithOneDimensionalArray:models everySectionMaxItemCount:MenuSectionMaxItemCount];
    
    [self.scrollMenu reloadData];
    
//    CGFloat scrollMenuHeight = 0.0;
//    if (self.dataSource.count > 0)
//    {
//        NSArray *firstSectionItems = self.dataSource[0];
//        if (firstSectionItems.count > 0)
//        {
//            NSInteger maxItem = firstSectionItems.count - 1;
//            NSInteger maxRow = maxItem / MenuSectionMaxColumnCount;
//            NSInteger rowNum = maxRow + 1;
//            scrollMenuHeight = rowNum * MenuSectionItemHeight + HeightOfPageControl;
//        }
//    }
//    self.scrollMenu.mj_h = scrollMenuHeight;
    self.view_height.constant = self.scrollMenu.mj_h;
}

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
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectScrollMenuItemAtIndexPath:)])
    {
        [self.delegate didSelectScrollMenuItemAtIndexPath:indexPath];
    }
}

- (CGFloat)heightOfHeaderInScrollMenu:(YANScrollMenu *)menu
{
    return 0.0;
}

#pragma mark - YANScrollMenuDataSource
- (NSUInteger)scrollMenu:(YANScrollMenu *)menu numberOfItemsInSection:(NSInteger)section
{
//    if (section == self.sectionNum - 1)
//    {
//        return self.lastSectionItemNum;
//    }
//    else
//    {
//        return MenuSectionMaxItemCount;
//    }
    return section < self.dataSource.count ? self.dataSource[section].count : 0;
}

- (NSUInteger)numberOfSectionsInScrollMenu:(YANScrollMenu *)menu
{
//    return self.sectionNum;
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
