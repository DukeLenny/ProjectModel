//
//  PISPHomeMoreFooterView.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/2.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPHomeMoreFooterView.h"

@interface PISPHomeMoreFooterView()

@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;

@end

@implementation PISPHomeMoreFooterView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    self.moreButton.layer.cornerRadius = self.moreButton.bounds.size.height / 2.0;
    self.moreButton.layer.masksToBounds = YES;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor clearColor];
        
        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PISPHomeMoreFooterView class]) owner:self options:nil];
        [self.contentView addSubview:self.view];
        [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        self.moreButton.layer.borderColor = UIColorFromRGB(0xe2e2e2).CGColor;
        self.moreButton.layer.borderWidth = 0.5;
        [self.moreButton setContentEdgeInsetsWithLayoutType:UIButtonContentLayoutTypeLeftTitleRightImage space:8.0];
    }
    return self;
}

- (IBAction)moreButtonClicked:(UIButton *)sender
{
    if (self.moreButtonClicked)
    {
        self.moreButtonClicked(sender);
    }
}

@end
