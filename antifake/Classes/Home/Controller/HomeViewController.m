//
//  HomeViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/13.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginModelControl.h"
#import "HomeModelControl.h"
#import "AppDelegate.h"

#import "WXLoginViewController.h"
#import "DXViewController.h"
#import "NSString+CustomString.h"
#import "BillViewController.h"
#import "DSPViewController.h"

@interface HomeViewController ()
<
    UIAlertViewDelegate
>
@property (weak, nonatomic) IBOutlet UILabel *tdPopulationLabel;
@property (weak, nonatomic) IBOutlet UILabel *flowNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *persistanceNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *residentNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *tdTotalCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *wxTotalCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *dhTotalCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *dxTotalCost;
@property (weak, nonatomic) IBOutlet UILabel *sxTotalCost;

@end

@implementation HomeViewController{
    HomeDataModel *_homeDataModel;
    UpdateModel *_updateModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self postAndLogin];
    [self updateAPP];
}
-(void)initView{
    self.title = @"福鹿宝";
}
-(void)confiHomeData{
    _tdPopulationLabel.text = _homeDataModel.tdPopulation;
    _flowNumLabel.text = _homeDataModel.flowNum;
    _persistanceNumLabel.text = _homeDataModel.persistanceNum;
    _residentNumLabel.text = _homeDataModel.residentNum;
    _tdTotalCostLabel.text = [NSString floatFormatterString:_homeDataModel.tdTotalCost];
    _wxTotalCostLabel.text = [NSString floatFormatterString:_homeDataModel.cxTotalCost];
    _dhTotalCostLabel.text = [NSString floatFormatterString:_homeDataModel.dhTotalCost];
    _dxTotalCost.text = [NSString floatFormatterString:_homeDataModel.dxTotalCost];
    _sxTotalCost.text = [NSString floatFormatterString:_homeDataModel.sxTotalCost];
}
-(void)makeUpdateView{
    NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey];
    if ([build integerValue] < [_updateModel.IOSVersionCode integerValue]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"发现新版本是否去更新" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
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
        [self getHomeData];
    } failure:^(NSError *error) {
        if ([[error.userInfo allKeys] containsObject:@"message"]) {
            [SVProgressHUD showInfoWithStatus:[error.userInfo objectForKey:@"message"]];
            [[UserManger shareManger] userLogout];
        }
    }];
}
-(void)getHomeData{
    NSDictionary *data = @{
                           @"sta":[Help getDeviceIDFA],
                           @"token":[[UserManger shareManger] getUserID]
                           };
    [HomeModelControl getHomeData:data success:^(HomeDataModel *homeDataModel) {
        self->_homeDataModel = homeDataModel;
        [self confiHomeData];
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - Action
- (IBAction)actionForWeChat:(UIButton *)sender {
    WXLoginViewController *wxyingxiaoVC = [[WXLoginViewController alloc] init];
    [self.navigationController pushViewController:wxyingxiaoVC animated:YES];
}
- (IBAction)actionForDX:(id)sender {
    DXViewController *vc =[[DXViewController alloc] init];
    vc.viewType = duxninType;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)actionForDH:(id)sender {
    AppDelegate *delegate = ShareAppDelegate;
    delegate.rootTabbar.selectedIndex = 1;
}
- (IBAction)actionForDSP:(id)sender {
    DSPViewController *dspVC = [[DSPViewController alloc] init];
    [self.navigationController pushViewController:dspVC animated:YES];
}
- (IBAction)actionForBill:(id)sender {
    BillViewController *billVC = [[BillViewController alloc] init];
    [self.navigationController pushViewController:billVC animated:YES];
}
- (IBAction)actionForSX:(id)sender {
    DXViewController *vc =[[DXViewController alloc] init];
    vc.viewType = shanxinType;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - AlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_updateModel.IOSDownLoadUrl]];
    }
}
@end
