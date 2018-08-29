//
//  DSPMeiTIViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/7/1.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DSPMeiTIViewController.h"
#import "MeitiTableViewCell.h"
#import "DSPModelControl.h"
#import "XTTimeDateManger.h"

@interface DSPMeiTIViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DSPMeiTIViewController{
    NSInteger _pageIndex;
    BOOL _isRequesting;
    BOOL _pageEnd;
    NSMutableArray *_dataMuArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self getMeitiList];
}
-(void)initView{
    self.title = @"媒体广告";
    [_tableView registerNib:[UINib nibWithNibName:@"MeitiTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MeitiTableViewCell"];
}
-(void)initData{
    _dataMuArray = @[].mutableCopy;
    _pageIndex = 1;
    _pageEnd = NO;
}
#pragma mark - Net
-(void)getMeitiList{
    NSDictionary *paramtar = @{
                               @"pagesize":@(20),
                               @"newDateTime":[XTTimeDateManger currentTimeStr],
                               @"pageindex":@(_pageIndex),
                               @"token":[UserManger shareManger].getUserID
                               };
    _isRequesting = YES;
    [SVProgressHUD show];
    [DSPModelControl getMeiTilist:paramtar success:^(NSArray *array, NSInteger total) {
        [SVProgressHUD showSuccessWithStatus:nil];
        _isRequesting = NO;
        if (array.count < 15) {
            _pageEnd = YES;
        }else{
            _pageEnd = NO;
        }
        [_dataMuArray addObjectsFromArray:array];
        [_tableView reloadData];
        self.title =[NSString stringWithFormat:@"媒体广告(%ld)",total];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:nil];
        _isRequesting = NO;
        _pageIndex --;
    }];
}
#pragma mark - Action
#pragma mark - TableDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataMuArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MeitiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeitiTableViewCell"];
    if (indexPath.row == (_dataMuArray.count -1)&&!_pageEnd&&!_isRequesting) {
        _pageIndex ++;
        [self getMeitiList];
    }
    MeiTiModel *model = [[MeiTiModel alloc] initWithDictionary:_dataMuArray[indexPath.row] error:nil];
    [cell configCell:model];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MeiTiModel *model = [[MeiTiModel alloc] initWithDictionary:_dataMuArray[indexPath.row] error:nil];
    if (model.enabled && _meitiBlock) {
        _meitiBlock(model);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
