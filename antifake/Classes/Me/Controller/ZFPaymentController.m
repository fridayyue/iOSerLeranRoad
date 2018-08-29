//
//  ZFPaymentController.m
//  antifake
//
//  Created by Zach on 2018/5/7.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "ZFPaymentController.h"

#import "ZFConfig.h"

@interface ZFPaymentController ()
@property (weak, nonatomic) IBOutlet UITextField *moneyAmountTextField;
@property (weak, nonatomic) IBOutlet UIButton *paymentButton;

@end

@implementation ZFPaymentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 0.消除间距
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 1.设置NavTitle
    self.navigationItem.title = @"充值中心";
    
    [self.paymentButton addTarget:self action:@selector(paymentClickAction) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)paymentClickAction
{
    
    /***** 0.初始化参数 *****/
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    
//    // 有Token即可
////    ZFLoginModel *model = [ZFLoginModel unarchiveLoginDataFromSandBox];
//    parameters[@"total_amount"] = self.moneyAmountTextField.text;
//    parameters[@"payType"] = @"pay";
//    parameters[@"token"] = @"5a1fd0a3-894e-4628-aebd-e3fe142701f2";
//    parameters[@"payMode"] = @"ali";
//    
//    // c.请求获取借款金额
//    [[ZFNetTool shareNetTool] POSWithURL:ZFAliURL parameters:parameters success:^(id data) {
//        
//        // a.JSONDict
//        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        
//        ZFLog(@"支付回调======%@", JSON);
//        
//        if (JSON[@"flag"]) {
//            
//            NSString *order = [NSString stringWithFormat:@"%@",JSON[@"data"]];
//            
//            /***** 1.2进行支付宝支付请求 *****/
////            [[ZFConfig sharedManager] payOrder:order
////                                      callback:^(NSDictionary *resultDic) {
////                                          // 判断支付状态
////                                          if ([resultDic[@"resultStatus"] intValue] == 9000) {
////
////                                              [SVProgressHUD dismiss];
////                                              UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"充值成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
////                                              UIAlertAction *resetAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
////
////                                                  [self.navigationController popViewControllerAnimated:YES];
////                                              }];
////
////                                              [alter addAction:resetAction];
////
////                                              [self presentViewController:alter animated:YES completion:nil];
////
////                                          }else{
////
////                                              [SVProgressHUD dismiss];
////
////                                              UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"充值失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
////                                              UIAlertAction *resetAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
////
////                                                  //                        [self.navigationController popViewControllerAnimated:YES];
////                                              }];
////
////                                              [alter addAction:resetAction];
////
////                                              [self presentViewController:alter animated:YES completion:nil];
////                                          }
//                                          ZFLog(@"reslut = %@",resultDic);
//                                          
//                                      }];
//            
//            
//            
//            
//        }else{
//            
//            
//        }
//        
//        
//    } failure:^(NSError *error) {
//        
//        
//        [SVProgressHUD showErrorWithStatus:@"您的网络不给力"];
//        
//    }];
    
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
