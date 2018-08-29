//
//  DXAddMBViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/24.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DXAddMBViewController.h"
#import "MyTextFiled.h"
#import "UIAlertView+Block.h"
#import "DXModelControl.h"

@interface DXAddMBViewController ()
<
    UITextViewDelegate
>
@property (weak, nonatomic) IBOutlet UITextView *shuruTV;
@property (weak, nonatomic) IBOutlet UILabel *yishuruLB;
@property (weak, nonatomic) IBOutlet UILabel *zonggongLB;
@property (weak, nonatomic) IBOutlet MyTextFiled *biaotiTF;
@property (weak, nonatomic) IBOutlet MyTextFiled *qianmingTF;
@property (weak, nonatomic) IBOutlet UILabel *qianmingLB;
@end

@implementation DXAddMBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)initView{
    self.title = @"新增模板";
    [self makeRightNavBtnTitle:@"提交"];
    _shuruTV.delegate = self;
}
#pragma mark - Net
-(void)addMB{
//    token    5a1fd0a3-894e-4628-aebd-e3fe142701f2
    NSDictionary *paramtar = @{
                               @"name":_biaotiTF.text,
                               @"sign":_qianmingLB.text,
                               @"endText":@"退订回T",
                               @"content":_shuruTV.text,
                               @"token":[UserManger shareManger].getUserID
                               };
    [DXModelControl submitSmsTemplate:paramtar success:^(NSString *str) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            if (_addBlock) {
                _addBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        } title:@"注意" message:@"提交成功！" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - Action
-(void)actionForRightBtn:(id)sender{
    if ([Judge judgeStringIsEmpty:_biaotiTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入模板标题！"];
        return;
    }
    if ([Judge judgeStringIsEmpty:_qianmingTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输短信签名！"];
        return;
    }
    if ([Judge judgeStringIsEmpty:_shuruTV.text] || [_shuruTV.text isEqualToString:@"请输入详细内容"]) {
        [SVProgressHUD showErrorWithStatus:@"请输短信详细内容！"];
        return;
    }
    [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [self addMB];
        }
    } title:@"注意" message:@"确定要提交该模板么？" cancelButtonName:@"取消" otherButtonTitles:@"确定", nil];
}
- (IBAction)biaotiTFChanged:(UITextField *)sender {
    
}
- (IBAction)qianmingTFChanged:(UITextField *)sender {
    _qianmingLB.text = [NSString stringWithFormat:@"【%@】",sender.text];
    [self updateZishuLabel];
}
-(void)updateZishuLabel{
    NSInteger shuru = [_shuruTV.text isEqualToString:@"请输入详细内容"]?0: _shuruTV.text.length;

    NSInteger zonggong = 4 + shuru +_qianmingLB.text.length;
    _yishuruLB.text = [NSString stringWithFormat:@"%ld",shuru];
    _zonggongLB.text = [NSString stringWithFormat:@"%ld",zonggong];
}
#pragma mark - TextviewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"请输入详细内容"]) {
        textView.text = @"";
        textView.textColor = HEX_COLOR(0x333333);
    }
}
-(void)textViewDidChange:(UITextView *)textView{
    [self updateZishuLabel];
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if([textView.text isEqualToString:@""]){
        textView.text = @"请输入详细内容";
        textView.textColor = HEX_COLOR(0x999999);
    }
}
@end
