//
//  PISPHomeTitleHeaderView.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/2.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPHomeTitleHeaderView.h"

@interface PISPHomeTitleHeaderView()

@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkAllButton;

@end

@implementation PISPHomeTitleHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor clearColor];
        
        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PISPHomeTitleHeaderView class]) owner:self options:nil];
        [self.contentView addSubview:self.view];
        [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        [self.checkAllButton setContentEdgeInsetsWithLayoutType:UIButtonContentLayoutTypeLeftTitleRightImage space:8.0];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = [NSString ifIsEmptyWithStr:title];
}

- (void)checkAllButtonClicked:(UIButton *)sender
{
    if (self.checkAllButtonClicked)
    {
        self.checkAllButtonClicked(sender);
    }
}

@end
