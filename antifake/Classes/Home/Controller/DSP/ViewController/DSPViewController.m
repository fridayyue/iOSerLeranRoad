//
//  DSPViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/26.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DSPViewController.h"
#import "DSPModelControl.h"
#import "DSPMACViewController.h"
#import "DSPADCreatViewController.h"
#import "DSPCreatAD2ViewController.h"
#import "DSPManger.h"

@interface DSPViewController ()

@end

@implementation DSPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
}
-(void)dealloc{
    CLog(@"%s",__FUNCTION__);
    [[DSPManger shareManger] destroy];
}
-(void)initView{
    self.title = @"选择投放方式";
}
#pragma mark - NET
-(void)getData{
    NSDictionary *paramtar = @{
                               @"token":[UserManger shareManger].getUserID
                               };
    [DSPModelControl allQualicationState:paramtar success:^(DSPAllQualicationStateModel *allQualicationStateModel) {
        
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - Action
- (IBAction)actionForMAC:(UIButton *)sender {
    DSPMACViewController *macVC = [[DSPMACViewController alloc] init];
    [self.navigationController pushViewController:macVC animated:YES];
//    DSPCreatAD2ViewController *vc = [[DSPCreatAD2ViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)actionForCreatAD:(id)sender {
    DSPADCreatViewController *adCreatVC = [[DSPADCreatViewController alloc] init];
    adCreatVC.viewType = shangquanType;
    [self.navigationController pushViewController:adCreatVC animated:YES];
}
- (IBAction)actionForCreatADD:(UIButton *)sender {
    DSPADCreatViewController *adCreatVC = [[DSPADCreatViewController alloc] init];
    adCreatVC.viewType = macToufangType;
    [self.navigationController pushViewController:adCreatVC animated:YES];
}
@end
