//
//  QYJQRefreshAutoFooter.m
//  QuanYuJingQu
//
//  Created by LiDinggui on 2017/1/16.
//  Copyright © 2017年 DAQSoft. All rights reserved.
//

#import "JKRefreshAutoFooter.h"

#define RefreshFooterHeight (44.0)
#define BackgroundImageName @"loading_bg"
#define LogoImageName @"loading_logo"
#define StateLabelFontSize (12.0)
#define StateLabelTextColor TabBarTintColor

#define Space (8.0)

@interface JKRefreshAutoFooter ()

@property (nonatomic, weak) UIImageView *backgroundImageView;
@property (nonatomic, weak) UIImageView *logoImageView;
@property (nonatomic, weak) UILabel *stateLabel;

@end

@implementation JKRefreshAutoFooter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)prepare
{
    [super prepare];
    
    self.mj_h = RefreshFooterHeight;
    
    UIImageView *backgroundImageView = [[UIImageView alloc] init];
//    backgroundImageView.image = [UIImage imageNamed:BackgroundImageName];
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    backgroundImageView.clipsToBounds = YES;
    [self addSubview:backgroundImageView];
    self.backgroundImageView = backgroundImageView;
    
    UIImageView *logoImageView = [[UIImageView alloc] init];
    logoImageView.image = [UIImage imageNamed:LogoImageName];
    logoImageView.contentMode = UIViewContentModeScaleAspectFill;
    logoImageView.clipsToBounds = YES;
    [self addSubview:logoImageView];
    self.logoImageView = logoImageView;
    
    UILabel *stateLabel = [[UILabel alloc] init];
    stateLabel.font = [UIFont systemFontOfSize:StateLabelFontSize];
    stateLabel.textColor = StateLabelTextColor;
    stateLabel.textAlignment = NSTextAlignmentLeft;
    stateLabel.text = FooterRefreshStateIdleTitle;
    [self addSubview:stateLabel];
    self.stateLabel = stateLabel;
    
    self.stateLabel.userInteractionEnabled = YES;
    [self.stateLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateLabelClick)]];
}

- (void)stateLabelClick
{
    if (self.state == MJRefreshStateIdle) {
        [self beginRefreshing];
    }
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    self.backgroundImageView.frame = self.bounds;
    
    UIImage *logoImage = [UIImage imageNamed:LogoImageName];
    
    self.logoImageView.frame = CGRectMake((self.mj_w - logoImage.size.width - Space - self.stateLabel.mj_textWith) / 2.0, (self.mj_h - logoImage.size.height) / 2.0, logoImage.size.width, logoImage.size.height);
    
    self.stateLabel.frame = CGRectMake(self.logoImageView.mj_x + self.logoImageView.mj_w + Space, 0, self.stateLabel.mj_textWith, self.mj_h);
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    switch (state) {
        case MJRefreshStateIdle:
        {
            self.stateLabel.text = FooterRefreshStateIdleTitle;
        }
            break;
        case MJRefreshStateRefreshing:
        {
            self.stateLabel.text = FooterRefreshStateRefreshingTitle;
        }
            break;
        case MJRefreshStateNoMoreData:
        {
            self.stateLabel.text = FooterRefreshStateNoMoreDataTitle;
        }
            break;
            
        default:
        {
            self.stateLabel.text = @"";
        }
            break;
    }
}

@end
