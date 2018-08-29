//
//  ZFShopDetailController.m
//  antifake
//
//  Created by Zach on 2018/5/7.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "ZFShopDetailController.h"

#import "ZFShopListModel.h"

@interface ZFShopDetailController ()

@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *managerLabel;

@property (weak, nonatomic) IBOutlet UILabel *IDCardLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *businessLabel;

@property (weak, nonatomic) IBOutlet UILabel *businessIDLabel;


@end

@implementation ZFShopDetailController

- (void)viewDidLoad { 
    [super viewDidLoad];
    
    // 0.消除间距
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 1.设置NavTitle
    self.navigationItem.title = @"店铺详情";
    
    self.shopNameLabel.text = self.model.businessName;
    
    self.placeLabel.text = self.model.bus_site;
    
    self.managerLabel.text = self.model.managerName;
    
//    self.model.bus_idCard
    self.IDCardLabel.text = self.model.bus_idCard;
    
    self.phoneLabel.text = self.model.bus_phone;
    
    self.businessLabel.text = self.model.industry;
    
    self.businessIDLabel.text = self.model.bus_license_number;
    
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
