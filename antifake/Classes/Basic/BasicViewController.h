//
//  BasicViewController.h
//  antifake
//
//  Created by 岳腾飞 on 2018/5/28.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicViewController : UIViewController
-(void)initView;

-(void)makeRightNavBtnTitle:(NSString *)rightTitle;
-(void)makeRightNavBtnImage:(UIImage *)rightImage;
-(void)makeRightNavBtnTitle1:(NSString *)right1Str title2:(NSString *)right2Str;
-(void)makeTitleView:(NSString *)title titleImage:(NSString *)imageName;

-(IBAction)actionForRightBtn:(id)sender;
-(IBAction)actionForRight1Btn:(id)sender;
-(IBAction)actionForRight2Btn:(id)sender;
-(IBAction)actionForNavTitleView:(id)sender;

@end
