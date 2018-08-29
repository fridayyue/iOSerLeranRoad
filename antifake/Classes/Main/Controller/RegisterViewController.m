//
//  RegisterViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/5/28.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "RegisterViewController.h"
#import "MyTimerManger.h"
#import "LoginModelControl.h"
#import "Register2ViewController.h"

@interface RegisterViewController ()<MyTimerMangerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *vcodeTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *senMessageBtn;
@property (weak, nonatomic) IBOutlet UITextField *loginPwdTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *vertifyLoginPwdTextFiled;

@end

@implementation RegisterViewController{
    NSString *_token;
    NSString *_pwdString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
-(void)dealloc{
    [MyTimerManger Sharemanger].myTimerDelegate = nil;
}
#pragma mark - initView
-(void)initView{
    self.title = @"注册";
    [_phoneNumberTextFiled becomeFirstResponder];
    if ([[MyTimerManger Sharemanger].lastResource isEqualToString:NSStringFromClass([self class])]) {
        [[MyTimerManger Sharemanger] startTimerWorkingWithTimeCount:60 resource:NSStringFromClass([self class])];
        [MyTimerManger Sharemanger].myTimerDelegate = self;
    }
    _token = @"";
}
#pragma mark - Action
- (IBAction)actionForSendcode:(id)sender {
    if (![Judge judgePhoneNumber:_phoneNumberTextFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"手机号码有误"];
        return;
    }
    [self getsmsCode];
}
- (IBAction)actionForNext:(id)sender {
    if (![Judge judgePWD:_loginPwdTextFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"登录密码格式设置有误"];
        return;
    }
    if (![_loginPwdTextFiled.text isEqualToString:_vertifyLoginPwdTextFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"两次密码输入不一致"];
        return;
    }
    [self vertifyVCode];
}
#pragma mark - TimerDelegate
-(void)timerWorkingWithTimeCount:(NSInteger)timeCount{
    _senMessageBtn.userInteractionEnabled = NO;
    [_senMessageBtn setTitle:[NSString stringWithFormat:@"%lds",timeCount] forState:UIControlStateNormal];
}
-(void)timerComplete{
    _senMessageBtn.userInteractionEnabled = YES;
    [_senMessageBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
}
#pragma mark - Net
-(void)getsmsCode{
    NSDictionary *paramtars = @{
                                @"phone":_phoneNumberTextFiled.text,
                                @"token":_token
                                };
    [SVProgressHUD showWithStatus:@"正在获取"];
    [LoginModelControl getsmsCode:paramtars success:^(GetVocodeModel *getVcodeModel) {
        [SVProgressHUD showInfoWithStatus:@"获取成功"];
        self->_token = getVcodeModel.data;
        [[MyTimerManger Sharemanger] startTimerWorkingWithTimeCount:60 resource:NSStringFromClass([self class])];
        [MyTimerManger Sharemanger].myTimerDelegate = self;
    } failure:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"获取失败"];
    }];
}
-(void)vertifyVCode{
    NSDictionary *paramtars = @{
                                @"verification_code":_vcodeTextFiled.text,
                                @"token":_token
                                };
    [SVProgressHUD show];
    [LoginModelControl vertifyVcode:paramtars success:^{
        [SVProgressHUD showInfoWithStatus:@"验证成功"];
        [self gotoRegister2VC];
    } failure:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"验证失败"];
    }];
}
-(void)gotoRegister2VC{
    Register2ViewController *register2VC = [[Register2ViewController alloc] init];
    register2VC.token = _token;
    register2VC.loginPwd = _vertifyLoginPwdTextFiled.text;
    [self.navigationController pushViewController:register2VC animated:YES];
}
@end
