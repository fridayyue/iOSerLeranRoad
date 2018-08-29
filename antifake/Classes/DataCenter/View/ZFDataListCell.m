//
//  ZFDataListCell.m
//  antifake
//
//  Created by Zach on 2018/5/7.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "ZFDataListCell.h"

#import "ZFMacNumberListModel.h"

@interface ZFDataListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *macNumnerLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end

@implementation ZFDataListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setModel:(ZFMacNumberListModel *)model
{
    self.macNumnerLabel.text = model.mac;
    self.timeLabel.text = model.time;
//    self.macNumnerLabel.text = model.mac;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
