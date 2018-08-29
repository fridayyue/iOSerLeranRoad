//
//  ZFLoginViewController.m
//  happymoney
//
//  Created by Zach on 2017/10/10.
//  Copyright © 2017年 AW. All rights reserved.
//


#import "ZFLoginViewController.h"
#import "ZFTabBarController.h"
#import "RegisterViewController.h"
#import "AppDelegate.h"
//#import "ZFForgetPasswordController.h"


#import "ZFLoginTextField.h"
//#import "NSString+ZFExtension.h"

#import <MJExtension.h>
//#import "ZFLoginModel.h"
#import "LoginModelControl.h"
#import "FogetPwdViewController.h"

#define kLK_HTTP_CLIENT_CONVERT_KEY                         @"data"
#define kLK_HTTP_CLIENT_TICKET_KEY                          @"ticket"
#define kLK_HTTP_CLIENT_SIGNATURE_KEY                       @"signature"




@interface ZFLoginViewController ()
<
    UITextFieldDelegate,
    UINavigationControllerDelegate
>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@end

@implementation ZFLoginViewController



#pragma mark - Life
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTextField];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.delegate = self;
}
#pragma mark - Delegate
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
//    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
//}
- (void)setupTextField
{

    self.phoneNumberTextField.delegate = self;
    self.passwordTextField.delegate = self;
    [_phoneNumberTextField becomeFirstResponder];
    _phoneNumberTextField.text = [[UserManger shareManger] getUserPhone];
    
}
#pragma mark - ClickAction
/******************* 登录 *******************/
- (IBAction)loginActionClick:(id)sender {
    NSString *phoneNumber = self.phoneNumberTextField.text;
    NSString *password = self.passwordTextField.text;
    if (![Judge judgePhoneNumber:phoneNumber]) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号"];
        return;
    }else if (![Judge judgePWD:password]){
        [SVProgressHUD showInfoWithStatus:@"请输入正确的密码"];
        return;
    }
    [self postAndLogin];
}
/******************* post数据登录 *******************/
- (void)postAndLogin
{
    [SVProgressHUD showWithStatus:@"正在登录"];
    NSDictionary *paratmtar = @{
                                @"user_code":self.phoneNumberTextField.text,
                                @"password":[Help MD5ForUpper32Bate:self.passwordTextField.text]
                                
                                };
    [LoginModelControl loginWith:paratmtar success:^(LoginModel *loginModel) {
        [SVProgressHUD showInfoWithStatus:@"登录成功"];
        [self.navigationController popViewControllerAnimated:YES];
        [self pushToVC];
        CLog(@"%@",loginModel);
    } failure:^(NSError *error) {
        if ([[error.userInfo allKeys] containsObject:@"message"]) {
            [SVProgressHUD showInfoWithStatus:[error.userInfo objectForKey:@"message"]];
        }
    }];
}
- (void)pushToVC
{
    AppDelegate *delegate = ShareAppDelegate;
    [delegate changeToTableRootVC];
}
/******************* 忘记密码 *******************/
- (IBAction)forgetPasswordActionClick:(id)sender {
    FogetPwdViewController *fogetPWDVC = [[FogetPwdViewController alloc] init];
    [self.navigationController pushViewController:fogetPWDVC animated:YES];
}
/******************* 注册 *******************/
- (IBAction)RegisteActionClick:(id)sender {
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
//


}
#pragma mark - TextFieldSetting
/******************* return键盘收起 *******************/
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    [self keyboardBackWithView];
    return YES;
}
/******************* 收起键盘 *******************/
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [self keyboardBackWithView];
}
/******************* 键盘收起时View回弹 *******************/
- (void)keyboardBackWithView
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, ZFNAVIGATION_BAR_HEIGHT, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
}
#pragma mark - UITextFieldDelegate
/******************* 开始输入 *******************/
//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    CGRect frame = textField.frame;
//    CGFloat heights = self.view.frame.size.height;
//    // 当前点击textfield的坐标的Y值 + 当前点击textFiled的高度 - （屏幕高度- 键盘高度 - 键盘上tabbar高度）
//    // 在这一部 就是了一个 当前textfile的的最大Y值 和 键盘的最全高度的差值，用来计算整个view的偏移量
//    int offset = 205 + frame.origin.y + 42 - ( heights - 216.0);//键盘高度216
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    float width = self.view.frame.size.width;
//    float height = self.view.frame.size.height;
//    if(offset > 0)
//    {
//        CGRect rect = CGRectMake(0.0f, -offset,width,height);
//        self.view.frame = rect;
//    }
//    [UIView commitAnimations];
//}
@end
