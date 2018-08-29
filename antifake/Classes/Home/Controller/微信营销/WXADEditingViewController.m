//
//  WXADEditingViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/18.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "WXADEditingViewController.h"
#import "SinglePickerAlertView.h"
#import <Masonry.h>
#import "WXUploadViewController.h"
#import "WXMakeDetailViewController.h"
#import "WXYingXiaoManger.h"

@interface WXADEditingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *adShowTypeLabel;
@property (weak, nonatomic) IBOutlet UIButton *wenan_liaojiegengduoBtn;
@property (weak, nonatomic) IBOutlet UIButton *yuyuehuodongBtn;
@property (weak, nonatomic) IBOutlet UIButton *lingquyouhuiquanBtn;

@end

@implementation WXADEditingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
-(void)initView{
    self.title = @"广告编辑";
    _adShowTypeLabel.text = [Judge judgeStringIsEmpty:[WXYingXiaoManger shareManger].wxADShowType]?@"常规体验":[WXYingXiaoManger shareManger].wxADShowType;
    if ([[WXYingXiaoManger shareManger].wxADWenAn isEqualToString:@"了解更多"]) {
        _wenan_liaojiegengduoBtn.selected = YES;
    }else if ([[WXYingXiaoManger shareManger].wxADWenAn isEqualToString:@"预约活动"]){
        _yuyuehuodongBtn.selected = YES;
    }else if ([[WXYingXiaoManger shareManger].wxADWenAn isEqualToString:@"领取优惠"]){
        _lingquyouhuiquanBtn.selected = YES;
    }
}
#pragma mark - Action
- (IBAction)actionForADType:(id)sender {
    SinglePickerAlertView *aimAlertView = [[SinglePickerAlertView alloc] initWithType:adShowType defaultString:_adShowTypeLabel.text];
    aimAlertView.block = ^(NSString *data) {
        self->_adShowTypeLabel.text = data;
        [WXYingXiaoManger shareManger].wxADShowType = data;
    };
    [self.navigationController.view addSubview:aimAlertView];
    [aimAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.navigationController.view);
    }];
}
- (IBAction)actionForWenAn:(UIButton *)sender {
    _wenan_liaojiegengduoBtn.selected = NO;
    _yuyuehuodongBtn.selected = NO;
    _lingquyouhuiquanBtn.selected = NO;
    sender.selected = YES;
    [WXYingXiaoManger shareManger].wxADWenAn = _wenan_liaojiegengduoBtn.selected ? @"了解更多":_yuyuehuodongBtn.selected?@"预约活动":@"领取优惠";
}
- (IBAction)actionForUpLoad:(id)sender {
    WXUploadViewController *uploadVC = [[WXUploadViewController alloc] init];
    [self.navigationController pushViewController:uploadVC animated:YES];
}
- (IBAction)actionForMakeDetail:(id)sender {
    WXMakeDetailViewController *makeDetailVc = [[WXMakeDetailViewController alloc] init];
    [self.navigationController pushViewController:makeDetailVc animated:YES];
}
@end
