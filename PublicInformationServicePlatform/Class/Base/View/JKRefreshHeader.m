//
//  QYRefreshHeader.m
//  FourBigArea
//
//  Created by LiDinggui on 2017/1/13.
//  Copyright © 2017年 LiDinggui. All rights reserved.
//

#import "JKRefreshHeader.h"

#define RefreshHeaderHeight (44.0)
#define BackgroundImageName @"loading_bg"
#define LogoImageName @"loading_logo"
#define StateLabelFontSize (12.0)
#define StateLabelTextColor TabBarTintColor

#define Space (8.0)

@interface JKRefreshHeader ()

@property (nonatomic, weak) UIImageView *backgroundImageView;
@property (nonatomic, weak) UIImageView *logoImageView;
@property (nonatomic, weak) UILabel *stateLabel;

@end

@implementation JKRefreshHeader

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
    
    self.mj_h = RefreshHeaderHeight;
    
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
    stateLabel.text = HeaderRefreshStateIdleTitle;
    [self addSubview:stateLabel];
    self.stateLabel = stateLabel;
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
            self.stateLabel.text = HeaderRefreshStateIdleTitle;
        }
            break;
        case MJRefreshStatePulling:
        {
            self.stateLabel.text = HeaderRefreshStatePullingTitle;
        }
            break;
        case MJRefreshStateRefreshing:
        {
            self.stateLabel.text = HeaderRefreshStateRefreshingTitle;
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
