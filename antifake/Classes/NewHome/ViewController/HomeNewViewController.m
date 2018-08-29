//
//  HomeNewViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/29.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "HomeNewViewController.h"
#import "HomeNewView.h"
#import "AppDelegate.h"
#import "WXLoginViewController.h"
#import "DXViewController.h"
#import "DSPViewController.h"
#import "HomeModelControl.h"
#import "LoginModelControl.h"
@interface HomeNewViewController ()
@property (strong, nonatomic) IBOutlet HomeNewView *homeView;

@end

@implementation HomeNewViewController{
    UpdateModel *_updateModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateAPP];
    [self postAndLogin];
}
-(void)initView{
    self.title = @"福鹿宝";
    [_homeView initView];
}
-(void)makeUpdateView{
    NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey];
    if ([build integerValue] < [_updateModel.IOSVersionCode integerValue]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"发现新版本是否去更新" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}
#pragma mark - Action

- (IBAction)actionForDianhua:(UIButton *)sender {
    AppDelegate *delegate = ShareAppDelegate;
    delegate.rootTabbar.selectedIndex = 1;
}
- (IBAction)actionForDuanxin:(id)sender {
    DXViewController *vc =[[DXViewController alloc] init];
    vc.viewType = duxninType;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)actioNForDSP:(id)sender {
    DSPViewController *dspVC = [[DSPViewController alloc] init];
    [self.navigationController pushViewController:dspVC animated:YES];
}
- (IBAction)actionForSanxin:(id)sender {
    DXViewController *vc =[[DXViewController alloc] init];
    vc.viewType = shanxinType;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)actionForWeixin:(id)sender {
    WXLoginViewController *wxyingxiaoVC = [[WXLoginViewController alloc] init];
    [self.navigationController pushViewController:wxyingxiaoVC animated:YES];
}
#pragma mark - Net
-(void)updateAPP{
    NSDictionary *data = @{
                           @"token":[[UserManger shareManger] getUserID]
                           };
    [HomeModelControl getUpdatInfo:data success:^(UpdateModel *updateModel) {
        self->_updateModel = updateModel;
        [self makeUpdateView];
    } failure:^(NSError *error) {
        
    }];
}
- (void)postAndLogin
{
    NSDictionary *paratmtar = @{
                                @"user_code":[[UserManger shareManger] getUserPhone],
                                @"password":[UserManger shareManger].password
                                };
    [LoginModelControl loginWith:paratmtar success:^(LoginModel *loginModel) {
        
    } failure:^(NSError *error) {
        if ([[error.userInfo allKeys] containsObject:@"message"]) {
            [SVProgressHUD showInfoWithStatus:[error.userInfo objectForKey:@"message"]];
            [[UserManger shareManger] userLogout];
        }
    }];
}
@end
