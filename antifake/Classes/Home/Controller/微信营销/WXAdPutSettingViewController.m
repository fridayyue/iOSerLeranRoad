//
//  WXAdPutSettingViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/16.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "WXAdPutSettingViewController.h"
#import "WXSelectAreaViewController.h"
#import "WXYingXiaoManger.h"
#import "SinglePickerAlertView.h"
#import <Masonry.h>
#import "DatePickerView.h"
#import "XTTimeDateManger.h"
#import "WXADEditingViewController.h"

@interface WXAdPutSettingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *funLabel;

@property (weak, nonatomic) IBOutlet UIButton *allPeopleBtn;
@property (weak, nonatomic) IBOutlet UIButton *womanBtn;
@property (weak, nonatomic) IBOutlet UIButton *manBtn;

@property (weak, nonatomic) IBOutlet UILabel *ageBtn;

@property (weak, nonatomic) IBOutlet UIButton *customDateBtn;
@property (weak, nonatomic) IBOutlet UIButton *allDayBtn;

@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *againCustomBtn;
@property (weak, nonatomic) IBOutlet UIButton *againNoBtn;

@property (weak, nonatomic) IBOutlet UIButton *outCustomBtn;
@property (weak, nonatomic) IBOutlet UIButton *outNoButton;

@property (weak, nonatomic) IBOutlet UILabel *everyDayCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *offerLabel;

@property (weak, nonatomic) IBOutlet UIStepper *everyDaySlider;
@property (weak, nonatomic) IBOutlet UIStepper *totalSlider;

@end

@implementation WXAdPutSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self upDataView];
}
-(void)initView{
    self.title = @"投放设置";
    if ([[WXYingXiaoManger shareManger].pushSex isEqualToString:@"所有人群"]) {
        _allPeopleBtn.selected = YES;
    }else if ([[WXYingXiaoManger shareManger].pushSex isEqualToString:@"女"]){
        _womanBtn.selected = YES;
    }else if ([[WXYingXiaoManger shareManger].pushSex isEqualToString:@"男"]){
        _manBtn.selected = YES;
    }else{
        _allPeopleBtn.selected = YES;
    }
    _ageBtn.text = [WXYingXiaoManger shareManger].pushAge;
    if ([WXYingXiaoManger shareManger].isDayPush) {
        _allDayBtn.selected = YES;
    }else{
        _customDateBtn.selected = YES;
    }
    _startTimeLabel.text = [Judge judgeStringIsEmpty:[WXYingXiaoManger shareManger].startTime]?@"开始日期":[WXYingXiaoManger shareManger].startTime;
     _endTimeLabel.text = [Judge judgeStringIsEmpty:[WXYingXiaoManger shareManger].overTime]?@"结束日期":[WXYingXiaoManger shareManger].overTime;
    
    _againCustomBtn.selected = [WXYingXiaoManger shareManger].marketing;
    _againNoBtn.selected = !_againCustomBtn.selected;
    
    _outCustomBtn.selected = [WXYingXiaoManger shareManger].wxOut;
    _outNoButton.selected = !_outCustomBtn.selected;
    _everyDaySlider.value = [Judge judgeStringIsEmpty:[WXYingXiaoManger shareManger].wxEverdayPrice]?1000:[[WXYingXiaoManger shareManger].wxEverdayPrice floatValue];
    _everyDayCostLabel.text = [NSString stringWithFormat:@"%.0lf",_everyDaySlider.value];
    
    _totalSlider.value = [Judge judgeStringIsEmpty:[WXYingXiaoManger shareManger].wxTotalPrice]?100:[[WXYingXiaoManger shareManger].wxTotalPrice floatValue];
    _offerLabel.text = [NSString stringWithFormat:@"%.0lf",_totalSlider.value];
}
-(void)upDataView{
    _areaLabel.text = [NSString stringWithFormat:@"已选择%ld个城市",[WXYingXiaoManger shareManger].wxAreaArray.count];
    _funLabel.text = [NSString stringWithFormat:@"已选择%ld个兴趣",[WXYingXiaoManger shareManger].wxFunArray.count];
}
#pragma mark - Action

