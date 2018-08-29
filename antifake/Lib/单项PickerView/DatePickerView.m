//
//  DatePickerView.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/18.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DatePickerView.h"

@interface DatePickerView()

@end

@implementation DatePickerView{
    NSDate *_currentDate;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        [self initView];
    }
    return self;
}
-(void)initView{
    [_datePickerView addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    _currentDate = _datePickerView.date;
}
-(void)dateChanged:(UIDatePicker *)datePicker{
    _currentDate = datePicker.date;
}
- (IBAction)actionForSure:(id)sender {
    if (_block) {
        _block(_currentDate);
    }
    [self actionForCancle:sender];
}
- (IBAction)actionForCancle:(id)sender {
    if (self.superview) {
        [self removeFromSuperview];
    }
}
@end
