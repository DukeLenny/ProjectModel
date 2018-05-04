//
//  PISPAKeyAlarmViewController.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/12.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPAKeyAlarmViewController.h"

#import "UIViewController+Cloudox.h"
#import "PISPAKeyAlarmReportTableViewController.h"

@interface PISPAKeyAlarmViewController ()

@property (weak, nonatomic) IBOutlet UIButton *alarmButton;
@property (weak, nonatomic) IBOutlet UIButton *accidentReportButton;
@property (weak, nonatomic) IBOutlet UIButton *dangerousSituationButton;
@property (weak, nonatomic) IBOutlet UIButton *physicalDamageButton;

@end

@implementation PISPAKeyAlarmViewController

#pragma mark - Event
- (IBAction)alarmButtonClicked:(UIButton *)sender
{
    NSString *phoneNumber = @"13778069524";
    if (![NSString isEmptyWithStr:phoneNumber])
    {
        [self presentAlertControllerWithTitle:@"一键报警" message:[NSString stringWithFormat:@"是否拨打紧急电话: %@?",phoneNumber] defaultTitle:@"拨打" defaultHandler:^(UIAlertAction *action) {
            [APPLICATION openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]]];
        }];
    }
}

#pragma mark - SetupUI
- (void)setupUI
{
    [self.alarmButton setImage:[UIImage imageNamed:@"report_button_highlighted"] forState:UIControlStateHighlighted];
    self.accidentReportButton.titleLabel.numberOfLines = 2;
    self.dangerousSituationButton.titleLabel.numberOfLines = 2;
    self.physicalDamageButton.titleLabel.numberOfLines = 2;
    [self.accidentReportButton setTitle:@"事故\n上报" forState:UIControlStateNormal];
    [self.dangerousSituationButton setTitle:@"危险\n情况" forState:UIControlStateNormal];
    [self.physicalDamageButton setTitle:@"实物\n损坏" forState:UIControlStateNormal];
}

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.accidentReportButton.layer.cornerRadius = self.accidentReportButton.bounds.size.height / 2.0;
    self.accidentReportButton.layer.masksToBounds = YES;
    self.dangerousSituationButton.layer.cornerRadius = self.dangerousSituationButton.bounds.size.height / 2.0;
    self.dangerousSituationButton.layer.masksToBounds = YES;
    self.physicalDamageButton.layer.cornerRadius = self.physicalDamageButton.bounds.size.height / 2.0;
    self.physicalDamageButton.layer.masksToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navBarBgAlpha = @"0.0";
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    PISPAKeyAlarmReportTableViewController *vc = (PISPAKeyAlarmReportTableViewController *)(segue.destinationViewController);
    if ([segue.identifier isEqualToString:@"AKeyAlarm2AccidentReport"])
    {
        vc.navigationItem.title = @"事故上报";
    }
    else if ([segue.identifier isEqualToString:@"AKeyAlarm2DangerousSituation"])
    {
        vc.navigationItem.title = @"危险情况";
    }
    else if ([segue.identifier isEqualToString:@"AKeyAlarm2PhysicalDamage"])
    {
        vc.navigationItem.title = @"实物损坏";
    }
    
}

@end
