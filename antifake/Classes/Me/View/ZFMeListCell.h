//
//  ZFMeListCell.h
//  happymoney
//
//  Created by chengRui on 2017/10/9.
//  Copyright © 2017年 AW. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZFSettingDataModel;

@interface ZFMeListCell : UITableViewCell

@property (nonatomic, strong) ZFSettingDataModel *model;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end
