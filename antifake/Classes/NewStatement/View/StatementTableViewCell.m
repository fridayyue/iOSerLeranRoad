//
//  StatementTableViewCell.m
//  antifake
//
//  Created by 岳腾飞 on 2018/7/4.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "StatementTableViewCell.h"

@implementation StatementTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)configCellSMS:(StatementSMSModel *)model{
    _imagView.image = [UIImage imageNamed:@"Statement_message.png"];
    _contentLB.text = model.content;
    _commitTimeLB.text = [NSString stringWithFormat:@"创建时间:%@",model.commitTime];
    _checkStateLB.text = model.checkState == 1?@"已完成":@"审核被驳回";
    _checkStateLB.textColor = model.checkState == 1?HEX_COLOR(0x1E86FB):HEX_COLOR(0xff4040);
}
-(void)configCellFS:(StatementFlashSmsModel *)model{
    _imagView.image = [UIImage imageNamed:@"Statement_shanXin.png"];
    _contentLB.text = model.content;
    _commitTimeLB.text = [NSString stringWithFormat:@"创建时间:%@",model.commitTime];
    _checkStateLB.text = model.checkState == 1?@"已完成":@"审核被驳回";
    _checkStateLB.textColor = model.checkState == 1?HEX_COLOR(0x1E86FB):HEX_COLOR(0xff4040);
}
-(void)configCellCALL:(StatementCallLogListModel *)model{
    _imagView.image = [UIImage imageNamed:@"Statement_phone.png"];
    _contentLB.text = [Help phoneNumberSecret:model.virtualMobile];
    _commitTimeLB.text = [NSString stringWithFormat:@"通话时长:%ld\n结束时间:%@",model.callTime,model.callEnd];
    _checkStateLB.text = model.STATUS == 0?@"已通话":@"未通话";
    _checkStateLB.textColor = model.STATUS == 0?HEX_COLOR(0x1E86FB):HEX_COLOR(0xff4040);
}
@end
