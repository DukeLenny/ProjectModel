//
//  PISPKnowYouCanSeeTableViewCell.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/11.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPKnowYouCanSeeTableViewCell.h"

#import "PISPKnowYouCanSeeModel.h"

@interface PISPKnowYouCanSeeTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;

@end

@implementation PISPKnowYouCanSeeTableViewCell

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    self.logoImageView.layer.cornerRadius = self.logoImageView.bounds.size.height / 2.0;
    self.logoImageView.layer.masksToBounds = YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.view.layer.borderColor = UIColorFromRGB(0xEBEBEB).CGColor;
    self.view.layer.borderWidth = 1.0;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView)]];
}

- (void)setModel:(PISPKnowYouCanSeeModel *)model
{
    _model = model;
    
    self.logoImageView.image = [UIImage imageNamed:model.imageName];
    
    self.titleLabel.text = [NSString ifIsEmptyWithStr:model.title];
    
    self.introLabel.text = @"看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点看点";
}

- (void)tapView
{
    if (self.viewTaped)
    {
        self.viewTaped();
    }
}

@end
