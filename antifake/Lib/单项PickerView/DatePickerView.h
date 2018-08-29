//
//  DatePickerView.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/18.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DatePickerBlock) (NSDate *date);

@interface DatePickerView : UIView

@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;
@property(nonatomic,copy)DatePickerBlock block;
@end
