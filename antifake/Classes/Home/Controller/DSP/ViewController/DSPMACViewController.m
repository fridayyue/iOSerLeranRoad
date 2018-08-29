//
//  DSPMACViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/26.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DSPMACViewController.h"
#import "DSPMACTableViewCell.h"
#import "DSPMACDetailTableViewCell.h"
#import "HomeModelControl.h"
#import "DSPModelControl.h"
#import "XTTimeDateManger.h"
#import "DSPMacAlertView.h"
#import "DSPMACADViewController.h"
#import "DSPManger.h"
#import "DatePickerView.h"

@interface DSPMACViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *macListTableView;
@property (weak, nonatomic) IBOutlet UITableView *macDetailTableView;

@end

@implementation DSPMACViewController{
    NSArray *_macList;
    NSMutableArray *_macDetailList;
    NSInteger _pageIndex;
    NSString* _overDate;
    NSString* _startDate;
    BOOL _pageEnd;
    BOOL _requesting;
    NSIndexPath *_selectIndex;
    NSArray *_dspMacList;
    NSInteger _macNum;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self getMACList];
}
-(void)initView{
    self.title = @"选择MAC";
    [self makeRightNavBtnTitle1:@"选择" title2:@"时间"];
    [_macListTableView registerNib:[UINib nibWithNibName:@"DSPMACTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"DSPMACTableViewCell"];
    _macListTableView.estimatedRowHeight = 80;
    _macListTableView.delegate = self;
    _macListTableView.dataSource = self;
    
    [_macDetailTableView registerNib:[UINib nibWithNibName:@"DSPMACDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"DSPMACDetailTableViewCell"];
    _macDetailTableView.estimatedRowHeight = 80;
    _macDetailTableView.delegate = self;
    _macDetailTableView.dataSource = self;
}
-(void)initData{
    _overDate = [TimerSimpleManger currentDateStr];
    _startDate = [TimerSimpleManger currentDateStr];
    _pageIndex = 1;
    _pageEnd = NO;
    _requesting = NO;
    _macDetailList = @[].mutableCopy;
    _selectIndex = [NSIndexPath indexPathForRow:0 inSection:0];
}
-(void)reloadInitData{
    _pageIndex = 1;
    _pageEnd = NO;
    _requesting = NO;
}
#pragma mark - NET
-(void)getMACList{
    [HomeModelControl gethMaodieList:@{@"token":[UserManger shareManger].getUserID} success:^(NSArray *list) {
        _macList = list;
        [_macListTableView reloadData];
        [_macListTableView selectRowAtIndexPath:_selectIndex animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self tableView:_macListTableView didSelectRowAtIndexPath:_selectIndex];
    } failure:^(NSError *error) {
        
    }];
}
-(void)getMacDetailList:(DSPMACModel *)model{
//   startDate    2018-06-27
    NSDictionary *paramtar = @{
                               @"overDate":_startDate,
                               @"sta":model.sta,
                               @"pagesize":@(10),
                               @"newDateTime":[XTTimeDateManger currentTimeStr],
                               @"pageindex":@(_pageIndex),
                               @"startDate":_startDate,
                               @"token":[UserManger shareManger].getUserID
                               };
    [SVProgressHUD show];
    _requesting = YES;
    [DSPModelControl getMacLists:paramtar success:^(NSArray *array) {
        [SVProgressHUD showSuccessWithStatus:nil];
        _requesting = NO;
        if (array.count < 10) {
            _pageEnd = YES;
        }else{
            _pageEnd = NO;
        }
        [_macDetailList addObjectsFromArray:array];;
        [_macDetailTableView reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:nil];
        _requesting = NO;
        _pageIndex --;
    }];
}
-(void)getDspMacList{
//    @    token    5a1fd0a3-894e-4628-aebd-e3fe142701f2
    DSPMACModel *model = [[DSPMACModel alloc] initWithDictionary:_macList[_selectIndex.row] error:nil];
    NSDictionary *paramtar = @{
                               @"sta":model.sta,
                               @"macNum":@(_macNum),
                               @"token":[UserManger shareManger].getUserID
                               };
    [DSPModelControl getDspMacList:paramtar success:^(NSArray *array) {
        _dspMacList = array;
        for (NSDictionary *dic in _dspMacList) {
            if ([Judge judgeStringIsEmpty:[DSPManger shareManger].mac]) {
                [DSPManger shareManger].mac = [dic objectForKey:@"mac"];
            }else{
                [DSPManger shareManger].mac = [NSString stringWithFormat:@"%@%@",[DSPManger shareManger].mac,[dic objectForKey:@"mac"]];
            }
        }
        DSPMACADViewController *dspMacAdVC = [[DSPMACADViewController alloc] init];
        [self.navigationController pushViewController:dspMacAdVC animated:YES];
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - Action
-(void)actionForRight1Btn:(id)sender{
    DSPMacAlertView *alertView = [[DSPMacAlertView alloc] init];
    alertView.numberBlock = ^(NSString *number) {
        _macNum = [number integerValue];
        [self getDspMacList];
    };
    [self.navigationController.view addSubview:alertView];
    [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.navigationController.view);
    }];
}
-(void)actionForRight2Btn:(id)sender{
    DatePickerView *picker = [[DatePickerView alloc] init];
    picker.block = ^(NSDate *date) {
        _startDate = [XTTimeDateManger fomatterTime:@"yyyy-MM-dd" date:date];
        DSPMACModel *model = [[DSPMACModel alloc] initWithDictionary:_macList[_selectIndex.row] error:nil];
        [self getMacDetailList:model];
    };
    [self.navigationController.view addSubview:picker];
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.navigationController.view);
    }];
}
#pragma mark - TableDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _macListTableView) {
        return _macList.count;
    }else{
        return _macDetailList.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _macListTableView) {
        return 75;
    }else{
        return 80;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _macListTableView) {
        DSPMACTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DSPMACTableViewCell"];
        DSPMACModel *model = [[DSPMACModel alloc] initWithDictionary:_macList[indexPath.row] error:nil];
        [cell configCell:model];
        return cell;
    }else{
        DSPMACDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DSPMACDetailTableViewCell"];
        DSPMACDetailModel *model = [[DSPMACDetailModel alloc] initWithDictionary:_macDetailList[indexPath.row] error:nil];
        [cell configCell:model];
        if (indexPath.row == _macDetailList.count -1 && !_pageEnd && !_requesting) {
            _pageIndex ++;
            DSPMACModel *model = [[DSPMACModel alloc] initWithDictionary:_macList[_selectIndex.row] error:nil];
            [self getMacDetailList:model];
        }
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _macListTableView) {
        _selectIndex = indexPath;
        [self reloadInitData];
        DSPMACModel *model = [[DSPMACModel alloc] initWithDictionary:_macList[indexPath.row] error:nil];
        [self getMacDetailList:model];
    }else{
        
    }
}
@end
