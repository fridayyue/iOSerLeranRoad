//
//  ZFShopListCell.m
//  antifake
//
//  Created by Zach on 2018/5/7.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "ZFShopListCell.h"

#import "ZFShopListModel.h"

@interface ZFShopListCell ()
@property (weak, nonatomic) IBOutlet UILabel *shopName;

@property (weak, nonatomic) IBOutlet UILabel *placeName;

@end

@implementation ZFShopListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(ZFShopListModel *)model
{
    
    self.shopName.text = model.businessName;
    self.placeName.text = model.bus_site;
    self.eqAmount.text = [NSString stringWithFormat:@"%@个设备", model.maodieNum];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
