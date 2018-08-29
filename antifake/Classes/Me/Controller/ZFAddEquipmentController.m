//
//  ZFAddEquipmentController.m
//  antifake
//
//  Created by Zach on 2018/5/7.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "ZFAddEquipmentController.h"
#import "ZFChoosShopController.h"
#import "ZFShopListModel.h"

@interface ZFAddEquipmentController ()<ZFChooseShopControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *eqNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *shopNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *MACTextField;

@property (nonatomic, copy) NSString *are;
@property (nonatomic, copy) NSString *shopID;
@end

@implementation ZFAddEquipmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置NavTitle
    self.navigationItem.title = @"添加设备";
    
}


//9c:a5:c0:d9:09:0d

- (IBAction)chooseShopClickAction:(id)sender {
    
    ZFChoosShopController *vc = [[ZFChoosShopController alloc] init];
    vc.chooseshopDelegate = self;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (IBAction)addClickAction:(id)sender {
    
    if ([self.eqNameTextField.text isEqualToString:@""]){
        
        [SVProgressHUD showInfoWithStatus:@"请输入设备名称"];
        
        return;
    }
    if ([self.shopNameTextField.text isEqualToString:@""]){
        
        [SVProgressHUD showInfoWithStatus:@"请选择店铺名称"];
        
        return;
    }
    
    if ([self.MACTextField.text isEqualToString:@""]){
        
        [SVProgressHUD showInfoWithStatus:@"请输入MAC地址"];
        
        return;
    }
    
    
    
    /***** 0.初始化参数 *****/
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    // 姓名+密码——>要进行MD5加密
    parameters[@"token"] = [[UserManger shareManger] getUserID];
    parameters[@"businessID"] = self.shopID;
    parameters[@"equipmentName"] = self.eqNameTextField.text;
    parameters[@"loaclArea"] = self.are;
    parameters[@"sta"] = self.MACTextField.text;
    
    
    /***** 1.发送短信请求 *****/
    [[ZFNetTool shareNetTool] POSWithURL:ZFAddEqURL parameters:parameters success:^(id data) {
        
        // a.JSONDict
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        ZFLog(@"添加设备=====%@", JSON);
        
        if (JSON[@"flag"]) {
            
            
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@", JSON[@"msg"]]];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@", JSON[@"msg"]]];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"您的网络不给力"];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    
}


- (void)finishSelectShopWithShopModel:(ZFShopListModel *)model
{
    
    self.shopNameTextField.text = model.businessName;
    self.are = model.bus_site;
    self.shopID = model.id;
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
