//
//  FunSelectTableViewCell.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/17.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "FunSelectTableViewCell.h"

@implementation FunSelectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
