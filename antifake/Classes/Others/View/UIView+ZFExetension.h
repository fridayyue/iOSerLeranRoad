//
//  UIView+ZFExetension.h
//  EquipmentCenter
//
//  Created by chengRui on 2016/12/9.
//  Copyright © 2016年 chengRui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZFExetension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

/** 从xib中创建一个控件 */
+ (instancetype)viewFromXib;
@end
