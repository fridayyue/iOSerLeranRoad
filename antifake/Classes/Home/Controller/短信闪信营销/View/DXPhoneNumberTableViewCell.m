//
//  DXPhoneNumberTableViewCell.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/23.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DXPhoneNumberTableViewCell.h"
#import "XTTimeDateManger.h"

@interface DXPhoneNumberTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *msisdnLB;
@property (weak, nonatomic) IBOutlet UILabel *macLB;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLB;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@end

@implementation DXPhoneNumberTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)configCell:(DXShaiXuanModel *)shaixuanModel{
    _msisdnLB.text = [Help phoneNumberSecret:shaixuanModel.msisdn];
    _macLB.text = [NSString stringWithFormat:@"MAC   %@",shaixuanModel.mac];
    _orderNoLB.text = [NSString stringWithFormat:@"查询时间  %@",[XTTimeDateManger getDateStringWithTimeStr:shaixuanModel.orderNo]];
    _selectBtn.selected = shaixuanModel.select;
}
@end
