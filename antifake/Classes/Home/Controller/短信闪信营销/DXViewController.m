//
//  DXViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/18.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DXViewController.h"
#import "DXChrooseViewController.h"
#import "DXMessageMBViewController.h"
#import "DXModelControl.h"
#import "NSAttributedString+XTCustomAttributedString.h"
#import "DXSignListViewController.h"

@interface DXViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *shiyongBtn;
@property (weak, nonatomic) IBOutlet UIButton *bushiyongBtn;
@property (weak, nonatomic) IBOutlet UIView *lijidaoruView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lijidaoruViewHeigh;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *daoruViewHeight;
@property (weak, nonatomic) IBOutlet UITextView *shoudongshuruTV;
@property (weak, nonatomic) IBOutlet UILabel *fasongshuliangLB;
@property (weak, nonatomic) IBOutlet UILabel *signLabel;
@property (weak, nonatomic) IBOutlet UITextView *messageTV;
@property (weak, nonatomic) IBOutlet UILabel *yishuruLB;
@property (weak, nonatomic) IBOutlet UILabel *zonggongLB;
@property (weak, nonatomic) IBOutlet UITextField *qianmingTF;
@property (weak, nonatomic) IBOutlet UILabel *yusuanLB;
@property (weak, nonatomic) IBOutlet UILabel *yidaoruLB;
@property (weak, nonatomic) IBOutlet UILabel *qianmingTitleLB;
@property (weak, nonatomic) IBOutlet UIButton *shanxinQianmingBtn;
@property (weak, nonatomic) IBOutlet UIButton *messageMBBtn;

@end

