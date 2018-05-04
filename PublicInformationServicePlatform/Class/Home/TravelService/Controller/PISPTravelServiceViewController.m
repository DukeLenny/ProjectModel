//
//  PISPTravelServiceViewController.m
//  PublicInformationServicePlatform
//
//  Created by 李定贵 on 2018/4/11.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPTravelServiceViewController.h"

#import "UIViewController+Cloudox.h"

@interface PISPTravelServiceViewController ()

@property (weak, nonatomic) IBOutlet UIButton *realTimeInformationButton;
@property (weak, nonatomic) IBOutlet UIButton *busQueryButton;
@property (weak, nonatomic) IBOutlet UIButton *trainTicketQueryButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation PISPTravelServiceViewController

#pragma mark - Event
- (IBAction)busQueryButtonClicked:(UIButton *)sender
{
    
}

- (IBAction)trainTicketQueryButtonClicked:(UIButton *)sender
{
    
}

- (IBAction)realTimeInformationButtonClicked:(UIButton *)sender
{
    
}

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AutomaticallyAdjustsScrollViewInsets_NO(self.scrollView, self);
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.realTimeInformationButton.layer.cornerRadius = self.realTimeInformationButton.bounds.size.height / 2.0;
    self.realTimeInformationButton.layer.masksToBounds = YES;
    self.busQueryButton.layer.cornerRadius = self.busQueryButton.bounds.size.height / 2.0;
    self.busQueryButton.layer.masksToBounds = YES;
    self.trainTicketQueryButton.layer.cornerRadius = self.trainTicketQueryButton.bounds.size.height / 2.0;
    self.trainTicketQueryButton.layer.masksToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navBarBgAlpha = @"0.0";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
