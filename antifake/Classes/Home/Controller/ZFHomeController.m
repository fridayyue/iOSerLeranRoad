//
//  ZFHomeController.m
//  antifake
//
//  Created by Zach on 2018/5/6.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "ZFHomeController.h"
#import "ZFFunctionButton.h"
#import "PhoneSaleController.h"

#import "UIBarButtonItem+ZFExtension.h"
#import "ZFHomeDataModel.h"
#import <MJExtension.h>
#import "UpdateModel.h"

#import "ZFMessageSalesController.h"
#import "WXYingXiaoViewController.h"

@interface ZFHomeController ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *functionView;
@property (nonatomic, copy)NSMutableArray *funtionButtons;
@property (nonatomic, copy)NSArray *funtionTitle;
@property (nonatomic, copy)NSArray *funtionImage;

@property (weak, nonatomic) IBOutlet UILabel *totalPeopleAmountLabel;

@property (weak, nonatomic) IBOutlet UILabel *flowPeopleAmountLabel;

@property (weak, nonatomic) IBOutlet UILabel *briefPeopleAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *permanentPeopleAmountLabel;

@property (weak, nonatomic) IBOutlet UILabel *increasePeopleAmountLabel;


@property (weak, nonatomic) IBOutlet UILabel *totalCostAmountLabel;

@property (weak, nonatomic) IBOutlet UILabel *wcCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneFareLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageFareLabel;
@property (weak, nonatomic) IBOutlet UILabel *fmFareLabel;

@end

@implementation ZFHomeController{
    UpdateModel * _updateModel;
}


#pragma mark - Lazy
- (NSArray *)funtionTitle
{
    if (!_funtionTitle) {
        
//        _funtionTitle = [[NSArray alloc]initWithObjects:@"微信营销",@"电话营销",@"短信营销",@"闪信营销",@"DSP营销",@"自定义客户",@"客流统计",@"行业分析",nil];
        _funtionTitle = [[NSArray alloc]initWithObjects:@"微信营销",@"短信营销",@"电话营销",@"DSP营销", @"消费记录", @"闪信营销",nil];
        
    }
    
    return  _funtionTitle;
}


- (NSArray *)funtionImage
{
    if (!_funtionImage) {
        
//        _funtionImage = [[NSArray alloc]initWithObjects:@"weichat",@"phone",@"message",@"shanxin",@"dsp",@"customer",@"analyse",@"analysis",nil];
        _funtionImage = [[NSArray alloc]initWithObjects:@"weichat",@"message",@"phone", @"dsp", @"me_custom", @"shanxin",nil];
        
    }
    
    return _funtionImage;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupFounctionButton];
    [self getHomeData];
    [self getUpdate];
    
}


- (void)setupNav
{
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"福鹿宝";
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_background"] forBarMetrics:UIBarMetricsDefault];
//
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_background"] forBarMetrics:UIBarMetricsDefault];
    
    // 4.设置shadowImage——>去除黑线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"home_message" target:self action:@selector(addClickAciton)];
}

