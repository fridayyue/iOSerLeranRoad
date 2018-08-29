//
//  BillTableViewCell.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/24.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BillTableViewCell.h"
#import "NSString+CustomString.h"

@interface BillTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *orderNumLB;
@property (weak, nonatomic) IBOutlet UILabel *gmt_paymentLB;
@property (weak, nonatomic) IBOutlet UILabel *total_amountLB;

@end

@implementation BillTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)configCell:(BillModel *)billModel{
    NSString *type = @"";
    if ([billModel.payType isEqualToString:@"adv"]) {
        type = [NSString stringWithFormat:@"其他-%@",billModel.orderNum];
    }else if ([billModel.payType isEqualToString:@"sms"]){
        type = [NSString stringWithFormat:@"短信消费-%@",billModel.orderNum];
    }else if ([billModel.payType isEqualToString:@"call"]){
        type = [NSString stringWithFormat:@"电话花费-%@",billModel.orderNum];
    }else if ([billModel.payType isEqualToString:@"flashSms"]){
        type = [NSString stringWithFormat:@"闪信花费-%@",billModel.orderNum];
    }else if ([billModel.payType isEqualToString:@"matching"]){
        type = [NSString stringWithFormat:@"查询消费-%@",billModel.orderNum];
    }else if ([billModel.payType isEqualToString:@"pay"]){
        type = @"充值";
    }else{
         type = [NSString stringWithFormat:@"其他-%@",billModel.orderNum];
    }
    _orderNumLB.text = type;
    _gmt_paymentLB.text = billModel.gmt_payment;
    _total_amountLB.text = [type isEqualToString:@"充值"]?[NSString stringWithFormat:@"+%@",[NSString floatFormatterString:billModel.total_amount]]:[NSString stringWithFormat:@"-%.2lf",billModel.total_amount];
}
@end
