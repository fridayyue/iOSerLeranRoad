//
//  DXSaiXuanViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/23.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DXSaiXuanViewController.h"
#import "DatePickerView.h"
#import "XTTimeDateManger.h"
#import <Masonry.h>


@interface DXSaiXuanViewController ()
@property (weak, nonatomic) IBOutlet UILabel *startTimeLB;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLB;

@end

@implementation DXSaiXuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)initView{
    self.title = @"筛选";
    _defineStratDate = _defineStratDate?_defineStratDate:[NSDate date];
    _defineEndDate = _defineEndDate?_defineEndDate:[XTTimeDateManger stringToDate:[XTTimeDateManger distanceDate:_defineStratDate second:-60*60*24*3] oldFormatter:@"YYYY/MM/dd hh:mm:ss" newFormatter:@"yyyy-MM-dd"];
    _startTimeLB.text = [XTTimeDateManger fomatterTime:@"yyyy-MM-dd" date:_defineStratDate];
    _endTimeLB.text = [XTTimeDateManger fomatterTime:@"yyyy-MM-dd" date:_defineEndDate];
    [self updateShow];
}
-(void)updateShow{
    _startTimeLB.text = [XTTimeDateManger timeStringToCalander:[XTTimeDateManger fomatterTime:@"yyyy-MM-dd" date:_defineStratDate]];
    _endTimeLB.text = [XTTimeDateManger timeStringToCalander:[XTTimeDateManger fomatterTime:@"yyyy-MM-dd" date:_defineEndDate]];
}
- (IBAction)actionForStartTime:(UIButton *)sender {
    DatePickerView *picker = [[DatePickerView alloc] init];
    picker.datePickerView.date = _defineStratDate;
    picker.block = ^(NSDate *date) {
        _defineStratDate = date;
        [self updateShow];
    };
    [self.navigationController.view addSubview:picker];
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.navigationController.view);
    }];
}
- (IBAction)actionForEndTime:(id)sender {
    DatePickerView *picker = [[DatePickerView alloc] init];
    picker.datePickerView.date = _defineEndDate;
    picker.block = ^(NSDate *date) {
        _defineEndDate = date;
        [self updateShow];
    };
    [self.navigationController.view addSubview:picker];
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.navigationController.view);
    }];
}
- (IBAction)actionForSure:(UIButton *)sender{
    if (_shaiXuanBlock) {
        _shaiXuanBlock(_defineStratDate,_defineEndDate);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
