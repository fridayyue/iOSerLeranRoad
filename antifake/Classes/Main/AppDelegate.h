//
//  AppDelegate.h
//  antifake
//
//  Created by Zach on 2018/1/18.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFTabBarController.h"
#import "ZFNavigationController.h"
#import "ZFLoginViewController.h"
#import "LeadingViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)ZFTabBarController* rootTabbar;
@property(nonatomic,strong)ZFNavigationController* loginRootNav;
@property(nonatomic,strong)ZFLoginViewController* loginVC;
@property(nonatomic,strong)LeadingViewController* leadingVC;

-(void)changeRootVC;
-(void)changeToTableRootVC;
-(void)changeToLoginVC;
@end

