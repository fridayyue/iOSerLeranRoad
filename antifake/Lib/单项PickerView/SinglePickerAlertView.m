//
//  SinglePickerAlertView.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/15.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "SinglePickerAlertView.h"

@interface SinglePickerAlertView()
<
    UIPickerViewDelegate,
    UIPickerViewDataSource
>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end

@implementation SinglePickerAlertView{
    PickerType _pickerType;
    NSArray *_dataArray;
    NSString *_defaultString;
    NSString *_dataSelectData;
}

-(instancetype)initWithType:(PickerType)pickerType defaultString:(NSString *)defaultString{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        _pickerType = pickerType;
        _defaultString = defaultString;
        [self makeView];
    }
    return self;
}
-(instancetype)initWithData:(NSArray *)dataArray defaultString:(NSString *)defaultString{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        _defaultString = defaultString;
        _dataArray = dataArray;
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
    switch (_pickerType) {
        case adAimType:
        {
            pathString = @"adAimType";
        }
            break;
        case adTypeType:
        {
            pathString = @"adTypeType";
        }
            break;
        case adBuyType:
        {
            pathString = @"adBuyType";
        }
            break;
        case ageType:
        {
            pathString = @"Age";
        }
            break;
        case adShowType:
        {
            pathString = @"adShowType";
        }
            break;
        case adDetailDemo:
        {
            pathString = @"adDetailDemo";
        }
            break;
        case adShiDuan:
        {
            pathString = @"adShiduan";
        }
            break;
            
        default:
            
            break;
    }
    if (![Judge judgeStringIsEmpty:pathString]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:pathString ofType:@"plist"];
        _dataArray = [[NSArray alloc] initWithContentsOfFile:path];
    }
    [_pickerView reloadAllComponents];
    NSInteger index = [_dataArray indexOfObject:_defaultString];
    index = (index > _dataArray.count)?0:index;
    [_pickerView selectRow:index inComponent:0 animated:YES];
    _dataSelectData = _defaultString;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _dataArray.count;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return ZFScreenW;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *lable=[[UILabel alloc]init];
    lable.textAlignment=NSTextAlignmentCenter;
    lable.font=[UIFont systemFontOfSize:16.0f];
    lable.text = _dataArray[row];
    lable.textColor = [_dataSelectData isEqualToString:lable.text]?[UIColor blueColor]:[UIColor blackColor];
    return lable;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *data = _dataArray[row];
    _dataSelectData = data;
    UILabel *cellLabel = (UILabel*)[pickerView viewForRow:row forComponent:component];
    cellLabel.textColor = [UIColor blueColor];
    [pickerView reloadAllComponents];
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
