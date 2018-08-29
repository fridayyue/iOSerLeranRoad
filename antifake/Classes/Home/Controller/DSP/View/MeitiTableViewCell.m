//
//  MeitiTableViewCell.m
//  antifake
//
//  Created by 岳腾飞 on 2018/7/1.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "MeitiTableViewCell.h"

@implementation MeitiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
-(void)configCell:(MeiTiModel *)cellModel{
    _media_nameLB.text = cellModel.media_name;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
