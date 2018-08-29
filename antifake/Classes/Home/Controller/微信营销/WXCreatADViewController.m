//
//  WXCreatADViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/15.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "WXCreatADViewController.h"
#import "BuyExplainViewController.h"
#import "SinglePickerAlertView.h"
#import <Masonry.h>
#import "WXYingXiaoManger.h"
#import "WXAdPutSettingViewController.h"

@interface WXCreatADViewController ()
@property (weak, nonatomic) IBOutlet UITextField *adNameTF;
@property (weak, nonatomic) IBOutlet UILabel *adAimLabel;
@property (weak, nonatomic) IBOutlet UILabel *adTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *adbuyType;

@end

@implementation WXCreatADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - MakeView
-(void)initView{
    self.title = @"创建广告";
    [self makeRightNavBtnImage:[UIImage imageNamed:@"WX_Question.png"]];
    [_adNameTF becomeFirstResponder];
    _adNameTF.text = [WXYingXiaoManger shareManger].advName;
//    _adAimLabel.text = [Judge judgeStringIsEmpty:[WXYingXiaoManger shareManger].wxAdAim]?@"品牌活动":[WXYingXiaoManger shareManger].wxAdAim;
//    _adTypeLabel.text = [Judge judgeStringIsEmpty:[WXYingXiaoManger shareManger].wxAdType]?@"图文广告":[WXYingXiaoManger shareManger].wxAdType;
//    _adbuyType.text = [Judge judgeStringIsEmpty:[WXYingXiaoManger shareManger].wxAdBuyType]?@"竞价购买":[WXYingXiaoManger shareManger].wxAdBuyType;
}
#pragma mark - Action
-(void)actionForRightBtn:(id)sender{
    BuyExplainViewController *explantVC = [[BuyExplainViewController alloc] init];
    [self.navigationController pushViewController:explantVC animated:YES];
}
- (IBAction)actionForAim:(id)sender {
    [self shoujianpan];
    SinglePickerAlertView *aimAlertView = [[SinglePickerAlertView alloc] initWithType:adAimType defaultString:_adAimLabel.text];
    aimAlertView.block = ^(NSString *data) {
        self->_adAimLabel.text = data;
    };
    [self.navigationController.view addSubview:aimAlertView];
    [aimAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.navigationController.view);
    }];
}
- (IBAction)actionForType:(id)sender {
    [self shoujianpan];
    SinglePickerAlertView *aimAlertView = [[SinglePickerAlertView alloc] initWithType:adTypeType defaultString:_adTypeLabel.text];
    aimAlertView.block = ^(NSString *data) {
        self->_adTypeLabel.text = data;
    };
    [self.navigationController.view addSubview:aimAlertView];
    [aimAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.navigationController.view);
    }];
}
- (IBAction)actionForBuyType:(UIButton *)sender {
    [self shoujianpan];
    SinglePickerAlertView *aimAlertView = [[SinglePickerAlertView alloc] initWithType:adBuyType defaultString:_adbuyType.text];
    aimAlertView.block = ^(NSString *data) {
        self->_adbuyType.text = data;
    };
    [self.navigationController.view addSubview:aimAlertView];
    [aimAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.navigationController.view);
    }];
}
- (IBAction)actionForNextStep:(id)sender {
    if ([self check]) {
        WXAdPutSettingViewController *adSettingVC = [[WXAdPutSettingViewController alloc] init];
        [self.navigationController pushViewController:adSettingVC animated:YES];
    }
}
#pragma mark - Method
-(void)shoujianpan{
    [_adNameTF endEditing:YES];
}
-(BOOL)check{
    if ([Judge judgeStringIsEmpty:_adNameTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入广告名称"];
        return NO;
    }
    
    [WXYingXiaoManger shareManger].advName = _adNameTF.text;
    [WXYingXiaoManger shareManger].adGoal = _adAimLabel.text;
    [WXYingXiaoManger shareManger].adType = _adTypeLabel.text;
    [WXYingXiaoManger shareManger].purchaseType = _adbuyType.text;
    return YES;
}
@end
