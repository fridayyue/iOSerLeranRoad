//
//  ZFEquipmentDetailController.m
//  antifake
//
//  Created by Zach on 2018/5/7.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "ZFEquipmentDetailController.h"



@interface ZFEquipmentDetailController ()
@property (weak, nonatomic) IBOutlet UITextField *eqNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *shopNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *macLabel;

@end

@implementation ZFEquipmentDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 0.消除间距
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 1.设置NavTitle
    self.navigationItem.title = @"设备详情";

    
    self.eqNameLabel.text = self.model.equipmentName;
    self.shopNameLabel.text = self.model.businessName;
    self.macLabel.text = self.model.sta;
    
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
