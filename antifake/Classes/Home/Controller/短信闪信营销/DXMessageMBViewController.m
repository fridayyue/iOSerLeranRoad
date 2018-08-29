//
//  DXMessageMBViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/23.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DXMessageMBViewController.h"
#import <Masonry.h>
#import "DXModelControl.h"
#import "DXMessageMBTableViewCell.h"
#import "UIAlertView+Block.h"
#import "DXAddMBViewController.h"

typedef NS_ENUM(NSInteger,MBType){
    yingxiao,
    hangye,
    wode,
};

@interface DXMessageMBViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *indexView;
@property (weak, nonatomic) IBOutlet UIButton *yingxiaoBtn;
@property (weak, nonatomic) IBOutlet UIButton *hangyeBtn;
@property (weak, nonatomic) IBOutlet UIButton *wodeBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DXMessageMBViewController{
    NSInteger _beyond;//营销和行业模板 2 我的 1
    NSInteger _smsSort;//营销2 行业模板1 我的不加
    NSArray *_yingxiaoArray;
    NSArray *_hangyeArray;
    NSArray *_wodeArray;
    MBType _mubanType;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self getDataNet];
}
-(void)initView{
    self.title = @"消息模板";
    [self makeRightNavBtnImage:[UIImage imageNamed:@"sum.png"]];
    [_indexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(3);
        make.bottom.mas_equalTo(_topView);
        make.centerX.width.mas_equalTo(_topView).multipliedBy(1/3.0);
    }];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 90;
    [_tableView registerNib:[UINib nibWithNibName:@"DXMessageMBTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"DXMessageMBTableViewCell"];
}
-(void)initData{
    _mubanType = yingxiao;
    _yingxiaoArray = @[];
    _hangyeArray = @[];
    _wodeArray = @[];
}
#pragma mark - Net
-(void)getDataNet{
    NSDictionary *paramtar = @{
                               @"beyond":_mubanType == wode ?@(1):@(2),
                               @"token":[UserManger shareManger].getUserID,
                               @"smsSort":_mubanType == yingxiao?@(2):@(1)
                               };
    if (_mubanType != wode) {
        [paramtar setValue:nil forKey:@"smsSort"];
    }
    [SVProgressHUD show];
    [DXModelControl getQuerySmsTemplate:paramtar success:^(NSArray *dataArry) {
        [SVProgressHUD showSuccessWithStatus:nil];
        if (_mubanType == yingxiao) {
            _yingxiaoArray = dataArry;
        }else if (_mubanType == hangye){
            _hangyeArray = dataArry;
        }else{
            _wodeArray = dataArry;
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
         [SVProgressHUD showErrorWithStatus:nil];
    }];
}
-(void)deleteSMS:(NSInteger)smsId{
    NSDictionary *paramtar = @{
                               @"smsId":@(smsId),
                               @"token":[UserManger shareManger].getUserID
                               };
    [DXModelControl getDelSmsTemplate:paramtar success:^(NSString *str) {
        [self getDataNet];
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"注意" message:@"删除成功！" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
    } failure:^(NSError *error) {
        
    }];
}
#pragma makr - Action
-(void)actionForRightBtn:(id)sender{
    DXAddMBViewController *adMBVC = [[DXAddMBViewController alloc] init];
    adMBVC.addBlock = ^{
        [self actionForWodemuban:_wodeBtn];
    };
    [self.navigationController pushViewController:adMBVC animated:YES];
}
- (IBAction)actionForYingxiaomuban:(id)sender {
    [_indexView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(3);
        make.bottom.mas_equalTo(_topView);
        make.centerX.width.mas_equalTo(_topView).multipliedBy(1/3.0);
    }];
    _mubanType = yingxiao;
    [self getDataNet];
}
- (IBAction)actionForHangyeMuBan:(id)sender {
    [_indexView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(3);
        make.bottom.mas_equalTo(_topView);
        make.width.mas_equalTo(_topView).multipliedBy(1/3.0);
        make.centerX.mas_equalTo(_topView).multipliedBy(1);
    }];
    _mubanType = hangye;
    [self getDataNet];
}

- (IBAction)actionForWodemuban:(id)sender {
    [_indexView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(3);
        make.bottom.mas_equalTo(_topView);
        make.width.mas_equalTo(_topView).multipliedBy(1/3.0);
        make.centerX.mas_equalTo(_topView).multipliedBy(5/3.0);
    }];
    _mubanType = wode;
    [self getDataNet];
}
-(IBAction)actionForDelegate:(UIButton *)sender{
    DXMessageMBModel *mbModel = [[DXMessageMBModel alloc] initWithDictionary:_wodeArray[sender.tag] error:nil];
    [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [self deleteSMS:mbModel.smsId];
        }
    } title:@"注意" message:@"确定要删除该模板吗？" cancelButtonName:@"取消" otherButtonTitles:@"确定", nil];
}
#pragma mark - TableDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mubanType == yingxiao ? _yingxiaoArray.count:_mubanType == hangye ? _hangyeArray.count : _wodeArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DXMessageMBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DXMessageMBTableViewCell"];
    DXMessageMBModel *mbModel = [[DXMessageMBModel alloc] initWithDictionary:_mubanType == yingxiao ? _yingxiaoArray[indexPath.row]:_mubanType == hangye?_hangyeArray[indexPath.row]:_wodeArray[indexPath.row] error:nil];
    [cell configCellModel:mbModel];
    cell.deleteBtn.hidden = !(_mubanType == wode);
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(actionForDelegate:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DXMessageMBModel *mbModel = [[DXMessageMBModel alloc] initWithDictionary:_mubanType == yingxiao ? _yingxiaoArray[indexPath.row]:_mubanType == hangye?_hangyeArray[indexPath.row]:_wodeArray[indexPath.row] error:nil];
    if (_selectBlock) {
        _selectBlock(mbModel);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