- (IBAction)actionForArea:(id)sender {
    WXSelectAreaViewController *selectAreaVC = [[WXSelectAreaViewController alloc] init];
    selectAreaVC.selectType = wxAereaSelectType;
    [self.navigationController pushViewController:selectAreaVC animated:YES];
}
- (IBAction)actionForFun:(id)sender {
    WXSelectAreaViewController *selectAreaVC = [[WXSelectAreaViewController alloc] init];
    selectAreaVC.selectType = wxFunSelectType;
    [self.navigationController pushViewController:selectAreaVC animated:YES];
}
- (IBAction)actionForPeopleType:(UIButton *)sender {
    _allPeopleBtn.selected = NO;
    _manBtn.selected = NO;
    _womanBtn.selected = NO;
    sender.selected = YES;
    [WXYingXiaoManger shareManger].pushSex = _allPeopleBtn.selected ? _allPeopleBtn.titleLabel.text :_manBtn.selected ? _manBtn.titleLabel.text : _womanBtn.titleLabel.text;
}
- (IBAction)actionForAge:(id)sender {
    SinglePickerAlertView *aimAlertView = [[SinglePickerAlertView alloc] initWithType:ageType defaultString:_ageBtn.text];
    aimAlertView.block = ^(NSString *data) {
        self->_ageBtn.text = data;
        [WXYingXiaoManger shareManger].pushAge = data;
    };
    [self.navigationController.view addSubview:aimAlertView];
    [aimAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.navigationController.view);
    }];
}
- (IBAction)actionForDate:(UIButton *)sender {
    _customDateBtn.selected = NO;
    _allDayBtn.selected = NO;
    sender.selected = YES;
    [WXYingXiaoManger shareManger].isDayPush = _allDayBtn.selected;
}
- (IBAction)actionForStartTime:(id)sender {
    DatePickerView *picker = [[DatePickerView alloc] init];
    picker.block = ^(NSDate *date) {
        self->_startTimeLabel.text = [XTTimeDateManger fomatterTime:@"yyyy-MM-dd" date:date];
        [WXYingXiaoManger shareManger].startTime = _startTimeLabel.text;
    };
    [self.navigationController.view addSubview:picker];
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.navigationController.view);
    }];
}
- (IBAction)actionForEndTime:(id)sender {
    DatePickerView *picker = [[DatePickerView alloc] init];
    picker.block = ^(NSDate *date) {
        self->_endTimeLabel.text = [XTTimeDateManger fomatterTime:@"yyyy-MM-dd" date:date];
        [WXYingXiaoManger shareManger].overTime = _startTimeLabel.text;
    };
    [self.navigationController.view addSubview:picker];
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.navigationController.view);
    }];
}
- (IBAction)actionForagain:(UIButton *)sender {
    _againCustomBtn.selected = NO;
    _againNoBtn.selected = NO;
    sender.selected = YES;
    [WXYingXiaoManger shareManger].marketing = _againNoBtn.selected ? NO:YES;
}
- (IBAction)actionForOut:(UIButton *)sender {
    _outCustomBtn.selected = NO;
    _outNoButton.selected = NO;
    sender.selected = YES;
    [WXYingXiaoManger shareManger].wxOut = _outNoButton.selected ? NO:YES;
}
- (IBAction)actionForStepper:(UIStepper *)sender {
    _everyDayCostLabel.text = [NSString stringWithFormat:@"%.0lf",sender.value];
    [WXYingXiaoManger shareManger].wxEverdayPrice = _everyDayCostLabel.text;
}
- (IBAction)actionFDorOffer:(UIStepper *)sender {
    _offerLabel.text = [NSString stringWithFormat:@"%.0lf",sender.value];
    [WXYingXiaoManger shareManger].wxTotalPrice = _offerLabel.text;
}
- (IBAction)actionForNext:(id)sender {
    if ([self check]) {
        WXADEditingViewController *adEditingVC = [[WXADEditingViewController alloc] init];
        [self.navigationController pushViewController:adEditingVC animated:YES];
    }
    
}
-(BOOL)check{
    if ([WXYingXiaoManger shareManger].wxAreaArray.count <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择区域"];
        return NO;
    }
    if ([WXYingXiaoManger shareManger].wxFunArray.count <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择兴趣"];
        return NO;
    }
    if ([Judge judgeStringIsEmpty:[WXYingXiaoManger shareManger].startTime]) {
        [SVProgressHUD showErrorWithStatus:@"请选择上线时间"];
        return NO;
    }
    if ([Judge judgeStringIsEmpty:[WXYingXiaoManger shareManger].overTime]) {
        [SVProgressHUD showErrorWithStatus:@"请选择结束时间"];
        return NO;
    }
    return YES;
}
@end
