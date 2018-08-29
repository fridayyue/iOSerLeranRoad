//
//  BillViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/24.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BillViewController.h"
#import "BillModelControl.h"
#import "BillTableViewCell.h"

@interface BillViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation BillViewController{
    NSArray *_dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
}
-(void)initView{
    self.title = @"消费记录";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"BillTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BillTableViewCell"];
    _tableView.estimatedRowHeight = 60;
}
#pragma mark - Net
-(void)getData{
    [SVProgressHUD show];
    [BillModelControl getConsumerList:@{@"token":[UserManger shareManger].getUserID} success:^(NSArray *dataArry) {
        [SVProgressHUD showSuccessWithStatus:nil];
        _dataArray = dataArry;
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:nil];
    }];
}
#pragma mark - TableDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BillTableViewCell"];
    BillModel *model = [[BillModel alloc] initWithDictionary:_dataArray[indexPath.row] error:nil];
    [cell configCell:model];
    return cell;
}
@end
