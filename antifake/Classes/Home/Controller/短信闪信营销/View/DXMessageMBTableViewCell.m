//
//  DXMessageMBTableViewCell.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/24.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DXMessageMBTableViewCell.h"

@interface DXMessageMBTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property (weak, nonatomic) IBOutlet UILabel *submitTimeLB;

@end

@implementation DXMessageMBTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)configCellModel:(DXMessageMBModel *)cellModel{
    _nameLabel.text = cellModel.name;
    _contentLB.text = cellModel.content;
    _submitTimeLB.text = cellModel.submitTime;
}
@end
