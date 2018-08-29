//
//  DSPMACTableViewCell.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/27.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DSPMACTableViewCell.h"

@interface DSPMACTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *myTitleLB;
@end

@implementation DSPMACTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
-(void)configCell:(DSPMACModel *)cellModel{
    _myTitleLB.text = cellModel.equipmentName;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    _myTitleLB.textColor = selected ? HEX_COLOR(0x0e86ff) : HEX_COLOR(0x333333);
}

@end
