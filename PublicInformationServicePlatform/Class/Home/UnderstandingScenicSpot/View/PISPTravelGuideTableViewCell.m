//
//  PISPTravelGuideTableViewCell.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/9.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPTravelGuideTableViewCell.h"

#import "PISPTravelGuideModel.h"

@interface PISPTravelGuideTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIView *dateView;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *recommendLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabel_leading;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation PISPTravelGuideTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.recommendLabel.layer.borderColor = UIColorFromRGB(0x12A2FE).CGColor;
    self.recommendLabel.layer.borderWidth = 0.5;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView)]];
}

- (void)setModel:(PISPTravelGuideModel *)model
{
    _model = model;
    
    [self.photoImageView setImageWithURLString:model.cover placeholderImageName:@"home_nearby_banner_defaultpic.png"];
    
    NSDate *date = [NSDate dateFromString:[NSString ifIsEmptyWithStr:model.updateTime] withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.dayLabel.text = [NSString ifIsEmptyWithStr:[NSString stringFromDate:date withDateFormat:@"dd"]];
    self.yearMonthLabel.text = [NSString stringWithFormat:@"%@\n%@",[NSString ifIsEmptyWithStr:[NSString stringFromDate:date withDateFormat:@"yyyy"]],[NSString ifIsEmptyWithStr:[NSString stringFromDate:date withDateFormat:@"MM"]]];
    
    self.recommendLabel.hidden = model.recommended == 0;
    
    self.titleLabel_leading.constant = self.recommendLabel.hidden ? 0.0 : 38.0;
    
    self.titleLabel.text = [NSString ifIsEmptyWithStr:model.title];
    
    self.contentLabel.text = [NSString ifIsEmptyWithStr:model.digest];
    
    [self.likeButton setTitle:[NSString stringWithFormat:@"%ld",model.givePoint] forState:UIControlStateNormal];
    [self.collectionButton setTitle:[NSString stringWithFormat:@"%ld",model.collection] forState:UIControlStateNormal];
    [self.commentButton setTitle:[NSString stringWithFormat:@"%ld",model.comment] forState:UIControlStateNormal];
}

- (void)tapView
{
    if (self.viewTaped)
    {
        self.viewTaped();
    }
}

@end
