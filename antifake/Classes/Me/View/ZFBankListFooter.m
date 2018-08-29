//
//  ZFBankListFooter.m
//  happymoney
//
//  Created by Zach on 2017/11/10.
//  Copyright © 2017年 AW. All rights reserved.
//

#import "ZFBankListFooter.h"
//#import "ZFBankCardAuditController.h"
@interface ZFBankListFooter ()

{
    CGRect myframe;
}

@end

@implementation ZFBankListFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 创建button
        UIButton *addBankCardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        // 设置button的背景图片
        [addBankCardButton setBackgroundImage:[UIImage imageNamed:@"add_bankcard"] forState:UIControlStateNormal];
        
        // 设置button内部文字
        [addBankCardButton setTitle:@"+ 添加银行卡" forState:UIControlStateNormal];
        
        // 设置button文字
        [addBankCardButton setTitleColor:ZFColor(227, 227, 227) forState:UIControlStateNormal];
        
        // 进行强引用
        self.addBankCardButton = addBankCardButton;
        
        // 添加点击事件
        [addBankCardButton addTarget:self action:@selector(addBankCardClickAction) forControlEvents:UIControlEventTouchUpInside];
        
        // 添加到footer
        [self addSubview:addBankCardButton];
        
        // 设置高度
        self.height = 70;
        
        // 重新赋值footerView
        UITableView *tableView = (UITableView *)self.superview;
        tableView.tableFooterView = self;
       
    }
    
    return self;
}



/*********** 布局子控件 ***********/
- (void)layoutSubviews
{
    
    self.addBankCardButton.frame = CGRectMake(20, 10, ZFScreenW - 40, 50);
    
}


/*********** 添加银行卡 ***********/
- (void)addBankCardClickAction
{
    UITabBarController *rootVc = (UITabBarController *)self.window.rootViewController;
    UINavigationController *nav = (UINavigationController *)rootVc.selectedViewController;
    
//    ZFBankCardAuditController *vc = [[ZFBankCardAuditController alloc] init];
//    
//    [nav pushViewController:vc animated:YES];
//
    
    
}
//-(void)drawRect:(CGRect)rect
//{
//    self.frame = myframe;//关键点在这里
//    
//}

/*
 
 // 取出当前选中的导航控制器
 UITabBarController *rootVc = (UITabBarController *)self.window.rootViewController;
 UINavigationController *nav = (UINavigationController *)rootVc.selectedViewController;
 [nav pushViewController:webVc animated:YES];
 
 */
@end