- (void)setupFounctionButton
{
    
    int appCount = 6;
    
    for (int i = 0; i < appCount; i++ ) {
        
        CGFloat buttonW = (ZFScreenW - 40) / 3;
        CGFloat buttonH = 90;
        
        if (i < 3) {
            
            CGFloat buttonX = buttonW * i;
            CGFloat buttonY = 0;
            CGRect rect = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            NSString *title = self.funtionTitle[i];
            NSString *image = self.funtionImage[i];
            
            ZFFunctionButton *button = [[ZFFunctionButton alloc] init];
            button.frame = rect;
            [button setTitle:title forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
            [button setTitleColor:ZFColor(142, 151, 161) forState:UIControlStateNormal];
            [button addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.functionView addSubview:button];
            [self.funtionButtons addObject:button];
            
            
        }else{
            
            CGFloat buttonX = buttonW * (i - 3);
            CGFloat buttonY = buttonH;
            CGRect rect = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            
            
                
                
            NSString *title = self.funtionTitle[i];
            NSString *image = self.funtionImage[i];
            ZFFunctionButton *button = [[ZFFunctionButton alloc] init];
            button.frame = rect;
            [button setTitle:title forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
            [button setTitleColor:ZFColor(142, 151, 161) forState:UIControlStateNormal];
            [button addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.functionView addSubview:button];
            [self.funtionButtons addObject:button];
                
            
            
            
            
        }
        
    }
    
}


- (void)functionButtonClick:(ZFFunctionButton *)button
{
    NSString *functionName = [button currentTitle];
    if ([functionName isEqualToString:@"电话营销"]) {
        
        PhoneSaleController *vc =[[PhoneSaleController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([functionName isEqualToString:@"短信营销"]) {
        
        ZFMessageSalesController *vc =[[ZFMessageSalesController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([functionName isEqualToString:@"闪信营销"]){
        
        ZFMessageSalesController *vc =[[ZFMessageSalesController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([functionName isEqualToString:@"微信营销"]){
//        WXYingXiaoViewController *wxyingxiaoVC = [[WXYingXiaoViewController alloc] init];
//        [self.navigationController pushViewController:wxyingxiaoVC animated:YES];
    }
    
}
#pragma mark - Net
-(void)getUpdate{
    /***** 0.初始化参数 *****/
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    // 姓名+密码——>要进行MD5加密
    parameters[@"token"] = [[UserManger shareManger] getUserID];
    
    
    
    /***** 1.登录请求 *****/
    [[ZFNetTool shareNetTool] POSWithURL:@"app/appVersionsIos" parameters:parameters success:^(id data) {
        
        // a.JSONDict
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self->_updateModel = [[UpdateModel alloc] initWithDictionary:[JSON objectForKey:@"data"] error:nil];
         NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey];
        if ([build integerValue] < [self->_updateModel.IOSVersionCode integerValue]) {
            [self alertUpdate];
        }
        ZFLog(@"更新成功====%@=======",self->_updateModel);
        
    } failure:^(NSError *error) {
        
        ZFLog(@"更新失败了兄弟==================");
        [SVProgressHUD showErrorWithStatus:@"您的网络不给力"];
        
    }];
}
-(void)alertUpdate{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"发现新版本是否去更新" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_updateModel.IOSDownLoadUrl]];
    }
}
- (void)getHomeData
{
    
    ZFWeakSelf;
//    [SVProgressHUD showWithStatus:@"正在登录"];
    /***** 0.初始化参数 *****/
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    // 姓名+密码——>要进行MD5加密
    parameters[@"token"] = [[UserManger shareManger] getUserID];
    parameters[@"sta"] = [Help getDeviceIDFA];
    CLog(@"HomeParamtar:%@",parameters);
    CLog(@"Home:%@",ZFHomeDataURL);
    
    /***** 1.登录请求 *****/
    [[ZFNetTool shareNetTool] POSWithURL:ZFHomeDataURL parameters:parameters success:^(id data) {
        
        
        
        // a.JSONDict
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        ZFLog(@"成功====%@=======",JSON);
        ZFHomeDataModel *homeModel = [ZFHomeDataModel mj_objectWithKeyValues:JSON[@"data"]];
        [weakSelf setupData:homeModel];
        
       
        
        
    } failure:^(NSError *error) {
        
        ZFLog(@"失败了兄弟==================");
        [SVProgressHUD showErrorWithStatus:@"您的网络不给力"];
        
    }];

    
}

- (void)addClickAciton{
    
    
    
}


- (void)setupData:(ZFHomeDataModel *)homeModel
{
    
    self.totalPeopleAmountLabel.text = homeModel.tdPopulation;
    self.flowPeopleAmountLabel.text = homeModel.flowNum;
    self.briefPeopleAmountLabel.text = homeModel.persistanceNum;
    self.permanentPeopleAmountLabel.text = homeModel.residentNum;
    self.increasePeopleAmountLabel.text = homeModel.nowAddNum;
    
    self.totalCostAmountLabel.text = homeModel.tdTotalCost;
    self.wcCostLabel.text = homeModel.wxTotalCost;
    self.phoneFareLabel.text = homeModel.dhTotalCost;
    self.messageFareLabel.text = homeModel.dxTotalCost;
    self.fmFareLabel.text = homeModel.sxTotalCost;
    
    
    
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
