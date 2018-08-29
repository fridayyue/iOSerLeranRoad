//
//  ZFFareListCell.h
//  antifake
//
//  Created by Zach on 2018/5/12.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZFFareListModel;

@interface ZFFareListCell : UITableViewCell

@property (nonatomic, strong) ZFFareListModel *model;

@property (weak, nonatomic) IBOutlet UILabel *fareNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *dataLabel;

@property (weak, nonatomic) IBOutlet UILabel *fareLabel;

@end
