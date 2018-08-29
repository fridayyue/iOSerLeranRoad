//
//  ZFFareListModel.h
//  antifake
//
//  Created by Zach on 2018/5/13.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFFareListModel : NSObject

/**< 消费时间 */
@property (nonatomic, copy)NSString *gmt_payment;

/**< user_id */
@property (nonatomic, copy) NSString *user_id;

/**< 总金额 */
@property (nonatomic, copy)NSString *total_amount;

/**< 支付方式 */
@property (nonatomic, copy) NSString *payType;

/**< 店铺手机号 */
@property (nonatomic, copy)NSString *payMode;

/**< 店员 */
@property (nonatomic, copy) NSString *out_trade_no;

/**< 创建日期 */
@property (nonatomic, copy)NSString *trade_no;

/**< 创建日期 */
@property (nonatomic, copy)NSString *orderNum;

@end
