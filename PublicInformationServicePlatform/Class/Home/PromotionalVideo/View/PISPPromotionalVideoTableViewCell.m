//
//  PISPPromotionalVideoTableViewCell.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/10.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPPromotionalVideoTableViewCell.h"

#import "PISPPromotionalVideoModel.h"

@interface PISPPromotionalVideoTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIButton *photoButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation PISPPromotionalVideoTableViewCell

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    self.playButton.layer.cornerRadius = self.playButton.bounds.size.height / 2.0;
    self.playButton.layer.masksToBounds = YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.photoButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.photoButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    self.photoButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    
    self.playButton.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.7].CGColor;
    self.playButton.layer.borderWidth = 1.0;
}

- (void)setModel:(PISPPromotionalVideoModel *)model
{
    _model = model;
    
    [self.photoButton setImageWithURLString:model.coverpicture placeholderImageName:@"home_nearby_banner_defaultpic"];
    
    self.timeLabel.text = [NSString ifIsEmptyWithStr:model.mins];
    
    self.titleLabel.text = [NSString ifIsEmptyWithStr:model.title];
}

- (IBAction)playVideoAction:(UIButton *)sender
{
    if (self.playVideoAction)
    {
        self.playVideoAction(sender);
    }
}


@end
