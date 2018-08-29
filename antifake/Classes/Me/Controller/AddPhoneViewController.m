//
//  AddPhoneViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/12.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "AddPhoneViewController.h"
#import "AddPhoneTableViewCell.h"
#import "MeModelControl.h"
#import "AddPhone2ViewController.h"

@interface AddPhoneViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    UIAlertViewDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *footerview;

@end

@implementation AddPhoneViewController{
    NSArray *_listArray;
    NSIndexPath * _lastSelectIndex;
    NSString *_delegatePhone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getPhoneList];
}
-(void)initView{
    self.title = @"手机号";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = _footerview;
    [_tableView registerNib:[UINib nibWithNibName:@"AddPhoneTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AddPhoneTableViewCell"];
    _listArray = @[];
    _lastSelectIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    _delegatePhone = @"";
}
#pragma mark - Net
-(void)getPhoneList{
    NSDictionary *paramtar = @{
                               @"token":[[UserManger shareManger] getUserID]
                               };
    [SVProgressHUD show];
    [MeModelControl getPhoneList:paramtar success:^(NSArray *dataArray) {
        [SVProgressHUD showSuccessWithStatus:@"成功！"];
        self->_listArray = dataArray;
        [self->_tableView reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"失败"];
    }];
}
-(void)delegatePhone{
    NSDictionary *paramtar = @{
                               @"token":[[UserManger shareManger] getUserID],
                               @"phone":_delegatePhone
                               };
    [MeModelControl delegatePhone:paramtar success:^(NSDictionary *dic) {
        [self getPhoneList];
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - Action
-(IBAction)actionForSelect:(UIButton *)sender{
    AddPhoneModel *model = [[AddPhoneModel alloc] initWithDictionary:_listArray[sender.tag] error:nil];
    [UserManger shareManger].morenPhone = model.anum;
    [_tableView reloadData];
}
-(IBAction)actionForDelegate:(UIButton *)sender{
    AddPhoneModel *model = [[AddPhoneModel alloc] initWithDictionary:_listArray[sender.tag] error:nil];
    _delegatePhone = model.anum;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"注意" message:@"确定要作废该号码么？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}
- (IBAction)actionForAddPhone:(UIButton *)sender {
    AddPhone2ViewController *addphoneVC = [[AddPhone2ViewController alloc] init];
    [self.navigationController pushViewController:addphoneVC animated:YES];
}
#pragma mark - AlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self delegatePhone];
    }
}
#pragma mark - Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddPhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddPhoneTableViewCell"];
    AddPhoneModel *model = [[AddPhoneModel alloc] initWithDictionary:_listArray[indexPath.row] error:nil];
    [cell configCellWithModel:model];
    cell.selectBtn.tag = indexPath.row;
    cell.deleBtn.tag = indexPath.row;
    [cell.selectBtn addTarget:self action:@selector(actionForSelect:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleBtn addTarget:self action:@selector(actionForDelegate:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

@end
