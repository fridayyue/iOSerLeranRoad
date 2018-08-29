//
//  BasicViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/5/28.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicViewController.h"
#import "NavTitleView.h"

@interface BasicViewController ()

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView{
    
}
-(void)makeRightNavBtnTitle:(NSString *)rightTitle{
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, 60, 44);
    [right setTitle:rightTitle forState:UIControlStateNormal];
    right.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [right addTarget:self action:@selector(actionForRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)makeRightNavBtnImage:(UIImage *)rightImage{
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, 44, 44);
    [right setImage:rightImage forState:UIControlStateNormal];
    [right addTarget:self action:@selector(actionForRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)makeRightNavBtnTitle1:(NSString *)right1Str title2:(NSString *)right2Str{
    UIButton *right1 = [UIButton buttonWithType:UIButtonTypeCustom];
    right1.frame = CGRectMake(0, 0, 44, 44);
    [right1 setTitle:right1Str forState:UIControlStateNormal];
    right1.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [right1 addTarget:self action:@selector(actionForRight1Btn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *right2 = [UIButton buttonWithType:UIButtonTypeCustom];
    right2.frame = CGRectMake(44, 0, 44, 44);
    [right2 setTitle:right2Str forState:UIControlStateNormal];
    right2.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [right2 addTarget:self action:@selector(actionForRight2Btn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 88, 44)];
    [btnView addSubview:right1];
    [btnView addSubview:right2];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btnView];
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)makeTitleView:(NSString *)title titleImage:(NSString *)imageName{
    NavTitleView *navTitleView = [[NavTitleView alloc] init];
    navTitleView.titleLB.text = title;
    [navTitleView.titleIM setImage:[UIImage imageNamed:imageName]];
    [navTitleView.titleBtn addTarget:self action:@selector(actionForNavTitleView:) forControlEvents:UIControlEventTouchUpInside];
    navTitleView.intrinsicContentSize = CGSizeMake(200, 30);
    self.navigationItem.titleView = navTitleView;
}
-(IBAction)actionForRightBtn:(id)sender{
    
}
-(IBAction)actionForRight1Btn:(id)sender{
    
}
-(IBAction)actionForRight2Btn:(id)sender{
    
}
-(IBAction)actionForNavTitleView:(id)sender{
    
}
@end
