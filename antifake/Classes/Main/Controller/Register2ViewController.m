//
//  Register2ViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/5/30.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "Register2ViewController.h"
#import "LoginModelControl.h"

@interface Register2ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *bossNameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *shopPhoneTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *yewuTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *shopNameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *shopAdressTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *invateCodeTextFiled;

@end

@implementation Register2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)initView{
    self.title = @"注册";
}
- (IBAction)actionForRegister:(id)sender {
    if ([Judge judgeStringIsEmpty:_userNameTextFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"用户名不能为空"];
        return;
    }
    if ([Judge judgeStringIsEmpty:_bossNameTextFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"店主名不能为空"];
        return;
    }
    if ([Judge judgeStringIsEmpty:_yewuTextFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"主营业务不能为空"];
        return;
    }
    if ([Judge judgeStringIsEmpty:_shopNameTextFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"店铺名称不能为空"];
        return;
    }
    if ([Judge judgeStringIsEmpty:_shopAdressTextFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"店铺地址不能为空"];
        return;
    }
    if ([Judge judgeStringIsEmpty:_invateCodeTextFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"邀请码不能为空"];
        return;
    }
    [self registerUser];
}
#pragma mark - Net
-(void)registerUser{
    NSDictionary *paratmtar = @{
                                @"token":_token,
                                @"invitation_code":_invateCodeTextFiled.text,
                                @"name":_userNameTextFiled.text,
                                @"password":_loginPwd,
                                @"managerName":_bossNameTextFiled.text,
                                @"bus_phone":_shopPhoneTextFiled.text,
                                @"businessName":_shopNameTextFiled.text,
                                @"bus_site":_shopAdressTextFiled.text,
                                @"industry":_yewuTextFiled.text
                                };
    [SVProgressHUD showWithStatus:@"注册中"];
    [LoginModelControl registerUser:paratmtar success:^{
        [SVProgressHUD showInfoWithStatus:@"注册成功"];
        double delayInSeconds = 1.5 ;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    } failure:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"注册失败"];
    }];
}
@end
