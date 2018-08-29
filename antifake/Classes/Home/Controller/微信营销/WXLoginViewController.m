//
//  WXLoginViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/14.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "WXLoginViewController.h"
#import "WXYingXiaoManger.h"
#import "WXCreatADViewController.h"
#import "WXMakeDetailViewController.h"

@interface WXLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIButton *yesBtn;
@property (weak, nonatomic) IBOutlet UIButton *noBtn;

@end

@implementation WXLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)dealloc{
    CLog(@"%s",__FUNCTION__);
   [[WXYingXiaoManger shareManger] destroy];
}
-(void)initView{
    self.title = @"公众号登录";
    [_accountTF becomeFirstResponder];
}
#pragma mark - Action
- (IBAction)actionForYes:(id)sender {
    _yesBtn.selected = YES;
    _noBtn.selected = NO;
}
- (IBAction)actionForNo:(id)sender {
    _yesBtn.selected = NO;
    _noBtn.selected = YES;
}
- (IBAction)actionForNext:(UIButton *)sender {
    if ([self check]) {
        WXCreatADViewController *creatADVC = [[WXCreatADViewController alloc] init];
        [self.navigationController pushViewController:creatADVC animated:YES];
//        WXMakeDetailViewController *uploadVC = [[WXMakeDetailViewController alloc] init];
//        [self.navigationController pushViewController:uploadVC animated:YES];
    }
}
#pragma mark - Check
-(BOOL)check{
    if ([Judge judgeStringIsEmpty:_accountTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入公众号账号"];
        return NO;
    }
    if ([Judge judgeStringIsEmpty:_pwdTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入公众号密码"];
        return NO;
    }
    if (!_yesBtn.selected && !_noBtn.selected) {
        [SVProgressHUD showErrorWithStatus:@"请选择是否是广告主"];
        return NO;
    }
    if (_noBtn.selected) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"注意" message:@"您的公众号还未开通广告主功能,请去微信公众平台上传相关信息。" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        return NO;
    }
    [WXYingXiaoManger shareManger].gzhName = _accountTF.text;
    [WXYingXiaoManger shareManger].gzhPwd = _pwdTF.text;
    return YES;
}
@end
