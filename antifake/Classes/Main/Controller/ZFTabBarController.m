//
//  ZFTabBarController.m
//  antifake
//
//  Created by Zach on 2018/2/3.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "ZFTabBarController.h"
#import "ZFNavigationController.h"

#import "HomeViewController.h"
#import "HomeNewViewController.h"
#import "DataCenterViewController.h"
#import "ZFMeViewController.h"
#import "StatementViewController.h"
#import "DataCenter_ViewController.h"
#import "UIImage+SSNUIColor.h"

@interface ZFTabBarController ()<UITabBarControllerDelegate>
@property(nonatomic,strong)HomeNewViewController* homeVC;
@property(nonatomic,strong)ZFNavigationController* homeNav;

@property(nonatomic,strong)DataCenter_ViewController* dataCenterVC;
@property(nonatomic,strong)ZFNavigationController* dataCenterNav;

@property(nonatomic,strong)StatementViewController* statementVC;
@property(nonatomic,strong)ZFNavigationController* statementNav;

@property(nonatomic,strong)ZFMeViewController* mineVC;
@property(nonatomic,strong)ZFNavigationController* mineNav;
@end

@implementation ZFTabBarController

#pragma mark - Life

/************ 程序入口 ************/
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.delegate = self;
    [self setUpTabBarItem];
    [self setUpAllChildVC];
    
}
- (void)setUpTabBarItem
{
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];

    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBar.backgroundImage = [UIImage ssn_imageWithColor:HEX_COLOR(0x27d1ff)];
    [UITabBar appearance].clipsToBounds = YES;
}

- (void)setUpAllChildVC
{
    _homeVC = [[HomeNewViewController alloc] init];
    _homeNav = [[ZFNavigationController alloc] initWithRootViewController:_homeVC];
    _homeNav.tabBarItem.title = @"首页";
    _homeNav.tabBarItem.image = [UIImage imageNamed:@"home_normal"];
    _homeNav.tabBarItem.selectedImage = [UIImage imageNamed:@"home_selected"];
    
    _dataCenterVC = [[DataCenter_ViewController alloc] init];
    _dataCenterNav = [[ZFNavigationController alloc] initWithRootViewController:_dataCenterVC];
    _dataCenterNav.tabBarItem.title = @"数据中心";
    _dataCenterNav.tabBarItem.image = [UIImage imageNamed:@"analyse_normal"];
    _dataCenterNav.tabBarItem.selectedImage = [UIImage imageNamed:@"analyse_selected"];
    
    _statementVC = [[StatementViewController alloc] init];
    _statementNav = [[ZFNavigationController alloc] initWithRootViewController:_statementVC];
    _statementNav.tabBarItem.title = @"统计报表";
    _statementNav.tabBarItem.image = [UIImage imageNamed:@"statement_normal.png"];
    _statementNav.tabBarItem.selectedImage = [UIImage imageNamed:@"statement_selected.png"];
    
    _mineVC = [[ZFMeViewController alloc] init];
    _mineNav = [[ZFNavigationController alloc] initWithRootViewController:_mineVC];
    _mineNav.tabBarItem.title = @"我的";
    _mineNav.tabBarItem.image = [UIImage imageNamed:@"me_normal"];
    _mineNav.tabBarItem.selectedImage = [UIImage imageNamed:@"me_selected"];
    
    self.viewControllers = @[_homeNav,_dataCenterNav,_statementNav,_mineNav];
}
#pragma mark - TablBarDelegate
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TabbardidSelectViewController" object:viewController];
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if ([item isEqual:_homeNav.tabBarItem]) {
        tabBar.backgroundImage = [UIImage ssn_imageWithColor:HEX_COLOR(0x27d1ff)];
    }else{
        tabBar.backgroundImage = [UIImage ssn_imageWithColor:TotalBlue];
    }
}
@end
