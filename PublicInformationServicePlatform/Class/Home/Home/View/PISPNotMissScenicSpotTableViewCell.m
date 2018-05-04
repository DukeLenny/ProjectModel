//
//  PISPNotMissScenicSpotTableViewCell.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/10.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPNotMissScenicSpotTableViewCell.h"

#import "PISPNotMissScenicSpotModel.h"

@interface PISPNotMissScenicSpotTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UIView *buttonsView;
@property (weak, nonatomic) IBOutlet UIButton *audioToursButton;
@property (weak, nonatomic) IBOutlet UIButton *panoramicButton;
@property (weak, nonatomic) IBOutlet UIButton *liveShowButton;
@property (weak, nonatomic) IBOutlet UIButton *arButton;

@end

@implementation PISPNotMissScenicSpotTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.view.layer.borderWidth = 1.0;
    self.view.layer.borderColor = UIColorFromRGB(0xEBEBEB).CGColor;
    
    [self.audioToursButton setContentEdgeInsetsWithLayoutType:UIButtonContentLayoutTypeTopImageBottomTitle space:3.0];
    [self.panoramicButton setContentEdgeInsetsWithLayoutType:UIButtonContentLayoutTypeTopImageBottomTitle space:3.0];
    [self.liveShowButton setContentEdgeInsetsWithLayoutType:UIButtonContentLayoutTypeTopImageBottomTitle space:3.0];
    [self.arButton setContentEdgeInsetsWithLayoutType:UIButtonContentLayoutTypeTopImageBottomTitle space:3.0];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView)]];
}

- (void)setModel:(PISPNotMissScenicSpotModel *)model
{
    _model = model;
    
    [self.photoImageView setImageWithURLString:model.img placeholderImageName:nil];
    self.nameLabel.text = [NSString ifIsEmptyWithStr:model.name];
    self.introLabel.text = [NSString ifIsEmptyWithStr:model.introduce];
}

- (IBAction)buttonClicked:(UIButton *)sender
{
    if (self.buttonClicked)
    {
        self.buttonClicked(sender);
    }
}

- (void)tapView
{
    if (self.viewTaped)
    {
        self.viewTaped();
    }
}

@end
