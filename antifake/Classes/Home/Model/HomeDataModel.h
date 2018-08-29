//
//  HomeDataModel.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/13.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicJsonModel.h"

@interface HomeDataModel : BasicJsonModel
/**< token */
@property (nonatomic,copy) NSString *id;

/**< 今日客户统计总人数 */
@property (nonatomic,copy) NSString *tdPopulation;

/**< 流动客户 */
@property (nonatomic,copy) NSString *flowNum;

/**< 暂留客户 */
@property (nonatomic,copy) NSString *persistanceNum;

/**< 常驻客户 */
@property (nonatomic,copy) NSString *residentNum;

/**< 当前新增 */
@property (nonatomic,copy) NSString *nowAddNum;

/**< 今日全部花费 */
@property (nonatomic,assign) CGFloat tdTotalCost;

/**< 微信花费 */
@property (nonatomic,assign) CGFloat wxTotalCost;

/**< 电话花费 */
@property (nonatomic,assign) CGFloat dhTotalCost;

/**< 短信花费 */
@property (nonatomic,assign) CGFloat dxTotalCost;

/**< 闪信花费 */
@property (nonatomic,assign) CGFloat sxTotalCost;

/**
 查询花费

 */
@property(nonatomic,assign)CGFloat cxTotalCost;
@property(nonatomic,assign)CGFloat dspTotalCost;

/**
 设备
 */
@property(nonatomic,copy)NSString* equipmentNum;

/**
 会员
 */
@property(nonatomic,copy)NSString* customCount;

/**
 文件夹
 */
@property(nonatomic,copy)NSString* coustomGroupNum;

@end
