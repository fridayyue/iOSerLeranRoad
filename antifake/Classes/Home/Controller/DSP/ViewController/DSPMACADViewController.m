//
//  DSPMACADViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/7/1.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DSPMACADViewController.h"
#import "DSPMeiTIViewController.h"
#import "DSPModelControl.h"
#import "FindAVAlertView.h"
#import "DatePickerView.h"
#import "XTTimeDateManger.h"
#import "SinglePickerAlertView.h"
#import "DSPCreatAD2ViewController.h"
#import "DSPManger.h"

@interface DSPMACADViewController ()
@property (weak, nonatomic) IBOutlet UILabel *meitiLB;
@property (weak, nonatomic) IBOutlet UILabel *adTypeLB;
@property (weak, nonatomic) IBOutlet UIButton *startTimeBTN;
@property (weak, nonatomic) IBOutlet UIButton *endTimeBTN;
@property (weak, nonatomic) IBOutlet UILabel *shiduanLb;

@end

@implementation DSPMACADViewController{
    MeiTiModel *_selectMetiModel;
    FindAVModel *_findAvModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)initView{
    self.title = @"创建广告";
}
#pragma mrk - Net
-(void)findAV{
//    media_id    8
    NSDictionary *paramtar = @{
                               @"media_id":_selectMetiModel.id,
                               @"token":[UserManger shareManger].getUserID
                               };
    [DSPModelControl getFindAdv:paramtar success:^(NSArray *array) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // UI更新代码
            FindAVAlertView *alertView = [[FindAVAlertView alloc] initWithFrame:self.navigationController.view.bounds listArray:array];
            alertView.findBlock = ^(FindAVModel *model) {
                _findAvModel = model;
                _adTypeLB.text = _findAvModel.adv_name;
                [DSPManger shareManger].adv_id = _findAvModel.id;
                [DSPManger shareManger].advPlace = _findAvModel.adv_name;
                [DSPManger shareManger].custom_price = [NSString stringWithFormat:@"%lf",_findAvModel.custom_price];
            };
            [self.navigationController.view addSubview:alertView];
            
        });
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - Action
- (IBAction)actionMeiTi:(id)sender {
    DSPMeiTIViewController *meitiVC = [[DSPMeiTIViewController alloc] init];
    meitiVC.meitiBlock = ^(MeiTiModel *meitiModel) {
        _meitiLB.text = meitiModel.media_name;
        _selectMetiModel = meitiModel;
        [DSPManger shareManger].media_name = meitiModel.media_name;
    };
    [self.navigationController pushViewController:meitiVC animated:YES];
}
- (IBAction)actionForAdType:(id)sender {
    [self findAV];
}
- (IBAction)actionForStartTime:(id)sender {
    DatePickerView *picker = [[DatePickerView alloc] init];
    picker.block = ^(NSDate *date) {
        [_startTimeBTN setTitle:[XTTimeDateManger fomatterTime:@"yyyy-MM-dd" date:date] forState:UIControlStateNormal];
    };
    [self.navigationController.view addSubview:picker];
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.navigationController.view);
    }];
}
- (IBAction)actionForEndTime:(id)sender {
    DatePickerView *picker = [[DatePickerView alloc] init];
    picker.block = ^(NSDate *date) {
        [_endTimeBTN setTitle:[XTTimeDateManger fomatterTime:@"yyyy-MM-dd" date:date] forState:UIControlStateNormal];
    };
    [self.navigationController.view addSubview:picker];
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.navigationController.view);
    }];
}
- (IBAction)actionForShiDuan:(id)sender {
    SinglePickerAlertView *aimAlertView = [[SinglePickerAlertView alloc] initWithType:adShiDuan defaultString:_shiduanLb.text];
    aimAlertView.block = ^(NSString *data) {
        _shiduanLb.text = data;
    };
    [self.navigationController.view addSubview:aimAlertView];
    [aimAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.navigationController.view);
    }];
}
- (IBAction)actionForNext:(id)sender {
    if (!_selectMetiModel) {
        [SVProgressHUD showErrorWithStatus:@"请选择媒体"];
        return;
    }
    if (!_findAvModel) {
        [SVProgressHUD showErrorWithStatus:@"请选择广告类型"];
        return;
    }
    if ([_startTimeBTN.titleLabel.text isEqualToString:@"开始日期"]) {
        [SVProgressHUD showErrorWithStatus:@"请选投放开始日期"];
        return;
    }
    if ([_endTimeBTN.titleLabel.text isEqualToString:@"结束日期"]) {
        [SVProgressHUD showErrorWithStatus:@"请选投放结束日期"];
        return;
    }
    [DSPManger shareManger].put_starttime = _startTimeBTN.titleLabel.text;
    [DSPManger shareManger].put_endtime = _endTimeBTN.titleLabel.text;
    [DSPManger shareManger].media = _selectMetiModel.id;
    [DSPManger shareManger].time_interval = _shiduanLb.text;
    DSPCreatAD2ViewController *ad2VC = [[DSPCreatAD2ViewController alloc] init];
    [self.navigationController pushViewController:ad2VC animated:YES];
}
@end
