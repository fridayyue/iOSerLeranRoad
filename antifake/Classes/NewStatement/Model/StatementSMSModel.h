//
//  StatementSMSModel.h
//  antifake
//
//  Created by 岳腾飞 on 2018/7/4.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicJsonModel.h"

@interface StatementSMSModel : BasicJsonModel
@property (nonatomic, assign) NSInteger checkState;
@property (nonatomic, copy) NSString * commitTime;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, assign) long id;
@property (nonatomic, copy) NSString * orderNum;
@property (nonatomic, copy) NSString * remark;
@property (nonatomic, copy) NSString* sendNum;
@property (nonatomic, assign) long sendState;
@property (nonatomic, copy) NSString * sendtime;
@property (nonatomic, assign) long state;
@property (nonatomic, assign) long template_id;
@property (nonatomic, assign) float total_amount;
@property (nonatomic, assign) long type;
@property (nonatomic, copy) NSString * user_id;
@end
