//
//  ZFMeHeaderView.h
//  happymoney
//
//  Created by chengRui on 2017/10/10.
//  Copyright © 2017年 AW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFMeHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *userStateLabel;
@property (weak, nonatomic) IBOutlet UIButton *userInfoButton;
@property (weak, nonatomic) IBOutlet UIButton *borrowButton;
@property (weak, nonatomic) IBOutlet UILabel *borrowMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIButton *rechargeButton;

@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;

+ (instancetype)headerView;

@end
