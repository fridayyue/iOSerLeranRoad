//
//  StatementTableViewCell.h
//  antifake
//
//  Created by 岳腾飞 on 2018/7/4.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatementSMSModel.h"
#import "StatementFlashSmsModel.h"
#import "StatementCallLogListModel.h"

@interface StatementTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property (weak, nonatomic) IBOutlet UILabel *commitTimeLB;
@property (weak, nonatomic) IBOutlet UILabel *checkStateLB;
@property (weak, nonatomic) IBOutlet UIImageView *imagView;
-(void)configCellSMS:(StatementSMSModel *)model;
-(void)configCellFS:(StatementFlashSmsModel *)model;
-(void)configCellCALL:(StatementCallLogListModel *)model;
@end
