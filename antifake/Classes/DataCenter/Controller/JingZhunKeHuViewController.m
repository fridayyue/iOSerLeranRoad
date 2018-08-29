//
//  JingZhunKeHuViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/11.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "JingZhunKeHuViewController.h"
#import "AddressPickView.h"
#import "SexOrAngePickerView.h"
#import <Masonry.h>
#import "XTTimeDateManger.h"
#import "DataCenterModelControl.h"
#import "DataCenterTableViewCell.h"
#import "DataCenterModel.h"
#import "JingZhunDetailViewController.h"

@interface JingZhunKeHuViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

@end

@implementation JingZhunKeHuViewController{
    NSInteger _pageIndex;
    NSInteger _pageSize;
    BOOL _isRequesting;
    NSMutableArray *_dataMuArray;
    BOOL _pageEnd;
    
    NSString* _province;
    NSString* _city;
    NSString *_district;
    
    NSString *_sex;
    
    NSString *_old;
    
    NSString *_keyWord;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self iniValue];
    [self getBigDataByTerm];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Makeview
-(void)initView{
    self.title = @"精准客户";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"DataCenterTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"DataCenterTableViewCell"];
    [self initSerachData];
    [self initArearData];
    [self initSexData];
    [self iniOld];
}
-(void)iniValue{
    _pageSize = 20;
    _pageIndex = 1;
    _isRequesting = NO;
    _pageEnd = NO;
    _dataMuArray = @[].mutableCopy;
}
-(void)initSerachData{
    _keyWord = @"";
}
-(void)initArearData{
    _province = @"";
    _city = @"";
    _district = @"";
}
-(void)initSexData{
    _sex = @"";
}
-(void)iniOld{
    _old = @"";
}
-(void)makeAdressView{
    AddressPickView *addressPickView = [AddressPickView shareInstance];
    [self.navigationController.view addSubview:addressPickView];
    addressPickView.block = ^(NSString *province,NSString *city,NSString *town){
        self->_province = province;
        self->_city = city;
        self->_district = town;
        self.areaLabel.text = [NSString stringWithFormat:@"%@%@%@",self->_province,self->_city,self->_district];
        [self getSearchData];
    };
}
-(void)makeSexView{
    SexOrAngePickerView *sexView = [[SexOrAngePickerView alloc] initWithType:sexPicker];
    sexView.block = ^(NSString *sex) {
        if ([sex isEqualToString:@"所有人群"]) {
            self->_sex = @"";
        }else{
            self->_sex = sex;
        }
        self.sexLabel.text = self->_sex?self->_sex:@"性别";
        [self getSearchData];
    };
    [self.navigationController.view addSubview:sexView];
    [sexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.navigationController.view);
    }];
}
-(void)makeAgeView{
    SexOrAngePickerView *oldView = [[SexOrAngePickerView alloc] initWithType:agePicker];
    oldView.block = ^(NSString *sex) {
        if ([sex isEqualToString:@"不限"]) {
            self->_old = @"";
        }else{
            self->_old = sex;
        }
        self.ageLabel.text = self->_old?self->_old:@"年龄";
        [self getSearchData];
    };
    [self.navigationController.view addSubview:oldView];
    [oldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.navigationController.view);
    }];
}
#pragma mark - Net
-(void)getSearchData{
    [self iniValue];
    [self getBigDataByTerm];
}
-(void)getBigDataByTerm{
    NSMutableDictionary *paramtar = @{
                               @"pagesize":@(_pageSize),
                               @"newDateTime":[XTTimeDateManger currentTimeStr],
                               @"pageindex":@(_pageIndex),
                               @"token":[[UserManger shareManger] getUserID]
                               }.mutableCopy;
    if (![Judge judgeStringIsEmpty:_province]) {
        [paramtar setObject:_province forKey:@"province"];
        [paramtar setObject:_city forKey:@"city"];
        [paramtar setObject:_district forKey:@"district"];
    }
    if (![Judge judgeStringIsEmpty:_sex]) {
        [paramtar setObject:_sex forKey:@"sex"];
    }
    if (![Judge judgeStringIsEmpty:_old]) {
        [paramtar setObject:_old forKey:@"old"];
    }
    if (![Judge judgeStringIsEmpty:_keyWord]) {
        [paramtar setObject:_keyWord forKey:@"keyWord"];
    }
    _isRequesting = YES;
    [SVProgressHUD showWithStatus:@"正在加载"];
    [DataCenterModelControl getBigDataByTerm:paramtar success:^(NSArray *dataArray) {
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        if (dataArray.count < self->_pageSize) {
            self->_pageEnd = YES;
        }else{
            self->_pageEnd = NO;
        }
        [self->_dataMuArray addObjectsFromArray:dataArray];
        [self.tableView reloadData];
        self->_isRequesting = NO;
    } faiure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        self->_pageIndex --;
        self->_isRequesting = NO;
    }];
}
#pragma mark - Action

- (IBAction)actionForAreaType:(UIButton *)sender {
    [self makeAdressView];
    
}
- (IBAction)actionForSexType:(UIButton *)sender {
    [self makeSexView];
    
}
- (IBAction)actionFortearsOld:(UIButton *)sender {
    [self makeAgeView];
}
- (IBAction)textFiledEditingEnd:(UITextField *)sender {
    if ([Judge judgeStringIsEmpty:sender.text] && [Judge judgeStringIsEmpty:_keyWord]) {
        return;
    }
    _keyWord = sender.text;
    [self getSearchData];
}
#pragma mark - TableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataMuArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DataCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DataCenterTableViewCell"];
    DataCenterModel *model = [[DataCenterModel alloc] initWithDictionary:_dataMuArray[indexPath.row] error:nil];
    cell.phoneLabel.text = [Help phoneNumberSecret:model.phoneNumber];
    if ([model.sex isEqualToString:@"男"]) {
        [cell.heardImage setImage:[UIImage imageNamed:@"DataCenter_Listman"]];
    }else if ([model.sex isEqualToString:@"女"]){
        [cell.heardImage setImage:[UIImage imageNamed:@"DataCenter_filmail.png"]];
    }else{
        [cell.heardImage setImage:[UIImage imageNamed:@"DataCenter_NoSex.png"]];
    }
    if (indexPath.row == _dataMuArray.count - 1 && !_pageEnd && !_isRequesting) {
        _pageIndex++;
        [self getBigDataByTerm];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     DataCenterModel *model = [[DataCenterModel alloc] initWithDictionary:_dataMuArray[indexPath.row] error:nil];
    JingZhunDetailViewController *detailVC = [[JingZhunDetailViewController alloc] init];
    detailVC.centerModel = model;
    [self.navigationController pushViewController:detailVC animated:YES];
}
@end
