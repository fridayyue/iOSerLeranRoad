//
//  WXFunSelectViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/17.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "WXFunSelectViewController.h"
#import "FunTableHeardView.h"
#import "FunSelectTableViewCell.h"
#import "WXYingxiaoModelControl.h"
#import "WXYingXiaoManger.h"

@interface WXFunSelectViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation WXFunSelectViewController{
    NSMutableArray* _dataArray;
    NSMutableArray* _selectArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
}
-(void)initView{
    _dataArray = @[].mutableCopy;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"FunSelectTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FunSelectTableViewCell"];
    _selectArray = [WXYingXiaoManger shareManger].wxFunArray.mutableCopy;
    [self makeRightNavBtnTitle:@"确定"];
}
#pragma mark - Net
-(void)getData{
    
    NSDictionary *paramtar = @{
                               @"token":[UserManger shareManger].getUserID
                               };
    [SVProgressHUD showWithStatus:@"加载中..."];
    [WXYingxiaoModelControl getFunSelectArray:paramtar success:^(NSArray *dataArry) {
        [SVProgressHUD showSuccessWithStatus:@"加载完成"];
        self->_dataArray = dataArry.mutableCopy;
        [self->_tableView reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}
#pragma mark - Action
-(IBAction)actionForheardView:(UIButton *)sender{
     WXFunModel *heardModel = _dataArray[sender.tag];
    heardModel.selected = !heardModel.selected;
    [_dataArray replaceObjectAtIndex:sender.tag withObject:heardModel];
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationFade];
    if (heardModel.chrildArray.count == 0) {
        FunTableHeardView *heardView = (FunTableHeardView *)[self tableView:_tableView viewForHeaderInSection:sender.tag];
        heardView.titleLabel.text = heardModel.hobbyName;
        [heardView.statusImage setImage:[UIImage imageNamed:heardModel.selected?@"WX_Selected2":@"WX_Unselected2"]];
        if (heardModel.selected) {
            if (![_selectArray containsObject:heardModel]) {
                [_selectArray addObject:heardModel];
            }
        }else{
            if ([_selectArray containsObject:heardModel]) {
                [_selectArray removeObject:heardModel];
            }
        }
    }
}
-(void)actionForRightBtn:(id)sender{
    [[WXYingXiaoManger shareManger].wxFunArray addObjectsFromArray:_selectArray];
    NSOrderedSet *set = [[NSOrderedSet alloc] initWithArray:[WXYingXiaoManger shareManger].wxFunArray];
    [WXYingXiaoManger shareManger].wxFunArray = set.array.mutableCopy;
    if (_compleBlock) {
        _compleBlock();
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - TableDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WXFunModel *heardModel = _dataArray[section];
    FunTableHeardView *heardView = [[FunTableHeardView alloc] initWithType:heardModel.chrildArray.count > 0 ? 1:2];
    heardView.titleLabel.text = heardModel.hobbyName;
    if (heardModel.chrildArray.count == 0) {
        for (WXFunModel *selectModel in _selectArray) {
            if (heardModel.id == selectModel.id) {
                heardModel = selectModel;
                [_dataArray replaceObjectAtIndex:section withObject:heardModel];
            }
        }
        [heardView.statusImage setImage:[UIImage imageNamed:heardModel.selected?@"WX_Selected2":@"WX_Unselected2"]];
    }
    heardView.seationBtn.tag = section;
    [heardView.seationBtn addTarget:self action:@selector(actionForheardView:) forControlEvents:UIControlEventTouchUpInside];
    return heardView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     WXFunModel *heardModel = _dataArray[section];
    if (heardModel.selected) {
        return heardModel.chrildArray.count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FunSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FunSelectTableViewCell"];
    WXFunModel *pModel = _dataArray[indexPath.section];
    WXFunModel *cModel = pModel.chrildArray[indexPath.row];
    for (WXFunModel *selectModel in _selectArray) {
        if (cModel.id == selectModel.id) {
            cModel = selectModel;
            [pModel.chrildArray replaceObjectAtIndex:indexPath.row withObject:cModel];
        }
    }
    cell.cellTitleLabel.text = cModel.hobbyName;
    [cell.statusImage setImage:[UIImage imageNamed:cModel.selected?@"WX_Selected2":@"WX_Unselected2"]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WXFunModel *pModel = _dataArray[indexPath.section];
    WXFunModel *cModel = pModel.chrildArray[indexPath.row];
    cModel.selected = !cModel.selected;
    FunSelectTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.statusImage setImage:[UIImage imageNamed:cModel.selected?@"WX_Selected2":@"WX_Unselected2"]];
    [pModel.chrildArray replaceObjectAtIndex:indexPath.row withObject:cModel];
    if (cModel.selected) {
        if (![_selectArray containsObject:cModel]) {
            [_selectArray addObject:cModel];
        }
    }else{
        if ([_selectArray containsObject:cModel]) {
            [_selectArray removeObject:cModel];
        }
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
@end
