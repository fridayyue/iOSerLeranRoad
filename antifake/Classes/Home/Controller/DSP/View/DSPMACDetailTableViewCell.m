//
//  DSPMACDetailTableViewCell.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/27.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DSPMACDetailTableViewCell.h"

@interface DSPMACDetailTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *staLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;

@end

@implementation DSPMACDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
-(void)configCell:(DSPMACDetailModel *)cellModel{
    _staLB.text = cellModel.sta;
    _timeLB.text = [NSString stringWithFormat:@"探测时间\t%@",cellModel.time];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
