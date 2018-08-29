//
//  JingZhunDetailViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/12.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "JingZhunDetailViewController.h"
#import "DataCenterModelControl.h"
#import "UIAlertView+Block.h"
#import "AddPhoneViewController.h"

@interface JingZhunDetailViewController ()
<
    UIAlertViewDelegate
>
@property (weak, nonatomic) IBOutlet UIImageView *heardImage;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *yixiangLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *consumptionLevelLabel;

@end

@implementation JingZhunDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDetailData];
}
-(void)initView{
    if ([_centerModel.sex isEqualToString:@"男"]) {
        [self.heardImage setImage:[UIImage imageNamed:@"DataCenter_mail.png"]];
    }else if ([_centerModel.sex isEqualToString:@"女"]){
        [self.heardImage setImage:[UIImage imageNamed:@"DataCenter_filmail.png"]];
    }else{
        [self.heardImage setImage:[UIImage imageNamed:@"DataCenter_NoSex.png"]];
    }
    self.sexLabel.text = _centerModel.sex;
    self.ageLabel.text = _centerModel.age;
    self.areaLabel.text = _centerModel.place;
    self.consumptionLevelLabel.text = _centerModel.consumptionLevel;
    self.phoneNumberLabel.text = [Help phoneNumberSecret:_centerModel.phoneNumber];
}
#pragma mark - Net
-(void)getDetailData{
    NSDictionary *paramtar = @{
                               @"phone":[Judge judgeStringIsEmpty:_centerModel.phoneNumber]?@"":_centerModel.phoneNumber,
                               @"token":[[UserManger shareManger] getUserID]
                               };
    [DataCenterModelControl getPhoneProvide:paramtar success:^(DataCenterJingzhunDetailModel *dataModel) {
        
    } faiure:^(NSError *error) {
        
    }];
}
#pragma mark - Action
- (IBAction)actionForKeHuYiXiang:(UIButton *)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标记" message:@"请为该客户标记意向需求？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"有意向",@"无意向", nil];
    alertView.tag = 100;
    [alertView show];
}
- (IBAction)actionForCall:(UIButton *)sender {
    if ([Judge judgeStringIsEmpty:[UserManger shareManger].morenPhone]) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                AddPhoneViewController *addVc = [[AddPhoneViewController alloc] init];
                [self.navigationController pushViewController:addVc animated:YES];
            }
        } title:@"" message:@"尚未设置默认手机号，是否去设置?" cancelButtonName:@"取消" otherButtonTitles:@"去设置", nil];
        return;
    }
    NSDictionary *paramtar = @{
                               @"anum":[UserManger shareManger].morenPhone,
                               @"tm":_centerModel.phoneNumber,
                               @"token":[UserManger shareManger].getUserID
                               };
    [DataCenterModelControl getCallDeta:paramtar success:^(NSString *phone) {
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]]];
    } faiure:^(NSError *error) {
        
    }];
   
}
#pragma mark - AlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {
            _yixiangLabel.text = @"有意向";
        }else if(buttonIndex == 2){
            _yixiangLabel.text = @"无意向";
        }
    }
}
@end
