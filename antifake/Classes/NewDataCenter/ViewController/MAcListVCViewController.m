//
//  MAcListVCViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/7/15.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "MAcListVCViewController.h"
#import "SinglePickerAlertView.h"
#import "MaodeiListModel.h"
#import "XTTimeDateManger.h"
#import "DSPModelControl.h"
#import "DataShaiXuanView.h"

@interface MAcListVCViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MAcListVCViewController{
    NSMutableArray *_macTitleArray;
    NSString *_titleString;
    NSMutableArray *_maodeiListDetailArrray;
    NSInteger _index;
    BOOL _pageEnd;
    BOOL _requesting;
    NSString* _startDate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
}
-(void)initView{
   
}
-(void)initData{
    [self initListData];
    _macTitleArray = @[].mutableCopy;
    for (NSDictionary *dic in _macList) {
        MaodeiListModel *model = [[MaodeiListModel alloc] initWithDictionary:dic error:nil];
        [_macTitleArray addObject:model.equipmentName];
    }
    _titleString = [_macTitleArray firstObject];
    [self makeTitleView:_titleString titleImage:@"data_down"];
    [self makeRightNavBtnImage:[UIImage imageNamed:@"data_more"]];
}
-(void)initListData{
    _maodeiListDetailArrray = @[].mutableCopy;
    _index = 1;
    _pageEnd = NO;
    _requesting = NO;
}
-(void)makeShaiXuan{
    DataShaiXuanView *dataShaiXuan = [[DataShaiXuanView alloc] init];
    [self.view addSubview:dataShaiXuan];
    [dataShaiXuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(self.view.mas_top);
        make.trailing.mas_equalTo(self.view.mas_trailing);
    }];
}
#pragma mark - Action
-(void)actionForNavTitleView:(id)sender{
    SinglePickerAlertView *aimAlertView = [[SinglePickerAlertView alloc] initWithData:_macTitleArray defaultString:_titleString];
    aimAlertView.block = ^(NSString *data) {
        _titleString = data;
        [self makeTitleView:_titleString titleImage:@"data_down"];
    };
    [self.navigationController.view addSubview:aimAlertView];
    [aimAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.navigationController.view);
    }];
}
-(void)actionForRightBtn:(id)sender{
    [self makeShaiXuan];
}
#pragma mark - Net
-(void)getMacDetailList:(MaodeiListModel *)model{
    //   startDate    2018-06-27
    NSDictionary *paramtar = @{
                               @"overDate":_startDate,
                               @"sta":model.sta,
                               @"pagesize":@(10),
                               @"newDateTime":[XTTimeDateManger currentTimeStr],
                               @"pageindex":@(_index),
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
        [_maodeiListDetailArrray addObjectsFromArray:array];;
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:nil];
        _requesting = NO;
        _index --;
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
@end
