//
//  SexOrAngePickerView.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/11.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SexBlock) (NSString *sex);

typedef NS_ENUM(NSInteger,PickerType) {
    sexPicker,
    agePicker
};

@interface SexOrAngePickerView : UIView
-(instancetype)initWithType:(PickerType)pickerType;
@property(nonatomic,copy)SexBlock block;;
@end
