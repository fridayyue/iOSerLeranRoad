//
//  StatementFlashSmsModel.h
//  antifake
//
//  Created by 岳腾飞 on 2018/7/4.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicJsonModel.h"

@interface StatementFlashSmsModel : BasicJsonModel
@property (nonatomic, assign) long checkState;
@property (nonatomic, copy) NSString * commitTime;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, assign) long id;
@property (nonatomic, copy) NSString * orderNum;
@property (nonatomic, copy) NSString * remark;
@property (nonatomic, copy) NSString* sendFalseNum;
@property (nonatomic, copy) NSString* sendNum;
@property (nonatomic, assign) long sendState;
@property (nonatomic, copy) NSString * sendtime;
@property (nonatomic, assign) float total_amount;
@property (nonatomic, copy) NSString * user_id;
@end
