//
//  DataCenter_ViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/24.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DataCenter_ViewController.h"
#import "HomeModelControl.h"
#import "NSString+CustomString.h"
#import "MAcListVCViewController.h"

#define defaultHeight       200

@interface DataCenter_ViewController (){
    HomeDataModel *_homeDataModel;
    NSArray *_macList;
}
@property (weak, nonatomic) IBOutlet UILabel *wxTotalCostLB;
@property (weak, nonatomic) IBOutlet UILabel *dhTotalCostLB;
@property (weak, nonatomic) IBOutlet UILabel *dxTotalCostLB;
@property (weak, nonatomic) IBOutlet UILabel *sxTotalCostLB;
@property (weak, nonatomic) IBOutlet UILabel *dspTotalCostLB;
@property (weak, nonatomic) IBOutlet UILabel *totalLB;
@property (weak, nonatomic) IBOutlet UILabel *monthLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wxHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dhHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dxHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sxHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dspHeight;//200
@property (weak, nonatomic) IBOutlet UILabel *tdPopulationLB;
@property (weak, nonatomic) IBOutlet UILabel *equipmentNumLB;
@property (weak, nonatomic) IBOutlet UILabel *customCountLB;
@property (weak, nonatomic) IBOutlet UILabel *coustomGroupNumLB;

@end

@implementation DataCenter_ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getHomeData];
    [self getMACList];
}
-(void)initView{
    self.title = @"数据中心";
    [self makeRightNavBtnTitle:@"设备"];
}
-(void)confiHomeData{
    _wxTotalCostLB.text = [NSString floatFormatterString:_homeDataModel.wxTotalCost];
    _dhTotalCostLB.text = [NSString floatFormatterString:_homeDataModel.dhTotalCost];
    _dxTotalCostLB.text = [NSString floatFormatterString:_homeDataModel.dxTotalCost];
    _sxTotalCostLB.text = [NSString floatFormatterString:_homeDataModel.sxTotalCost];
    _dspTotalCostLB.text = [NSString floatFormatterString:_homeDataModel.dspTotalCost];
    CGFloat total = _homeDataModel.wxTotalCost+_homeDataModel.dhTotalCost+_homeDataModel.dxTotalCost+_homeDataModel.sxTotalCost+_homeDataModel.dspTotalCost;
    _totalLB.text = [NSString floatFormatterString:total];
    
    NSDate *date =[NSDate date];//简书 FlyElephant
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM"];
    NSInteger currentMonth=[[formatter stringFromDate:date]integerValue];
    _monthLB.text = [NSString stringWithFormat:@"%02ld月",(long)currentMonth];
    
    _wxHeight.constant = _homeDataModel.wxTotalCost/total * defaultHeight;
    _dhHeight.constant = _homeDataModel.dhTotalCost/total * defaultHeight;
    _dxHeight.constant = _homeDataModel.dxTotalCost/total * defaultHeight;
    _sxHeight.constant = _homeDataModel.sxTotalCost/total * defaultHeight;
    _dspHeight.constant = _homeDataModel.dspTotalCost/total * defaultHeight;
    
    _tdPopulationLB.text = _homeDataModel.tdPopulation;
    _equipmentNumLB.text = [NSString stringWithFormat:@"%@个设备",_homeDataModel.equipmentNum];
    _customCountLB.text = [NSString stringWithFormat:@"%@",_homeDataModel.customCount];
    _coustomGroupNumLB.text = [NSString stringWithFormat:@"%@个文件夹",_homeDataModel.coustomGroupNum];
}
#pragma mark - Action
-(void)actionForRightBtn:(id)sender{
    if (_macList.count <= 0) {
        return;
    }
    MAcListVCViewController *macListVC = [[MAcListVCViewController alloc] init];
    macListVC.macList = _macList;
    [self.navigationController pushViewController:macListVC animated:YES];
}
#pragma mark - Net
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
-(void)getMACList{
    [HomeModelControl gethMaodieList:@{@"token":[UserManger shareManger].getUserID} success:^(NSArray *list) {
        _macList = list.copy;
       
    } failure:^(NSError *error) {
        
    }];
}
@end
