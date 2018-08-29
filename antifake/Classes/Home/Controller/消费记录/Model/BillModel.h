//
//  BillModel.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/24.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicJsonModel.h"

@interface BillModel : BasicJsonModel
@property (nonatomic, copy) NSString * gmt_payment;
@property (nonatomic, copy) NSString * orderNum;
@property (nonatomic, strong) NSString * out_trade_no;
@property (nonatomic, strong) NSString * payMode;
@property (nonatomic, copy) NSString * payType;
@property (nonatomic, assign) CGFloat total_amount;
@property (nonatomic, strong) NSString * trade_no;
@property (nonatomic, copy) NSString * user_id;
@end
