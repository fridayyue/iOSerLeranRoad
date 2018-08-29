//
//  DSPADCreatViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/27.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DSPADCreatViewController.h"
#import "DSPMACViewController.h"
#import "DSPManger.h"
#import "SinglePickerAlertView.h"
#import "DSPMACADViewController.h"

@interface DSPADCreatViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sexViewTop;
@property (weak, nonatomic) IBOutlet UIButton *sexAllBtn;
@property (weak, nonatomic) IBOutlet UIButton *nvBtn;
@property (weak, nonatomic) IBOutlet UIButton *nanBtn;
@property (weak, nonatomic) IBOutlet UILabel *nianlingLB;
@property (weak, nonatomic) IBOutlet UITextField *quyuTF;
@property (weak, nonatomic) IBOutlet UITextField *fanweiTF;

@end

@implementation DSPADCreatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)initView{
    self.title = @"创建广告";
    switch (_viewType) {
        case shangquanType:
        {
            _sexViewTop.constant = 10;
        }
            break;
        case macToufangType:
        {
            _sexViewTop.constant = 70;
        }
            break;
            
        default:
        {
            _sexViewTop.constant = 10;
        }
            break;
    }
}

#pragma mark - Action
- (IBAction)actionForMAC:(id)sender {
    DSPMACViewController *dspMacVC = [[DSPMACViewController alloc] init];
    [self.navigationController pushViewController:dspMacVC animated:YES];
}
- (IBAction)actionForSex:(UIButton *)sender {
    _sexAllBtn.selected = NO;
    _nvBtn.selected = NO;
    _nanBtn.selected = NO;
    sender.selected = YES;
    [DSPManger shareManger].sex = _sexAllBtn.selected?@"全部":_nvBtn.selected?@"女":@"男";
}
- (IBAction)actionForAge:(UIButton *)sender {
    SinglePickerAlertView *aimAlertView = [[SinglePickerAlertView alloc] initWithType:ageType defaultString:_nianlingLB.text];
    aimAlertView.block = ^(NSString *data) {
       _nianlingLB.text = data;
        [DSPManger shareManger].age = data;
    };
    [self.navigationController.view addSubview:aimAlertView];
    [aimAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.navigationController.view);
    }];
}
- (IBAction)actionForNect:(id)sender {
    if ([Judge judgeStringIsEmpty:_quyuTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"请设置投放区域！"];
        return;
    }
    if ([Judge judgeStringIsEmpty:_quyuTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"请设置商圈范围！"];
        return;
    }
    [DSPManger shareManger].put_area = _quyuTF.text;
    [DSPManger shareManger].distance = _fanweiTF.text;
    DSPMACADViewController *adVC = [[DSPMACADViewController alloc] init];
    [self.navigationController pushViewController:adVC animated:YES];
}
@end
