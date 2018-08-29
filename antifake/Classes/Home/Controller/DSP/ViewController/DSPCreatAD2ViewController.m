//
//  DSPCreatAD2ViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/7/2.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DSPCreatAD2ViewController.h"
#import "DSPCreatAD3ViewController.h"
#import "DSPModelControl.h"
#import "XTTimeDateManger.h"
#import "DSPManger.h"
#import "UIAlertView+Block.h"

@interface DSPCreatAD2ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *adUrlTF;
@property (weak, nonatomic) IBOutlet UITextField *yusuanTF;
@property (weak, nonatomic) IBOutlet UILabel *cisghuLB;
@property (weak, nonatomic) IBOutlet UITextField *adNameTF;
@property (weak, nonatomic) IBOutlet UILabel *shangchuanLB;

@end

@implementation DSPCreatAD2ViewController{
    BOOL _isUpload;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)initView{
    self.title = @"创建广告";
}
#pragma mark - Net
-(void)dspMake{
    NSDictionary *paramtar = @{
                               @"exposureCount":_cisghuLB.text?_cisghuLB.text:@"",
                               @"orderno":[XTTimeDateManger currentTimeStr]?[XTTimeDateManger currentTimeStr]:@"",
                               @"distance":[DSPManger shareManger].distance?[DSPManger shareManger].distance:@"",
                               @"total_budget":_yusuanTF.text?_yusuanTF.text:@"",
                               @"put_endtime":[DSPManger shareManger].put_endtime?[DSPManger shareManger].put_endtime:@"",
                               @"media":[DSPManger shareManger].media?[DSPManger shareManger].media:@"",
                               @"holiday":@"",
                               @"time_interval":[DSPManger shareManger].time_interval?[DSPManger shareManger].time_interval:@"",
                               @"mac":[DSPManger shareManger].mac?[DSPManger shareManger].mac:@"",
                               @"speed":@"",
                               @"adv_id":[DSPManger shareManger].adv_id?[DSPManger shareManger].adv_id:@"",
                               @"id":@"",
                               @"media_name":[DSPManger shareManger].media_name?[DSPManger shareManger].media_name:@"",
                               @"advertisement_link":_adUrlTF.text?_adUrlTF.text:@"",
                               @"day_budget":@"0.0",
                               @"deviceType":[DSPManger shareManger].advPlace?[DSPManger shareManger].advPlace:@"",
                               @"person_num":@"",
                               @"custom_price":[DSPManger shareManger].custom_price?[DSPManger shareManger].custom_price:@"",
                               @"sex":[DSPManger shareManger].sex?[DSPManger shareManger].sex:@"",
                               @"billingMethods":@"CPM",
                               @"fileFlag":_isUpload?@"1":@"0",
                               @"put_area":[DSPManger shareManger].put_area?[DSPManger shareManger].put_area:@"",
                               @"advertisement_name":_adNameTF.text?_adNameTF.text:@"",
                               @"token":[UserManger shareManger].getUserID?[UserManger shareManger].getUserID:@"",
                               @"AdContent":[DSPManger shareManger].AdContent?[DSPManger shareManger].AdContent:@"",
                               @"deepLink":@"",
                               @"user_id":@"",
                               @"put_starttime":[DSPManger shareManger].put_starttime?[DSPManger shareManger].put_starttime:@"",
                               @"age":[DSPManger shareManger].age?[DSPManger shareManger].age:@""
                               };
    [DSPModelControl dspMarket:paramtar success:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg];
        double delayInSeconds = 1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    } failure:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg];
    }];
}
- (IBAction)actionForSuCai:(UIButton *)sender {
    DSPCreatAD3ViewController *ad3VC = [[DSPCreatAD3ViewController alloc] init];
    ad3VC.updateBlock = ^(BOOL isUpDate) {
        _isUpload = isUpDate;
        _shangchuanLB.text = isUpDate?@"已上传":@"未上传";
    };
    [self.navigationController pushViewController:ad3VC animated:YES];
}
- (IBAction)yusuanTFChanged:(id)sender {
    _cisghuLB.text = [NSString stringWithFormat:@"%ld",(NSInteger)([_yusuanTF.text floatValue]/1.0 * 60)];
}
- (IBAction)actionForTiJiao:(UIButton *)sender {
    [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
        if(buttonIndex == 1){
            [self dspMake];
        }
    } title:@"注意" message:@"确定要提交吗？" cancelButtonName:@"取消" otherButtonTitles:@"确定", nil];
    
}
@end
