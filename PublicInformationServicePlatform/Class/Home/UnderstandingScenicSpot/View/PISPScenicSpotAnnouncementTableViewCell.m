//
//  PISPScenicSpotAnnouncementTableViewCell.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/9.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPScenicSpotAnnouncementTableViewCell.h"

#import "PISPScenicSpotAnnouncementModel.h"

@interface PISPScenicSpotAnnouncementTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabel_leading;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation PISPScenicSpotAnnouncementTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView)]];
}

- (void)setModel:(PISPScenicSpotAnnouncementModel *)model
{
    _model = model;
    
    self.photoImageView.hidden = [NSString isEmptyWithStr:model.cover];
    [self.photoImageView setImageWithURLString:model.cover placeholderImageName:@"home_nearby_banner_defaultpic"];
    self.titleLabel_leading.constant = self.photoImageView.hidden ? 10.0 : 128.0;
    self.titleLabel.text = [NSString ifIsEmptyWithStr:model.title];
    self.contentLabel.text = [NSString ifIsEmptyWithStr:model.summary];
    self.timeLabel.text = [NSString stringWithFormat:@"%@ · %ld浏览",[NSString ifIsEmptyWithStr:model.createDate],model.viewCount];
}

- (void)tapView
{
    if (self.viewTaped)
    {
        self.viewTaped();
    }
}

@end
