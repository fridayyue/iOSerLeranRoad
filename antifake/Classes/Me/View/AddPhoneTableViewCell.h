//
//  AddPhoneTableViewCell.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/12.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPhoneModel.h"

@interface AddPhoneTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleBtn;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumbeTF;
-(void)configCellWithModel:(AddPhoneModel *)addPhoneModel;
@end
