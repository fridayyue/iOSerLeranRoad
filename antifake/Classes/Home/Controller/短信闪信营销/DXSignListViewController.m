//
//  DXSignListViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/24.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DXSignListViewController.h"
#import "DXModelControl.h"
#import "DXShenqingSignViewController.h"

@interface DXSignListViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DXSignListViewController{
    NSArray *_dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getdata];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)initView{
    self.title = @"选择签名";
    [self makeRightNavBtnTitle:@"申请签名"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}
#pragma mark - Action
-(void)actionForRightBtn:(id)sender{
    DXShenqingSignViewController *shenqingVC = [[DXShenqingSignViewController alloc] init];
    [self.navigationController pushViewController:shenqingVC animated:YES];
}
#pragma mark - Data
-(void)getdata{
    [DXModelControl getSignList:@{@"token":[UserManger shareManger].getUserID} success:^(NSArray *dataArry) {
        _dataArray = dataArry;
        [_tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [_dataArray[indexPath.row] objectForKey:@"sign"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_signBlock) {
        _signBlock([_dataArray[indexPath.row] objectForKey:@"sign"]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
