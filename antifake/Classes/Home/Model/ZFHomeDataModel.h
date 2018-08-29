//
//  ZFHomeDataModel.h
//  antifake
//
//  Created by Zach on 2018/5/11.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFHomeDataModel : NSObject

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
@property (nonatomic,copy) NSString *tdTotalCost;

/**< 微信花费 */
@property (nonatomic,copy) NSString *wxTotalCost;

/**< 电话花费 */
@property (nonatomic,copy) NSString *dhTotalCost;

/**< 短信花费 */
@property (nonatomic,copy) NSString *dxTotalCost;

/**< 闪信花费 */
@property (nonatomic,copy) NSString *sxTotalCost;


@end
