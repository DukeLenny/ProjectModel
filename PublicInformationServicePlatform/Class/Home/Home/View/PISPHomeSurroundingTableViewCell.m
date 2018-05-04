//
//  PISPHomeSurroundingTableViewCell.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/2.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPHomeSurroundingTableViewCell.h"

@interface PISPHomeSurroundingTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *scenicButton;
@property (weak, nonatomic) IBOutlet UIButton *hotelButton;
@property (weak, nonatomic) IBOutlet UIButton *foodButton;
@property (weak, nonatomic) IBOutlet UIButton *shopButton;
@property (weak, nonatomic) IBOutlet UIButton *funButton;

@end

@implementation PISPHomeSurroundingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.bottomView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.bottomView.layer.shadowRadius = 1.0;
    self.bottomView.layer.shadowOpacity = 0.5;
    self.bottomView.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    
    [self.scenicButton setImage:[UIImage imageNamed:@"home_nearby_spot_highlighted"] forState:UIControlStateHighlighted];
    [self.scenicButton setTitleColor:UIColorFromRGB(0x12a2fe) forState:UIControlStateHighlighted];
    [self.hotelButton setImage:[UIImage imageNamed:@"home_nearby_hotel_highlighted"] forState:UIControlStateHighlighted];
    [self.hotelButton setTitleColor:UIColorFromRGB(0x12a2fe) forState:UIControlStateHighlighted];
    [self.foodButton setImage:[UIImage imageNamed:@"home_nearby_food_highlighted"] forState:UIControlStateHighlighted];
    [self.foodButton setTitleColor:UIColorFromRGB(0x12a2fe) forState:UIControlStateHighlighted];
    [self.shopButton setImage:[UIImage imageNamed:@"home_nearby_shopping_highlighted"] forState:UIControlStateHighlighted];
    [self.shopButton setTitleColor:UIColorFromRGB(0x12a2fe) forState:UIControlStateHighlighted];
    [self.funButton setImage:[UIImage imageNamed:@"home_nearby_fun_highlighted"] forState:UIControlStateHighlighted];
    [self.funButton setTitleColor:UIColorFromRGB(0x12a2fe) forState:UIControlStateHighlighted];
    
    [self.scenicButton setContentEdgeInsetsWithLayoutType:UIButtonContentLayoutTypeTopImageBottomTitle space:8.0];
    [self.hotelButton setContentEdgeInsetsWithLayoutType:UIButtonContentLayoutTypeTopImageBottomTitle space:8.0];
    [self.foodButton setContentEdgeInsetsWithLayoutType:UIButtonContentLayoutTypeTopImageBottomTitle space:8.0];
    [self.shopButton setContentEdgeInsetsWithLayoutType:UIButtonContentLayoutTypeTopImageBottomTitle space:8.0];
    [self.funButton setContentEdgeInsetsWithLayoutType:UIButtonContentLayoutTypeTopImageBottomTitle space:8.0];
}

- (IBAction)buttonClicked:(UIButton *)sender
{
    if (self.buttonClicked)
    {
        self.buttonClicked(sender);
    }
}


@end
