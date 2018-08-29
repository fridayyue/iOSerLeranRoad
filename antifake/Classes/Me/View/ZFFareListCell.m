//
//  ZFFareListCell.m
//  antifake
//
//  Created by Zach on 2018/5/12.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "ZFFareListCell.h"

#import "ZFFareListModel.h"

@implementation ZFFareListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ZFFareListModel *)model
{
    
    _model = model;

    NSString *payType = @"";
    NSString *fare = @"";
    if ([model.payType isEqualToString:@"flashSms"]){
        
        payType = @"闪信花费";
        fare = [NSString stringWithFormat:@"- %@", model.total_amount];
        
    }else if ([model.payType isEqualToString:@"pay"]){
        
        payType = @"充值";
        fare = [NSString stringWithFormat:@"+ %@", model.total_amount];
        
    }else if ([model.payType isEqualToString:@"sms"]){
        
//        payType = [NSString stringWithFormat:@"短信消费-%@", model.orderNum];
        payType= @"短信消费";
        fare = [NSString stringWithFormat:@"- %@", model.total_amount];
    }
    
    self.fareNameLabel.text = payType;
    self.fareLabel.text = fare;
    self.dataLabel.text = model.gmt_payment;
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
