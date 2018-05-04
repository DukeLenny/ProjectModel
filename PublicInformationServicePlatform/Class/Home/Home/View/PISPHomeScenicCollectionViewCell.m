//
//  PISPHomeScenicCollectionViewCell.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/5.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPHomeScenicCollectionViewCell.h"

#import "PISPNotMissScenicSpotModel.h"

@interface PISPHomeScenicCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;

@end

@implementation PISPHomeScenicCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(PISPNotMissScenicSpotModel *)model
{
    _model = model;
    
    [self.photoImageView setImageWithURLString:model.img placeholderImageName:nil];
    self.nameLabel.text = [NSString ifIsEmptyWithStr:model.name];
    self.introLabel.text = [NSString ifIsEmptyWithStr:model.introduce];
}

@end
