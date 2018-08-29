//
//  ZFMeViewController.m
//  antifake
//
//  Created by Zach on 2018/5/7.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "ZFMeViewController.h"
#import "ZFPaymentController.h"
#import "ZFShopListController.h"
#import "ZFEquipmentListController.h"
#import "ZFFareRecordController.h"
#import "ZFBankListController.h"
#import "ZFSettingViewController.h"

#import <MJExtension.h>
#import "ZFSettingDataModel.h"

#import "ZFMeHeaderView.h"
#import "ZFMeListCell.h"

#import "ZFMeUserInfoModel.h"
#import "ZFShopListModel.h"

@interface ZFMeViewController ()<UITableViewDelegate,UITableViewDataSource>


/**< tableView */
@property (nonatomic, weak) UITableView *tableView;

/**< headerView */
@property (nonatomic, weak) ZFMeHeaderView *headerView;

/**< 模型数组 */
@property (nonatomic, copy) NSArray *modelArray;

/**< 模型数组 */
@property (nonatomic, copy) NSArray *array;

/**< 账户余额 */
//@property (nonatomic, copy) ZFMeHeaderView *headerView;

@end

@implementation ZFMeViewController

/**< cell的循环利用标识 */
static NSString *ZFMeListCellID = @"ZFMeListCell";

#pragma mark - Life

/******************* 程序加载入口 *******************/

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.初始化Nav
    [self setupNav];
    // 2.初始化tableView
    [self setupTableView];
    // 3.初始化TableView数据
    [self setupTableViewData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupMeUserInfoData];
    [self setupShopNumberData];
}

#pragma mark - Private

/******************* 设置nav *******************/
- (void)setupNav
{
    // 0.消除间距
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // 1.设置NavTitle
    self.navigationItem.title = @"我的";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_background"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
/******************* 初始化TableView *******************/
- (void)setupTableView
{
    // 0.初始化
    UITableView *tableView = [[UITableView alloc] init];
    // a.frame
    tableView.frame = CGRectMake(0, 0, ZFScreenW, ZFScreenH - ZFNAVIGATION_BAR_HEIGHT - ZFTAB_BAR_HEIGHT);
    // b.去除分割线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    // c.强引用
    self.tableView = tableView;
    // d.添加到View
    [self.view addSubview:tableView];
    
    
    // 1.设置数据源和代理
    tableView.delegate = self;
    tableView.dataSource = self;
    
    
    // 2.注册cell
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZFMeListCell class]) bundle:nil] forCellReuseIdentifier:ZFMeListCellID];
    
    
    // 3.初始化headerView
    // a.从xib中进行加载
    ZFMeHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZFMeHeaderView class]) owner:nil options:nil].lastObject;
    self.headerView = headerView;
    // b.设置frame
    CGFloat herdViewHeight = ZFScreenW * 774/1242 + 44;
    headerView.frame = CGRectMake(0, 0, ZFScreenW, herdViewHeight);
    // c.设置为headerView
    tableView.tableHeaderView = headerView;
    
    // 4.添加headerView的点击事件
    // a.登录点击
    [headerView.rechargeButton addTarget:self action:@selector(rechargeClickAction) forControlEvents:UIControlEventTouchUpInside];
  
    // b.用户信息点击
//    [headerView.userInfoButton addTarget:self action:@selector(userInfoActionClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
}


/******************* 初始化TableViewData *******************/
- (void)setupTableViewData
{
    
    self.modelArray = [ZFSettingDataModel mj_objectArrayWithFilename:@"ZFMeData.plist"];
}



/******************* 初始化MeData *******************/
- (void)setupMeUserInfoData
{
    
    /************ 获取所有金额数量 ************/
    
    // a.初始化请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"token"] = [[UserManger shareManger] getUserID];
    
    
    ZFWeakSelf;
    
    // c.请求获取借款金额
    [[ZFNetTool shareNetTool] POSWithURL:ZFMeDataURL parameters:parameters success:^(id data) {
        // a.JSONDict
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (JSON[@"flag"]) {
            ZFMeUserInfoModel *userModel = [ZFMeUserInfoModel mj_objectWithKeyValues:JSON[@"data"]];
            weakSelf.headerView.moneyLabel.text = [NSString stringWithFormat:@"¥%.2lf",[userModel.transaction_amount floatValue]];
            weakSelf.headerView.phoneLabel.text = [Help phoneNumberSecret:userModel.phone];
//            weakSelf.headerView.phoneLabel.text = userModel.phone;
            weakSelf.headerView.nameLabel.text = userModel.name;
            
        }else{

        }
        

        
        
    } failure:^(NSError *error) {
        
        
        [SVProgressHUD showErrorWithStatus:@"您的网络不给力"];
        
    }];
    
}

