//
//  PISPAKeyAlarmReportImageCollectionViewCell.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/16.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPAKeyAlarmReportImageCollectionViewCell.h"

#import <Photos/Photos.h>
#import "LDGAssetTool.h"

@interface PISPAKeyAlarmReportImageCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIButton *imageButton;

@end

@implementation PISPAKeyAlarmReportImageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.imageButton.layer.borderColor = UIColorFromRGB(0xD4D4D4).CGColor;
    self.imageButton.layer.borderWidth = 0.5;
    
    self.asset = nil;
}

- (void)setAsset:(PHAsset *)asset
{
    _asset = asset;
    
    if (asset)
    {
        self.imageButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
        self.imageButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
        
        [LDGAssetTool requestImageForAsset:asset sync:YES targetSize:CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT) completion:^(UIImage *image) {
            [self.imageButton setImage:image forState:UIControlStateNormal];
        }];
        [self.imageButton setTitle:nil forState:UIControlStateNormal];
        self.imageButton.imageEdgeInsets = UIEdgeInsetsZero;
        self.imageButton.titleEdgeInsets = UIEdgeInsetsZero;
    }
    else
    {
        self.imageButton.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.imageButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        [self.imageButton setImage:[UIImage imageNamed:@"report_fill_icon_pic_normal"] forState:UIControlStateNormal];
        [self.imageButton setTitle:@"图片" forState:UIControlStateNormal];
        [self.imageButton setContentEdgeInsetsWithLayoutType:UIButtonContentLayoutTypeTopImageBottomTitle space:ButtonImageTitleSpacing];
    }
}

- (IBAction)imageButtonClicked:(UIButton *)sender
{
    if (self.imageButtonClicked)
    {
        self.imageButtonClicked(sender);
    }
}

@end
