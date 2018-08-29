//
//  MeitiTableViewCell.h
//  antifake
//
//  Created by 岳腾飞 on 2018/7/1.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeiTiModel.h"

@interface MeitiTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *media_nameLB;
-(void)configCell:(MeiTiModel *)cellModel;
@end
