//
//  StatementViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/26.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "StatementViewController.h"
#import "StatementTableViewCell.h"
#import "StatementModelControl.h"
#import "XTTimeDateManger.h"
#import "StatementSMSDetailViewController.h"
#import "AppDelegate.h"

@interface StatementViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    UITabBarControllerDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *duanxinBtn;
@property (weak, nonatomic) IBOutlet UIButton *shanxinBtn;
@property (weak, nonatomic) IBOutlet UIButton *dianhuaBtn;

@end

@implementation StatementViewController{
    NSMutableArray *_dataArray;
    NSInteger _index;
    BOOL _pageEnd;
    BOOL _isRequesting;
    Type _viewType;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self getSmsList];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)didChnageViewController:(NSNotification *)noti{
    if (noti.object == self.navigationController) {
        [self initData];
        [self getSmsList];
    }
}
-(void)initView{
    self.title = @"统计报表";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 70;
    [_tableView registerNib:[UINib nibWithNibName:@"StatementTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"StatementTableViewCell"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChnageViewController:) name:@"TabbardidSelectViewController" object:nil];
    _viewType = smsType;
}
-(void)initData{
    _dataArray = @[].mutableCopy;
    _pageEnd = NO;
    _isRequesting = NO;
    _index = 1;
}
- (IBAction)actionForType:(UIButton *)sender {
    _duanxinBtn.selected = NO;
    _shanxinBtn.selected = NO;
    _dianhuaBtn.selected = NO;
    [self initData];
    if (sender == _duanxinBtn) {
        _duanxinBtn.selected = YES;
        _viewType = smsType;
        [self getSmsList];
    }else if (sender == _shanxinBtn){
        _shanxinBtn.selected = YES;
        _viewType = fashType;
        [self getShanXinList];
    }else{
        _dianhuaBtn.selected = YES;
        _viewType = callType;
        [self getDianHuaList];
    }
}
#pragma mark - Net
-(void)getSmsList{
    NSDictionary *paramtar = @{
                               @"pagesize":@(20),
                               @"newDateTime":[XTTimeDateManger currentTimeStr],
                               @"pageindex":@(_index),
                               @"token":[UserManger shareManger].getUserID
                               };
    _isRequesting = YES;
    [SVProgressHUD show];
    [StatementModelControl smsList:paramtar success:^(NSArray *array) {
        [SVProgressHUD showSuccessWithStatus:nil];
        _isRequesting = NO;
        if (array.count < 20) {
            _pageEnd = YES;
        }else{
            _pageEnd = NO;
        }
        [_dataArray addObjectsFromArray:array];
        [_tableView reloadData];
    } failure:^(NSError *error) {
         [SVProgressHUD showErrorWithStatus:nil];
        _isRequesting = NO;
        _index--;
    }];
}
-(void)getShanXinList{
    NSDictionary *paramtar = @{
                               @"pagesize":@(20),
                               @"newDateTime":[XTTimeDateManger currentTimeStr],
                               @"pageindex":@(_index),
                               @"token":[UserManger shareManger].getUserID
                               };
    _isRequesting = YES;
    [SVProgressHUD show];
    [StatementModelControl flashSmsList:paramtar success:^(NSArray *array) {
        [SVProgressHUD showSuccessWithStatus:nil];
        _isRequesting = NO;
        if (array.count < 20) {
            _pageEnd = YES;
        }else{
            _pageEnd = NO;
        }
        [_dataArray addObjectsFromArray:array];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:nil];
        _isRequesting = NO;
        _index--;
    }];
}
-(void)getDianHuaList{
    NSDictionary *paramtar = @{
                               @"pagesize":@(20),
                               @"newDateTime":[XTTimeDateManger currentTimeStr],
                               @"pageindex":@(_index),
                               @"token":[UserManger shareManger].getUserID
                               };
    _isRequesting = YES;
    [SVProgressHUD show];
    [StatementModelControl callLogList:paramtar success:^(NSArray *array) {
        [SVProgressHUD showSuccessWithStatus:nil];
        _isRequesting = NO;
        if (array.count < 20) {
            _pageEnd = YES;
        }else{
            _pageEnd = NO;
        }
        [_dataArray addObjectsFromArray:array];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:nil];
        _isRequesting = NO;
        _index--;
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StatementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StatementTableViewCell"];
    if (_viewType == smsType) {
        StatementSMSModel *model = [[StatementSMSModel alloc] initWithDictionary:_dataArray[indexPath.row] error:nil];
        [cell configCellSMS:model];
    }else if (_viewType == fashType){
        StatementFlashSmsModel *model = [[StatementFlashSmsModel alloc] initWithDictionary:_dataArray[indexPath.row] error:nil];
        [cell configCellFS:model];
    }else{
        StatementCallLogListModel *model = [[StatementCallLogListModel alloc] initWithDictionary:_dataArray[indexPath.row] error:nil];
        [cell configCellCALL:model];
    }
   
    if ((indexPath.row == _dataArray.count -1)&&!_pageEnd&&!_isRequesting) {
        _index ++;
        [self getSmsList];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_viewType == callType) {
        return;
    }
    StatementSMSDetailViewController *smsDetailVC = [[StatementSMSDetailViewController alloc] init];
    if (_viewType == smsType) {
        StatementSMSModel *smsModel = [[StatementSMSModel alloc] initWithDictionary:_dataArray[indexPath.row] error:nil];
        smsDetailVC.smsModel = smsModel;
    }else{
        StatementFlashSmsModel *model = [[StatementFlashSmsModel alloc] initWithDictionary:_dataArray[indexPath.row] error:nil];
        smsDetailVC.fashModel = model;
    }
    smsDetailVC.viewType = _viewType;
    [self.navigationController pushViewController:smsDetailVC animated:YES];
}
@end
