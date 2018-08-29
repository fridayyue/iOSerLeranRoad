//
//  SinglePickerAlertView.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/15.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PickerBlock) (NSString *data);

typedef NS_ENUM(NSInteger,PickerType) {
    adAimType = 1,
    adTypeType,
    adBuyType,
    ageType,
    adShowType,
    adDetailDemo,
    adShiDuan,
};
@interface SinglePickerAlertView : UIView
-(instancetype)initWithData:(NSArray *)dataArray defaultString:(NSString *)defaultString;
-(instancetype)initWithType:(PickerType)pickerType defaultString:(NSString *)defaultString;
@property(nonatomic,copy)PickerBlock block;;

@end