/******************* 初始化TableViewData *******************/
- (void)setupShopNumberData
{
    
    /************ 获取所有金额数量 ************/
    
    // a.初始化请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"token"] = [[UserManger shareManger] getUserID];
    
    
    ZFWeakSelf;
    
    // c.请求获取借款金额
    [[ZFNetTool shareNetTool] POSWithURL:ZFShopListURL parameters:parameters success:^(id data) {
        
        // a.JSONDict
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
   
        if (JSON[@"flag"]) {
        
            NSArray *modelArray = [ZFShopListModel mj_objectArrayWithKeyValuesArray:JSON[@"data"]];
            self.array = modelArray;
            [weakSelf.tableView reloadData];
            
        }else{
        
        
        }

        
    } failure:^(NSError *error) {
        
        
        [SVProgressHUD showErrorWithStatus:@"您的网络不给力"];
        
    }];
    
    
}


- (void)rechargeClickAction
{
    
    ZFPaymentController *vc = [[ZFPaymentController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}



#pragma  mark - UItableViewDataSource

/******************* section数量 *******************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.modelArray.count;
    
}




/******************* row数量 *******************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 1.获取对应组模型array
    NSArray *array = self.modelArray[section];
    
    // 2.返回对应组模型数量
    return array.count;
    
}


/******************* cell高度 *******************/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 58;
    
}




/******************* sectionHeader高度——间距 *******************/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
    
}







/******************* 设置sectionHeader *******************/
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    // 1.初始化HeaderView
    UIView *headerView = [[UIView alloc] init];
    
    // 2.设置headerView的Frame
    headerView.frame = CGRectMake(0, 0, ZFScreenW, 10);
    
    // 3.设置背景色
    headerView.backgroundColor = ZFGrayBgColor;
    
    // 4.return
    return headerView;
    
}




/******************* 设置Cell *******************/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sectionArray = self.modelArray[indexPath.section];
    
    ZFMeListCell *cell = [tableView dequeueReusableCellWithIdentifier:ZFMeListCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = sectionArray[indexPath.row];
    if ([cell.nameLabel.text isEqualToString:@"店铺管理"]) {
        if (self.modelArray.count > 0){
            
            cell.detailLabel.text = [NSString stringWithFormat:@"当前已有%lu家店铺",(unsigned long)self.array.count];
        }
    }
//    ZFLog(@"我的界面数据==================%@", cell.model.title);
    return cell;
    
}


#pragma mark - UITableViewDelegate

/******************* 监听cell点击 *******************/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    // 0.去除配置数据
//    ZFConfigModel *configModel = [ZFConfigModel unarchiveLoginDataFromSandBox];
//    ZFLoginModel *loginModel = [ZFLoginModel unarchiveLoginDataFromSandBox];
//
//    // 1.取出模型数组
    NSArray *sectionArray = self.modelArray[indexPath.section];
//
    // 2.模型
    ZFSettingDataModel *model = sectionArray[indexPath.row];
//
    // 3.根据模型title——>判断点击
    if ([model.title isEqualToString:@"店铺管理"]){
        
        ZFShopListController *vc = [[ZFShopListController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }else if ([model.title isEqualToString:@"设备管理"]){


        ZFEquipmentListController *vc = [[ZFEquipmentListController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];


    }else if ([model.title isEqualToString:@"银行卡管理1"]){

        ZFBankListController *vc = [[ZFBankListController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }else if ([model.title isEqualToString:@"消费记录"]){
        
        ZFFareRecordController *vc = [[ZFFareRecordController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([model.title isEqualToString:@"客服热线"]){

//        NSString *call = [configModel.callnumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSString *call = @"400-0806-002";
        NSMutableString* str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",call];

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else if ([model.title isEqualToString:@"设置"]){
        
        ZFSettingViewController *vc = [[ZFSettingViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    
    
}


@end
