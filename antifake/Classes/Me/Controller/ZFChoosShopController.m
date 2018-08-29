//
//  ZFChoosShopController.m
//  antifake
//
//  Created by Zach on 2018/5/12.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "ZFChoosShopController.h"

#import <MJExtension.h>
#import "ZFShopListCell.h"
#import "ZFShopListModel.h"



@interface ZFChoosShopController ()<UITableViewDelegate,UITableViewDataSource>

/**< tableView */
@property (nonatomic, weak) UITableView *tableView;

/**< array */
@property (nonatomic, copy) NSArray *modelArray;

@end

@implementation ZFChoosShopController

/**< cell的循环利用标识 */
static NSString *ZFShopListCellID = @"ZFShopListCell";


#pragma mark - Life

/******************* 程序加载入口 *******************/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.初始化Nav
    [self setupNav];
    
    // 2.初始化tableView
    [self setupTableView];
    
    
    
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [self setupTableViewData];
    
}



#pragma mark - Private

/******************* 设置nav *******************/
- (void)setupNav
{
    // 0.消除间距
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 1.设置NavTitle
    self.navigationItem.title = @"店铺管理";
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_background"] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:nil];

    
}


/******************* 初始化TableView *******************/
- (void)setupTableView
{
    
    // 0.初始化
    UITableView *tableView = [[UITableView alloc] init];
    // a.frame
    tableView.frame = CGRectMake(0, 0, ZFScreenW, ZFScreenH - ZFNAVIGATION_BAR_HEIGHT);
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
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZFShopListCell class]) bundle:nil] forCellReuseIdentifier:ZFShopListCellID];
    
    
    
    
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

        
        if (JSON[@"flag"]) {
        
            NSArray *modelArray = [ZFShopListModel mj_objectArrayWithKeyValuesArray:JSON[@"data"]];
            self.modelArray = modelArray;
            [weakSelf.tableView reloadData];
            
        }else{


        }
        
        
        
        
    } failure:^(NSError *error) {
        
        
        [SVProgressHUD showErrorWithStatus:@"您的网络不给力"];
        
    }];
    
    
}


#pragma  mark - UItableViewDataSource

/******************* section数量 *******************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}




/******************* row数量 *******************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    // 2.返回对应组模型数量
    return self.modelArray.count;
    
}


/******************* cell高度 *******************/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 65;
    
}




/******************* sectionHeader高度——间距 *******************/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
    
}







///******************* 设置sectionHeader *******************/
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//
//    // 1.初始化HeaderView
//    UIView *headerView = [[UIView alloc] init];
//
//    // 2.设置headerView的Frame
//    headerView.frame = CGRectMake(0, 0, ZFScreenW, 10);
//
//    // 3.设置背景色
//    headerView.backgroundColor = ZFGrayBgColor;
//
//    // 4.return
//    return headerView;
//
//}




/******************* 设置Cell *******************/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSArray *sectionArray = self.modelArray[indexPath.section];
    
    ZFShopListCell *cell = [tableView dequeueReusableCellWithIdentifier:ZFShopListCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.modelArray[indexPath.row];
    cell.eqAmount.hidden = YES;
    cell.arrowImge.hidden = YES;
    //    ZFLog(@"我的界面数据==================%@", cell.model.title);
    return cell;
    
}

#pragma mark - UITableViewDelegate

/******************* 监听cell点击 *******************/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.chooseshopDelegate respondsToSelector:@selector(finishSelectShopWithShopModel:)]) {
        
        ZFShopListModel *model = self.modelArray[indexPath.row];
        
        [self.chooseshopDelegate finishSelectShopWithShopModel:model];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
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
