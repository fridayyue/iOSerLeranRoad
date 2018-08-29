//
//  DXMessageMBTableViewCell.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/24.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXMessageMBModel.h"

@interface DXMessageMBTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
-(void)configCellModel:(DXMessageMBModel *)cellModel;
@end
