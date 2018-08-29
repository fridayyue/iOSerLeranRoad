//
//  ZFEquipmentListCell.m
//  antifake
//
//  Created by Zach on 2018/5/7.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "ZFEquipmentListCell.h"

#import "ZFModieListModel.h"

@interface ZFEquipmentListCell ()

@property (weak, nonatomic) IBOutlet UILabel *eqNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@end

@implementation ZFEquipmentListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ZFModieListModel *)model
{
    
    _model = model;
    self.eqNameLabel.text = model.equipmentName;
    self.shopNameLabel.text = model.businessName;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
