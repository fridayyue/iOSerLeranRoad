//
//  DXChrooseViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/23.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DXChrooseViewController.h"
#import "DXPhoneNumberTableViewCell.h"
#import "DXModelControl.h"
#import "XTTimeDateManger.h"
#import "DXSaiXuanViewController.h"

@interface DXChrooseViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DXChrooseViewController{
    NSInteger _pageIndex;
    NSString *_endDate;
    NSString *_startDate;
    NSMutableArray *_dateMuArray;
    NSMutableArray *_selectMuArray;
    NSString *_searchString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self getChrooseData];
}
-(void)initView{
    self.title = @"号码选择";
    [self makeRightNavBtnTitle1:@"全选" title2:@"筛选"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 70;
    [self.tableView registerNib:[UINib nibWithNibName:@"DXPhoneNumberTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"DXPhoneNumberTableViewCell"];
}
-(void)initData{
    _endDate = [XTTimeDateManger fomatterTime:@"yyyy-MM-dd" date:[NSDate date]];
    _startDate = [XTTimeDateManger fomatterTime:@"yyyy-MM-dd" dateString:[XTTimeDateManger distanceCurrentDateStr:-60*60*24*3]];
    [self resetDate];
    _dateMuArray = @[].mutableCopy;
    _selectMuArray = @[].mutableCopy;
}
-(void)resetDate{
    _pageIndex = 1;
    _dateMuArray = @[].mutableCopy;
}
#pragma mark - Net
-(void)getChrooseData{
    NSDictionary *dic = @{
                          @"endDate": _endDate,
                          @"newDateTime":[XTTimeDateManger currentTimeStr],
                          @"pageindex":@(_pageIndex),
                          @"startDate":_startDate,
                          @"token":[UserManger shareManger].getUserID
                          };
    [self getData:dic];
}
-(void)searchData{
    NSDictionary *dic = @{
                          @"endDate": _endDate,
                          @"newDateTime":[XTTimeDateManger currentTimeStr],
                          @"pageindex":@(_pageIndex),
                          @"startDate":_startDate,
                          @"token":[UserManger shareManger].getUserID,
                          @"tel":_searchString
                          };
    [self resetDate];
    [self getData:dic];
}
-(void)getData:(NSDictionary *)paramtar{
    [DXModelControl getChooseTelData:paramtar success:^(NSArray *dataArry) {
        [_dateMuArray addObjectsFromArray:dataArry];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
}
#pragma makr - Action
-(IBAction)actionForRight1Btn:(id)sender{
    _selectMuArray = _dateMuArray.mutableCopy;
    [_tableView reloadData];
}
-(IBAction)actionForRight2Btn:(id)sender{
    DXSaiXuanViewController *shaixuanVC = [[DXSaiXuanViewController alloc] init];
    shaixuanVC.defineStratDate = [XTTimeDateManger stringToDate:[XTTimeDateManger distanceSigDate:[NSDate date] second:-60*60*24*3] oldFormatter:@"yyyy-MM-dd HH:mm:ss" newFormatter:@"yyyy-MM-dd"];
    shaixuanVC.shaiXuanBlock = ^(NSDate *startDate, NSDate *endDate) {
        _startDate = [XTTimeDateManger fomatterTime:@"yyyy-MM-dd" date:startDate];
        _endDate = [XTTimeDateManger fomatterTime:@"yyyy-MM-dd" date:endDate];
        [self resetDate];
        [self getChrooseData];
    };
    [self.navigationController pushViewController:shaixuanVC animated:YES];
}
- (IBAction)actionForSearchTF:(UITextField *)sender {
    _searchString = sender.text;
    [self searchData];
}
- (IBAction)actionForSure:(UIButton *)sender {
    if (_selectMuArray.count < 50) {
        [SVProgressHUD showErrorWithStatus:@"请最少选择50条号码！"];
        return;
    }
    if (_chrooseBlock) {
        _chrooseBlock(_selectMuArray);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dateMuArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DXPhoneNumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DXPhoneNumberTableViewCell"];
    DXShaiXuanModel *shaixuanModel = [[DXShaiXuanModel alloc] initWithDictionary:_dateMuArray[indexPath.row] error:nil];
    shaixuanModel.select = [_selectMuArray containsObject:_dateMuArray[indexPath.row]];
    [cell configCell:shaixuanModel];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_selectMuArray containsObject:_dateMuArray[indexPath.row]]) {
        [_selectMuArray removeObject:_dateMuArray[indexPath.row]];
    }else{
        [_selectMuArray addObject: _dateMuArray[indexPath.row]];
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
@end
