//
//  ZFNavigationController.m
//  antifake
//
//  Created by Zach on 2018/1/19.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "ZFNavigationController.h"
#import "UIImage+SSNUIColor.h"
#import "UIImage+SSNUIColor.h"

@interface ZFNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation ZFNavigationController




#pragma mark - Life

/************ 设置TabBarItem属性 ************/
- (void)viewDidLoad {
    [super viewDidLoad];

    self.interactivePopGestureRecognizer.delegate = self;
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"blue.png"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage ssn_imageWithColor:HEX_COLOR(0x0e86ff)]];
    self.navigationBar.titleTextAttributes = @{
                                               NSFontAttributeName:[UIFont systemFontOfSize:18.0f],
                                               NSForegroundColorAttributeName:[UIColor whiteColor]
                                               };
}




/**
 * 拦截所有push进来的子控制器
 * @param viewController 每一次push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // if (不是第一个push进来的子控制器) {
    if (self.childViewControllers.count >= 1) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor clearColor] forState:UIControlStateHighlighted];
        [backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        viewController.hidesBottomBarWhenPushed = YES; // 隐藏底部的工具条
    }
    
    // 设置子控制器的颜色
    viewController.view.backgroundColor = ZFGrayBgColor;
    
    // 调用父类方法
    [super pushViewController:viewController animated:animated];
}



/************ 返回操作 ************/
- (void)back
{
    [self popViewControllerAnimated:YES];
}




#pragma mark - <UIGestureRecognizerDelegate>

/************ 手势 ************/
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count > 1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
