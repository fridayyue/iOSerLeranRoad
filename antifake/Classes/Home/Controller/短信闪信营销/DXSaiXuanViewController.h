//
//  DXSaiXuanViewController.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/23.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicViewController.h"

typedef void (^DXShaiXuanBlock)(NSDate *startDate,NSDate *endDate);

@interface DXSaiXuanViewController : BasicViewController
@property(nonatomic,strong)NSDate* defineStratDate;
@property(nonatomic,strong)NSDate* defineEndDate;
@property(nonatomic,copy)DXShaiXuanBlock shaiXuanBlock;

@end
