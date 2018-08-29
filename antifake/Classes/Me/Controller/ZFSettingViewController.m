//
//  ZFSettingViewController.m
//  antifake
//
//  Created by Zach on 2018/5/7.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "ZFSettingViewController.h"
#import "AddPhoneViewController.h"

@interface ZFSettingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;

@end

@implementation ZFSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _phoneNumber.text = [Judge judgeStringIsEmpty:[UserManger shareManger].morenPhone] ? @"请设置默认手机号" : [UserManger shareManger].morenPhone;
}
#pragma mark - MakeView
-(void)initView{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    _versionLabel.text = [NSString stringWithFormat:@"V%@",app_Version];
    // 0.消除间距
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // 1.设置NavTitle
    self.navigationItem.title = @"设置";

}
- (IBAction)actionForLogOut:(id)sender {
    [[UserManger shareManger] userLogout];
}
- (IBAction)actionForPhone:(UIButton *)sender {
    AddPhoneViewController *addPhoneVC = [[AddPhoneViewController alloc] init];
    [self.navigationController pushViewController:addPhoneVC animated:YES];
}


@end
