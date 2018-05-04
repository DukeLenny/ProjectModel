//
//  PISPHomeHeadTableViewCell.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/2.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPHomeHeadTableViewCell.h"

#import <SDCycleScrollView/SDCycleScrollView.h>

#import "PISPWeatherModel.h"
#import "PISPPeopleCountModel.h"

@interface PISPHomeHeadTableViewCell()<SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UIView *peopleCountView;
@property (weak, nonatomic) IBOutlet UILabel *peopleCountLabel;

@end

@implementation PISPHomeHeadTableViewCell

- (void)setImageURLStringsGroup:(NSArray *)imageURLStringsGroup
{
    _imageURLStringsGroup = imageURLStringsGroup;
    
    self.cycleScrollView.imageURLStringsGroup = imageURLStringsGroup;
}

- (void)setTitlesGroup:(NSArray *)titlesGroup
{
    _titlesGroup = titlesGroup;
    
    self.cycleScrollView.titlesGroup = titlesGroup;
}

- (void)setWeatherModel:(PISPWeatherModel *)weatherModel
{
    _weatherModel = weatherModel;
    
    NSString *temperature = [NSString stringWithFormat:@"%.1lf℃~%.1lf℃\n",weatherModel.min,weatherModel.max];
    NSString *status = [NSString stringWithFormat:@"今日  %@",[NSString ifIsEmptyWithStr:[LDGUtility currentTimeIsDay] ? weatherModel.txt_d : weatherModel.txt_n]];
    self.weatherLabel.text = [NSString stringWithFormat:@"%@%@",temperature,status];
    [self.weatherLabel setAttributedTextWithRange:NSMakeRange(0, temperature.length) font:[UIFont boldSystemFontOfSize:28.0] textColor:nil];
}

- (void)setPeopleCountModel:(PISPPeopleCountModel *)peopleCountModel
{
    _peopleCountModel = peopleCountModel;
    
    NSString *todayPeopleCount = [NSString stringWithFormat:@"%ld",peopleCountModel.realTimeCount];
    NSString *mostPeopleCount = [NSString stringWithFormat:@"%ld",peopleCountModel.maxCapacity];
    self.peopleCountLabel.text = [NSString stringWithFormat:@"今日接待%@人  最多接待%@人",todayPeopleCount,mostPeopleCount];
    [self.peopleCountLabel setAttributedTextWithRange:NSMakeRange(4, todayPeopleCount.length) font:[UIFont boldSystemFontOfSize:20.0] textColor:[UIColor blackColor]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setupCycleScrollView];
}

- (void)setupCycleScrollView
{
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.bannerView.bounds delegate:self placeholderImage:[UIImage imageNamed:@"home_head_banner_defaultpic"]];
    
//    self.cycleScrollView.delegate = self;
    self.cycleScrollView.clipsToBounds = YES;
    self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
//    self.cycleScrollView.placeholderImage = [UIImage imageNamed:@"home_head_banner_defaultpic"];
    self.cycleScrollView.showPageControl = YES;
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//    self.cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"home_circle_00_hover"];
//    self.cycleScrollView.pageDotImage = [UIImage imageNamed:@"home_circle_00"];
    self.cycleScrollView.currentPageDotColor = [UIColor whiteColor];
    self.cycleScrollView.pageDotColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    self.cycleScrollView.titleLabelTextColor = [UIColor whiteColor];
//    self.cycleScrollView.titleLabelTextFont = [UIFont systemFontOfSize:10.0];
    self.cycleScrollView.titleLabelBackgroundColor = [UIColor clearColor];
//    self.cycleScrollView.titleLabelHeight = 12.0;
    self.cycleScrollView.titleLabelTextAlignment = NSTextAlignmentLeft;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewWillAppear) name:HomeViewWillAppear object:nil];
    
    [self.bannerView addSubview:self.cycleScrollView];
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bannerView);
    }];
}

- (void)viewWillAppear
{
    [self.cycleScrollView adjustWhenControllerViewWillAppera];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HomeViewWillAppear object:nil];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectCycleScrollViewItemAtIndex:)])
    {
        [self.delegate didSelectCycleScrollViewItemAtIndex:index];
    }
}

@end
