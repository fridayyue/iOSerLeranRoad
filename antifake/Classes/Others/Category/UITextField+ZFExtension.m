//
//  UITextField+ZFExtension.m
//  happymoney
//
//  Created by chengRui on 2017/10/16.
//  Copyright © 2017年 AW. All rights reserved.
//

#import "UITextField+ZFExtension.h"

/** 占位文字颜色 */
static NSString * const XMGPlaceholderColorKey = @"placeholderLabel.textColor";

@implementation UITextField (ZFExtension)

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    BOOL change = NO;
    
    // 保证有占位文字
    if (self.placeholder == nil) {
        self.placeholder = @" ";
        change = YES;
    }
    
    // 设置占位文字颜色
    [self setValue:placeholderColor forKeyPath:XMGPlaceholderColorKey];
    
    // 恢复原状
    if (change) {
        self.placeholder = nil;
    }
}

- (UIColor *)placeholderColor
{
    return [self valueForKeyPath:XMGPlaceholderColorKey];
}


@end
