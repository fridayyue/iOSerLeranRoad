//
//  BillTableViewCell.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/24.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillModel.h"

@interface BillTableViewCell : UITableViewCell
-(void)configCell:(BillModel *)billModel;
@end
