//
//  PISPHomeAnotherMenuTableViewCell.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/2.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPHomeAnotherMenuTableViewCell.h"

@interface PISPHomeAnotherMenuTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;

@end

@implementation PISPHomeAnotherMenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self addTapGestureRecognizerWithView:self.view1];
    [self addTapGestureRecognizerWithView:self.view2];
    [self addTapGestureRecognizerWithView:self.view3];
    [self addTapGestureRecognizerWithView:self.view4];
}

- (void)addTapGestureRecognizerWithView:(UIView *)view
{
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTaped:)]];
}

- (IBAction)viewTaped:(UITapGestureRecognizer *)sender
{
    if (self.viewTaped)
    {
        self.viewTaped(sender.view);
    }
}


@end
