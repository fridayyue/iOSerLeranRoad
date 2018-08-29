//
//  AddPhone2ViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/12.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "AddPhone2ViewController.h"
#import "LoginModelControl.h"
#import "MyTimerManger.h"
#import "MeModelControl.h"

@interface AddPhone2ViewController ()<MyTimerMangerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *vcodeTF;
@property (weak, nonatomic) IBOutlet UIButton *vcodeBtn;

@end

@implementation AddPhone2ViewController{
    NSString *_token;
    BOOL _requested;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)initView{
    self.title = @"手机号";
    _token = @"";
    _requested = NO;
}
#pragma mark - Net
-(void)getsmsCode{
    NSDictionary *paramtars = @{
                                @"phone":_phoneNumberTextFiled.text,
                                @"token":[[UserManger shareManger] getUserID]
                                };
    [SVProgressHUD showWithStatus:@"正在获取"];
    [MeModelControl getsmsCode:paramtars success:^(GetVocodeModel *vodeModel) {
        [SVProgressHUD showInfoWithStatus:@"获取成功"];
        self->_token = vodeModel.data;
        [[MyTimerManger Sharemanger] startTimerWorkingWithTimeCount:60 resource:NSStringFromClass([self class])];
        [MyTimerManger Sharemanger].myTimerDelegate = self;
        self->_requested = YES;
    } failure:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"获取失败"];
    }];
}
-(void)vertifyVCode{
    if ([_vcodeTF.text isEqualToString:_token]) {
        [self addPhone];
    }else{
        [SVProgressHUD showInfoWithStatus:@"验证码验证失败"];
    }
}
#pragma mark - Action
-(void)addPhone{
    NSDictionary *paramtars = @{
                                @"token":[[UserManger shareManger] getUserID],
                                @"phone":_phoneNumberTextFiled.text
                                };
    [MeModelControl addPhone:paramtars success:^(NSDictionary *dic) {
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}
- (IBAction)actionForGetVcode:(UIButton *)sender {
    if ([Judge judgeStringIsEmpty:_phoneNumberTextFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"手机号不能为空"];
        return;
    }
    [self getsmsCode];
}
- (IBAction)actionForComplete:(UIButton *)sender {
    if ([Judge judgeStringIsEmpty:_phoneNumberTextFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"手机号不能为空"];
        return;
    }
    if ([Judge judgeStringIsEmpty:_vcodeTF.text]) {
        [SVProgressHUD showInfoWithStatus:@"验证码不能为空"];
        return;
    }
    if (!_requested) {
        [SVProgressHUD showInfoWithStatus:@"请获取验证码"];
        return;
    }
    [self vertifyVCode];
}
#pragma mark - MyTimerDelegate
-(void)timerWorkingWithTimeCount:(NSInteger)timeCount{
    _vcodeBtn.userInteractionEnabled = NO;
    [_vcodeBtn setTitle:[NSString stringWithFormat:@"%ldS",timeCount] forState:UIControlStateNormal];
}
-(void)timerComplete{
    _vcodeBtn.userInteractionEnabled = YES;
    [_vcodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
}
@end
