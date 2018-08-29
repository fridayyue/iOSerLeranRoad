//
//  PhoneSaleController.m
//  antifake
//
//  Created by Zach on 2018/5/6.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "PhoneSaleController.h"
#import "ZFFilterViewController.h"
#import "ZFPhoneSaleListViewCell.h"
#import "ZFPhoneSaleDetailController.h"
#import "UIBarButtonItem+ZFExtension.h"



@interface PhoneSaleController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak)UITableView *tableView;


@end

@implementation PhoneSaleController


/** cell的循环利用标识 */
static NSString * const ZFPhoneSaleListViewCellID = @"ZFPhoneSaleListViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTableView];
    
}



- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
//    [self getBankCardList];
    
    
}


#pragma mark - Pravite

- (void)setupNav
{
    
    self.navigationItem.title = @"浙江华仁....";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"add" target:self action:@selector(addBankCard:)];
    
    UIBarButtonItem *filItme = [UIBarButtonItem itemWithTitle:@"筛选" target:self action:@selector(selectClickAction)];
    self.navigationItem.rightBarButtonItem = filItme;
    
}



- (void)setupTableView
{
    /****** TableView ******/
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, 40, ZFScreenW, ZFScreenH - ZFNAVIGATION_BAR_HEIGHT - 40);
    [self.view addSubview:tableView];
    
    // 设置数据源和代理
    tableView.delegate = self;
    tableView.dataSource = self;
    
    // 去除系统分割线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZFPhoneSaleListViewCell class]) bundle:nil] forCellReuseIdentifier:ZFPhoneSaleListViewCellID];
    
    // 强引用
    self.tableView = tableView;
    
    // 设置footer——>必须放在强引用之后，否则直接消失
    //    self.tableView.tableFooterView = [[ZFBankListFooter alloc] init];
    
}


- (void)selectClickAction
{
    
    ZFFilterViewController *vc = [[ZFFilterViewController alloc] init];
    [self.navigationController pushViewController:vc
                                         animated:YES];
    
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
    
    ZFPhoneSaleListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZFPhoneSaleListViewCellID];
//    cell.model = self.bankArraryModel[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZFPhoneSaleDetailController *vc = [[ZFPhoneSaleDetailController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
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
