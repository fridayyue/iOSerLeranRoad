//
//  ZFLoginTextField.m
//  happymoney
//
//  Created by chengRui on 2017/10/16.
//  Copyright © 2017年 AW. All rights reserved.
//

#import "ZFLoginTextField.h"

#import "UITextField+ZFExtension.h"

#define ZFPlaceholderLoginColor [UIColor whiteColor]

@implementation ZFLoginTextField

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 文本框的光标颜色
    self.tintColor = ZFPlaceholderLoginColor;
    // 文字颜色
    self.textColor = ZFPlaceholderLoginColor;
    // 设置占位文字颜色
    self.placeholderColor = ZFPlaceholderLoginColor;
}

@end
