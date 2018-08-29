//
//  ZFUnMatchedController.m
//  antifake
//
//  Created by Zach on 2018/5/7.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "ZFUnMatchedController.h"
#import <MJExtension.h>
#import "ZFMacNumberListModel.h"
#import "ZFDataListCell.h"

@interface ZFUnMatchedController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak)UITableView *tableView;

/**< array */
@property (nonatomic, copy) NSArray *array;

@end

@implementation ZFUnMatchedController

/** cell的循环利用标识 */
static NSString * const ZFDataListCellID = @"ZFDataListCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTableView];
    
    // 3.初始化TableView数据
    [self setupTableViewData];
}



- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    //    [self getBankCardList];
    
    
}


#pragma mark - Pravite

- (void)setupNav
{
    
//    self.navigationItem.title = @"浙江华仁....";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"add" target:self action:@selector(addBankCard:)];
  
    
}



- (void)setupTableView
{
    /****** TableView ******/
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, 0, ZFScreenW, ZFScreenH - ZFNAVIGATION_BAR_HEIGHT - 60 - 45);
    [self.view addSubview:tableView];
    
    // 设置数据源和代理
    tableView.delegate = self;
    tableView.dataSource = self;
    
    // 去除系统分割线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZFDataListCell class]) bundle:nil] forCellReuseIdentifier:ZFDataListCellID];
    
    // 强引用
    self.tableView = tableView;
    
    // 设置footer——>必须放在强引用之后，否则直接消失
    //    self.tableView.tableFooterView = [[ZFBankListFooter alloc] init];
    
    
    UIButton *matchingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    matchingButton.frame = CGRectMake(0, ZFScreenH - ZFNAVIGATION_BAR_HEIGHT - ZFTAB_BAR_HEIGHT- 60 - 45 - 10, ZFScreenW, 45);
    [matchingButton setBackgroundColor:ZFColor(70, 142, 239)];
    [matchingButton setTitle:@"立即查询" forState:UIControlStateNormal];
    [self.view addSubview:matchingButton];
}



/******************* 初始化TableViewData *******************/
- (void)setupTableViewData
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
        
        NSString *flag = JSON[@"flag"];
        
        ZFLog(@"userInfo==============%@=========%@",JSON, flag);
        
        //        if ([flag isEqualToString:@"1"]) {
        
        NSArray *modelArray = [ZFMacNumberListModel mj_objectArrayWithKeyValuesArray:JSON[@"data"]];
        self.array = modelArray;
        [weakSelf.tableView reloadData];
        //        }else{
        //
        //
        //        }
        
        
        
        
    } failure:^(NSError *error) {
        
        
        [SVProgressHUD showErrorWithStatus:@"您的网络不给力"];
        
    }];
    
    
}




- (void)selectClickAction
{
    
//    ZFFilterViewController *vc = [[ZFFilterViewController alloc] init];
//    [self.navigationController pushViewController:vc
//                                         animated:YES];
    
}


#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 6;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 61;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZFDataListCell *cell = [tableView dequeueReusableCellWithIdentifier:ZFDataListCellID];
    //    cell.model = self.bankArraryModel[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    ZFPhoneSaleDetailController *vc = [[ZFPhoneSaleDetailController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    
}


@end
