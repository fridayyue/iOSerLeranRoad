//
//  StatementSMSDetailViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/7/4.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "StatementSMSDetailViewController.h"
#import "StatementErrorViewController.h"

@interface StatementSMSDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *statusImg;

@property (weak, nonatomic) IBOutlet UILabel *statusLB;
@property (weak, nonatomic) IBOutlet UILabel *sendNumLB;
@property (weak, nonatomic) IBOutlet UILabel *successTitleLB;
@property (weak, nonatomic) IBOutlet UILabel *faildTitleLB;

@property (weak, nonatomic) IBOutlet UILabel *fild;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property (weak, nonatomic) IBOutlet UILabel *fugairenshuLB;
@property (weak, nonatomic) IBOutlet UILabel *fasongliangLB;
@property (weak, nonatomic) IBOutlet UILabel *shijihuafreiLB;
@property (weak, nonatomic) IBOutlet UILabel *chuangjianshijianLB;
@property (weak, nonatomic) IBOutlet UILabel *fasongshijianLB;

@property (weak, nonatomic) IBOutlet UIButton *reasonBtn;
@end

@implementation StatementSMSDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)initView{
    NSString *type;
    if (_viewType == smsType) {
        type = @"短信";
        _contentLB.text = _smsModel.content;
        _sendNumLB.text = _smsModel.sendNum;
        if (_smsModel.checkState != 1) {
            _statusLB.text = @"审核被驳回";
            [_statusImg setImage:[UIImage imageNamed:@"Statement_Cuo"]];
            _sendNumLB.hidden = YES;
            _successTitleLB.hidden = YES;
            _faildTitleLB.hidden = YES;
            _fild.hidden = YES;
            _reasonBtn.hidden = NO;
        }
        _fugairenshuLB.text = [NSString stringWithFormat:@"%@人",_smsModel.sendNum];
        _fasongliangLB.text = [NSString stringWithFormat:@"%@条",_smsModel.sendNum];
        _shijihuafreiLB.text = [NSString stringWithFormat:@"%.2lf元",_smsModel.total_amount];
        _chuangjianshijianLB.text = _smsModel.commitTime;
        _fasongshijianLB.text = _smsModel.sendtime;
    }else if (_viewType == fashType){
        type = @"闪信";
        _sendNumLB.text = _fashModel.sendNum;
        _fild.text = _fashModel.sendFalseNum;
        _contentLB.text = _fashModel.content;
        if (_fashModel.checkState != 1) {
            [_statusImg setImage:[UIImage imageNamed:@"Statement_Cuo"]];
            _statusLB.text = @"审核被驳回";
            _sendNumLB.hidden = YES;
            _successTitleLB.hidden = YES;
            _faildTitleLB.hidden = YES;
            _fild.hidden = YES;
            _reasonBtn.hidden = NO;
        }
        _fugairenshuLB.text = [NSString stringWithFormat:@"%@人",_fashModel.sendNum];
        _fasongliangLB.text = [NSString stringWithFormat:@"%@条",_fashModel.sendNum];
        _shijihuafreiLB.text = [NSString stringWithFormat:@"%.2lf元",_fashModel.total_amount];
        _chuangjianshijianLB.text = _fashModel.commitTime;
        _fasongshijianLB.text = _fashModel.sendtime;
    }
    self.title = [NSString stringWithFormat:@"%@%@",type,_smsModel.orderNum];
}
- (IBAction)actionForReason:(UIButton *)sender {
    StatementErrorViewController *errorVC = [[StatementErrorViewController alloc] init];
    errorVC.remark = _viewType == smsType ? _smsModel.remark:_fashModel.remark;
    [self.navigationController pushViewController:errorVC animated:YES];
}
@end
