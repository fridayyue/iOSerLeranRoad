//
//  ZFMeListCell.m
//  happymoney
//
//  Created by chengRui on 2017/10/9.
//  Copyright © 2017年 AW. All rights reserved.
//

#import "ZFMeListCell.h"

#import "ZFSettingDataModel.h"

//#import "ZFSettingDataModel.h"

@interface ZFMeListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;



@property (weak, nonatomic) IBOutlet UIImageView *arrow;

@end

@implementation ZFMeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setModel:(ZFSettingDataModel *)model
{
    
    _model = model;
    
//    self.arrowImage.hidden = NO;
    
    // 1.设置icon
    self.iconView.image = [UIImage imageNamed:model.icon];
//    ZFLog(@"图片==========%@", model.icon);
    
    // 2.设置title
    self.nameLabel.text = model.title;
    
    if ([self.nameLabel.text isEqualToString:@"店铺管理"]) {
        self.detailLabel.text = @"已有3家店铺";
        self.detailLabel.hidden = NO;
    }
    
    if ([self.nameLabel.text isEqualToString:@"客服热线"]) {
        
        self.arrow.hidden = YES;
        self.detailLabel.hidden = NO;
//        self.detailLabel.text = @"400-0608-002";
    }
    
    
    // 3.设置版本信息——>判断
//    if ([model.title isEqualToString:@"应用版本"]) {
//        self.versionLabel.text = [NSString stringWithFormat:@"v%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
//        self.arrowImage.hidden = YES;
//    }
    
    
    
}
//
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
