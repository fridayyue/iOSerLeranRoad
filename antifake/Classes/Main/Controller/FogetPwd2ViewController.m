//
//  FogetPwd2ViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/5/31.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "FogetPwd2ViewController.h"
#import "LoginModelControl.h"

@interface FogetPwd2ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *pwdTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *pwd2TextFiled;

@end

@implementation FogetPwd2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)initView{
    self.title = @"忘记密码";
    [_pwdTextFiled becomeFirstResponder];
}
#pragma mark - Action
- (IBAction)actionForSure:(id)sender {
    if ([Judge judgeStringIsEmpty:_pwdTextFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"密码不可为空"];
        return;
    }
    if ([Judge judgePhoneNumber:_pwdTextFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"密码格式不正确"];
        return;
    }
    if (![_pwdTextFiled.text isEqualToString:_pwd2TextFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"两次输入的密码不一致"];
        return;
    }
    [self resetpwd];
}
#pragma mark - Net
-(void)resetpwd{
    NSDictionary *paramtar = @{
                               @"token":_token,
                               @"password":_pwdTextFiled.text,
                               @"verification_code":_verification_code
                               };
    [SVProgressHUD showWithStatus:@""];
    [LoginModelControl fogetLoginPwd:paramtar success:^{
        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
        double delayInSeconds = 1.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"修改失败"];
    }];
}
@end
