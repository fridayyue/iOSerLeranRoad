//
//  ZFTabBarController.h
//  antifake
//
//  Created by Zach on 2018/2/3.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ChangeTabbarBlock)(UIViewController *viewcontroller);

@interface ZFTabBarController : UITabBarController
@property(nonatomic,copy)ChangeTabbarBlock changeTabbarBlock;

@end
