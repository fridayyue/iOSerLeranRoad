//
//  SexOrAngePickerView.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/11.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "SexOrAngePickerView.h"

@interface SexOrAngePickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end

@implementation SexOrAngePickerView{
    PickerType _pickerType;
    NSArray *_dataArray;
    NSString *_dataSelectData;
}
-(instancetype)initWithType:(PickerType)pickerType{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        _pickerType = pickerType;
        [self makeView];
    }
    return self;
}
-(void)makeView{
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [self configData];

}
-(void)configData{
    NSString *pathString = @"";
    if (_pickerType == sexPicker) {
        pathString = @"Sex";
    }else{
        pathString = @"Age";
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:pathString ofType:@"plist"];
    _dataArray = [[NSArray alloc] initWithContentsOfFile:path];
    [_pickerView reloadAllComponents];
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _dataArray.count;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return ZFScreenW;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
//    UIView *cellView = [[UIView alloc] init];
//    cellView.tag = 1000;
    UILabel *lable=[[UILabel alloc]init];
    lable.textAlignment=NSTextAlignmentCenter;
    lable.font=[UIFont systemFontOfSize:16.0f];
    lable.text = _dataArray[row];
    lable.textColor = HEX_COLOR(0x333333);
    lable.tag = 1001;
    return lable;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *data = _dataArray[row];
    _dataSelectData = data;
    UILabel *cellLabel = (UILabel*)[pickerView viewForRow:row forComponent:component];
    cellLabel.textColor = [UIColor blueColor];
}
- (IBAction)actionForSure:(id)sender {
    if (_block) {
        _block(_dataSelectData);
    }
    [self actionForBG:sender];
}
- (IBAction)actionForBG:(id)sender {
    if (self&&self.superview) {
        [self removeFromSuperview];
    }
}
@end
