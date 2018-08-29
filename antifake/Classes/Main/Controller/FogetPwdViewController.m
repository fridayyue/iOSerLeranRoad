//
//  FogetPwdViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/5/29.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "FogetPwdViewController.h"
#import "LoginModelControl.h"
#import "FogetPwd2ViewController.h"
#import "MyTimerManger.h"

@interface FogetPwdViewController ()<MyTimerMangerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phonetextFiled;
@property (weak, nonatomic) IBOutlet UITextField *vcodeTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *getVcodeBtn;

@end

@implementation FogetPwdViewController{
    NSString *_token;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
-(void)dealloc{
    [MyTimerManger Sharemanger].myTimerDelegate = nil;
}
-(void)initView{
    self.title = @"忘记密码";
    if ([[MyTimerManger Sharemanger].lastResource isEqualToString:NSStringFromClass([self class])]) {
        [[MyTimerManger Sharemanger] startTimerWorkingWithTimeCount:60 resource:NSStringFromClass([self class])];
        [MyTimerManger Sharemanger].myTimerDelegate = self;
    }
    [_phonetextFiled becomeFirstResponder];
    _token = @"";
}
#pragma mark - Action
- (IBAction)actionForGetVcode:(id)sender {
    if (![Judge judgePhoneNumber:_phonetextFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确手机号"];
        return;
    }
    [self getVode];
}
- (IBAction)actionForNext:(id)sender {
    if ([Judge judgeStringIsEmpty:_vcodeTextFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"请输入验证码"];
        return;
    }
    [self vertifyVCode];
}
#pragma mark - TimerDelegate
-(void)timerWorkingWithTimeCount:(NSInteger)timeCount{
    _getVcodeBtn.userInteractionEnabled = NO;
    [_getVcodeBtn setTitle:[NSString stringWithFormat:@"%lds",timeCount] forState:UIControlStateNormal];
}
-(void)timerComplete{
    _getVcodeBtn.userInteractionEnabled = YES;
    [_getVcodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
}
#pragma mark - Net
-(void)getVode{
    NSDictionary *paramtar = @{
                               @"phone":_phonetextFiled.text
                               };
    [SVProgressHUD showWithStatus:@"获取中"];
    [LoginModelControl getFogetPWDsmsCode:paramtar success:^(GetVocodeModel *vcodeModel) {
        [SVProgressHUD showSuccessWithStatus:@"获取成功"];
        _token = vcodeModel.data;
        [[MyTimerManger Sharemanger] startTimerWorkingWithTimeCount:60 resource:NSStringFromClass([self class])];
        [MyTimerManger Sharemanger].myTimerDelegate = self;
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"获取失败"];
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
        [self goto2VC];
    } failure:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"验证失败"];
    }];
}
#pragma mark - GOTO
-(void)goto2VC{
    FogetPwd2ViewController *foget2VC = [[FogetPwd2ViewController alloc] init];
    foget2VC.token = _token;
    foget2VC.verification_code = _vcodeTextFiled.text;
    [self
     .navigationController pushViewController:foget2VC animated:YES];
}
@end
