//
//  UIBarButtonItem+ZFExtension.h
//  antifake
//
//  Created by Zach on 2018/2/17.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZFExtension)

+ (instancetype)itemWithTitle:(NSString *)titile target:(id)target action:(SEL)action;

+ (instancetype)itemWithImage:(NSString *)image target:(id)target action:(SEL)action;

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;


@end
