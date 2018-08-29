//
//  AddPhoneTableViewCell.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/12.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "AddPhoneTableViewCell.h"

@implementation AddPhoneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)configCellWithModel:(AddPhoneModel *)addPhoneModel{
    _phoneNumbeTF.text = [Help phoneNumberSecret:addPhoneModel.anum];
    _selectBtn.selected =  [[UserManger shareManger].morenPhone isEqualToString:addPhoneModel.anum];
}
@end
