//
//  UIBarButtonItem+ZFExtention.h
//  CooperativeWorking
//
//  Created by chengRui on 2017/4/15.
//  Copyright © 2017年 chengRui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZFExtention)

+ (instancetype)itemWithTitle:(NSString *)titile target:(id)target action:(SEL)action;

+ (instancetype)itemWithImage:(NSString *)image target:(id)target action:(SEL)action;

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