@implementation DXViewController{
    NSMutableArray *_selectMuArray;
    NSMutableArray *_shuruMuArray;
    NSString *_selectStr;//发送短信手机号的字符串
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
}
-(void)initView{
    self.title = _viewType == shanxinType ?@"闪信": @"短信";
    [self makeRightNavBtnImage:[UIImage imageNamed:@"WX_Question.png"]];
    _shoudongshuruTV.delegate = self;
    _messageTV.delegate =self;
    _yusuanLB.attributedText = [NSAttributedString changeAttributedStringStr:_yusuanLB.text pointString:@"预算" changeColor:HEX_COLOR(0x333333) changeSize:_yusuanLB.font.pointSize];
    _qianmingTitleLB.textColor = HEX_COLOR(0x333333);
    _qianmingTitleLB.attributedText = [NSAttributedString changeAttributedStringStr:_viewType == shanxinType?@"*闪信签名":@"*短信签名" pointString:@"*" changeColor:HEX_COLOR(0xff4040) changeSize:14.0f];
    _shanxinQianmingBtn.hidden = (_viewType == duxninType);
    _messageMBBtn.hidden = (_viewType == shanxinType);
}
-(void)initData{
    _shuruMuArray = @[].mutableCopy;
}
-(void)forMatterShuruArray{
    _shuruMuArray = @[].mutableCopy;
    NSArray *strAr = [_shoudongshuruTV.text componentsSeparatedByString:@","];
    for (NSString *str in strAr) {
        if (![Judge judgeStringIsEmpty:str]&&![str isEqualToString:@","]) {
            [_shuruMuArray addObject:str];
        }
    }
    _fasongshuliangLB.text = [NSString stringWithFormat:@"%ld",_shuruMuArray.count];
    CGFloat minPrice = 0.06;
    CGFloat maxPrice = 0.12;
    if (_viewType == shanxinType) {
        _yusuanLB.text = [NSString stringWithFormat:@"预算  %.2lf元",maxPrice * _shuruMuArray.count];
    }else{
            _yusuanLB.text = [NSString stringWithFormat:@"预算  %.2lf元-%.2lf元",minPrice * _shuruMuArray.count,maxPrice * _shuruMuArray.count];
    }
    _yusuanLB.attributedText = [NSAttributedString changeAttributedStringStr:_yusuanLB.text pointString:@"预算" changeColor:HEX_COLOR(0x333333) changeSize:_yusuanLB.font.pointSize];
}
-(void)shifangShuRuArray:(NSArray *)dataArray{
    NSString *shuruStr = @"";
    _selectMuArray = @[].mutableCopy;
    for (NSDictionary *dic in dataArray) {
        NSString *str = [dic objectForKey:@"msisdn"];
        [_selectMuArray addObject:str];
        if ([Judge judgeStringIsEmpty:shuruStr]) {
            shuruStr = [Help phoneNumberSecret:str];
            _selectStr = str;
        }else{
            shuruStr = [NSString stringWithFormat:@"%@,%@",shuruStr,[Help phoneNumberSecret:str]];
            _selectStr = [NSString stringWithFormat:@"%@,%@",_selectStr,str];
        }
    }
    _shoudongshuruTV.text = shuruStr;
    _yidaoruLB.text = [NSString stringWithFormat:@"已导入%ld个",_selectMuArray.count];
    _fasongshuliangLB.text = [NSString stringWithFormat:@"%ld",_selectMuArray.count];
}
-(void)updateZishuLabel{
    NSInteger shuru = _messageTV.text.length;
    NSInteger zonggong = 6 + shuru +_qianmingTF.text.length;
    _yishuruLB.text = [NSString stringWithFormat:@"%ld",shuru];
    _zonggongLB.text = [NSString stringWithFormat:@"%ld",zonggong];
}
#pragma mark - Net
-(void)submitSMS{
    NSString *phoneString = @"";
    if (_shiyongBtn.selected) {
        phoneString = _selectStr;
    }else{
        phoneString = _shoudongshuruTV.text;
    }
    NSDictionary *paramtar = @{
                               @"token":[UserManger shareManger].getUserID,
                               @"datas":phoneString,
                               @"content":_messageTV.text
                               };
    [DXModelControl sms:paramtar success:^(NSString *str) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        } title:nil message:@"发送成功！" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
    } failure:^(NSError *error) {
        
    }];
}
-(void)submitShanxin{
    NSString *phoneString = @"";
    if (_shiyongBtn.selected) {
        phoneString = _selectStr;
    }else{
        phoneString = _shoudongshuruTV.text;
    }
    NSDictionary *paramtar = @{
                               @"token":[UserManger shareManger].getUserID,
                               @"datas":phoneString,
                               @"content":_messageTV.text
                               };
    [DXModelControl submitFlashSmsTemplate:paramtar success:^(NSString *str) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        } title:nil message:@"发送成功！" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - Action
-(void)actionForRightBtn:(id)sender{
    
}
- (IBAction)actionForUsrDaoRu:(UIButton *)sender {
    sender.selected = YES;
    if (sender == _shiyongBtn) {
        _bushiyongBtn.selected = NO;
        _lijidaoruViewHeigh.constant = 50;
        _lijidaoruView.hidden = NO;
        _daoruViewHeight.constant = 170;
    }else{
        _shiyongBtn.selected = NO;
        _lijidaoruViewHeigh.constant = 0;
        _lijidaoruView.hidden = YES;
        _daoruViewHeight.constant = 120;
        [self shifangShuRuArray:@[]];
    }
    
}
- (IBAction)actionForDaoRu:(id)sender {
    DXChrooseViewController *chrooseVc = [[DXChrooseViewController alloc] init];
    chrooseVc.chrooseBlock = ^(NSArray *dataArray) {
        [self shifangShuRuArray:dataArray];
    };
    [self.navigationController pushViewController:chrooseVc animated:YES];
}
- (IBAction)actionForSignTF:(UITextField *)sender {
    _signLabel.text = [NSString stringWithFormat:@"【%@】",sender.text];
    [self updateZishuLabel];
}
- (IBAction)actionForMoBan:(id)sender {
    DXMessageMBViewController *mbVc = [[DXMessageMBViewController alloc] init];
    mbVc.selectBlock = ^(DXMessageMBModel *mbModel) {
        _messageTV.text = mbModel.content;
        [self textViewDidChange:_messageTV];
    };
    [self.navigationController pushViewController:mbVc animated:YES];
}
- (IBAction)actionForSend:(UIButton *)sender {
    if (_bushiyongBtn.selected) {
        if (_shuruMuArray.count == 0) {
            [SVProgressHUD showErrorWithStatus:@"发送数量必须大于0"];
            return;
        }
    }else{
        if (_selectMuArray.count == 0) {
            [SVProgressHUD showErrorWithStatus:@"发送数量必须大于0"];
            return;
        }
    }
    if ([Judge judgeStringIsEmpty:_qianmingTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"未填写短信签名，不能发送！"];
        return;
    }
    if ([Judge judgeStringIsEmpty:_messageTV.text]) {
        [SVProgressHUD showErrorWithStatus:@"未填写短信内容，不能发送！"];
        return;
    }
    if (_bushiyongBtn.selected) {
        NSArray *strAr = [_shoudongshuruTV.text componentsSeparatedByString:@","];
        for (NSString *str in strAr) {
            if (![Judge judgeStringIsEmpty:str]&&![str isEqualToString:@","]) {
                if (![Judge judgePhoneNumber:str]) {
                    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"'%@'不是有效的手机号！",str]];
                    return;
                }
            }
        }
    }
    NSString *alertMessage = @"";
    if (_shiyongBtn.selected) {
        alertMessage = [NSString stringWithFormat:@"号码个数:%ld个\n短信条数:%d条\n当前余额:%.2lf\n发送后余额:%.2lf\n\n是否真的要发送",_selectMuArray.count,[_zonggongLB.text integerValue]>70?2:1,[[UserManger shareManger].amount floatValue],[[UserManger shareManger].amount floatValue] - 0.12 * _selectMuArray.count];
    }else{
        alertMessage = [NSString stringWithFormat:@"号码个数:%ld个\n短信条数:%d条\n当前余额:%.2lf\n发送后余额:%.2lf\n\n是否真的要发送",_shuruMuArray.count,[_zonggongLB.text integerValue]>70?2:1,[[UserManger shareManger].amount floatValue],[[UserManger shareManger].amount floatValue] - 0.12 * _shuruMuArray.count];
    }
    [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
        if (buttonIndex ==1) {
            if (_viewType == shanxinType) {
                [self submitShanxin];
            }else{
                [self submitSMS];
            }
        }
    } title:@"注意" message:alertMessage cancelButtonName:@"取消" otherButtonTitles:@"确定", nil];
//
}
- (IBAction)actionForShanxinSign:(UIButton *)sender {
    DXSignListViewController *signListVC = [[DXSignListViewController alloc] init];
    signListVC.signBlock = ^(NSString *blockString) {
        _qianmingTF.text = blockString;
        [self actionForSignTF:_qianmingTF];
    };
    [self.navigationController pushViewController:signListVC animated:YES];
}
#pragma mark - TextviewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"手动输入号码并用英文逗号分隔"]&&(textView == _shoudongshuruTV)) {
        textView.text = @"";
        textView.textColor = HEX_COLOR(0x333333);
    }
}
-(void)textViewDidChange:(UITextView *)textView{
    if (textView == _shoudongshuruTV) {
        [self forMatterShuruArray];
    }else if(textView == _messageTV){
        [self updateZishuLabel];
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if([textView.text isEqualToString:@""]&&(textView == _shoudongshuruTV)){
        textView.text = @"手动输入号码并用英文逗号分隔";
        textView.textColor = HEX_COLOR(0x999999);
    }
}
@end
