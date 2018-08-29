//
//  ZFShopListCell.h
//  antifake
//
//  Created by Zach on 2018/5/7.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZFShopListModel;

@interface ZFShopListCell : UITableViewCell

@property (nonatomic, strong) ZFShopListModel *model;

@property (weak, nonatomic) IBOutlet UILabel *eqAmount;

@property (weak, nonatomic) IBOutlet UIImageView *arrowImge;
@end
