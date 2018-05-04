//
//  PISPReservationServiceHomeTableViewCell.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/8.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPReservationServiceHomeTableViewCell.h"

#import "PISPReservationServiceHomeModel.h"

@interface PISPReservationServiceHomeTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;

@end

@implementation PISPReservationServiceHomeTableViewCell

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    self.logoImageView.layer.cornerRadius = self.logoImageView.bounds.size.height / 2.0;
    self.logoImageView.layer.masksToBounds = YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTaped:)]];
}

- (void)setModel:(PISPReservationServiceHomeModel *)model
{
    _model = model;
    
    self.bgImageView.image = model.backgroundImage;
    self.logoImageView.image = model.logoImage;
    self.titleLabel.text = [NSString ifIsEmptyWithStr:model.title];
    self.introLabel.text = [NSString ifIsEmptyWithStr:model.intro];
}

- (void)viewTaped:(UITapGestureRecognizer *)sender
{
    if (self.viewTaped)
    {
        self.viewTaped();
    }
}


@end
