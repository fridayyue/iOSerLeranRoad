//
//  StatementCallLogListModel.h
//  antifake
//
//  Created by 岳腾飞 on 2018/7/4.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicJsonModel.h"

@interface StatementCallLogListModel : BasicJsonModel
@property (nonatomic, assign) long MID;
@property (nonatomic, copy) NSString * SIGN;
@property (nonatomic, assign) long STATUS;
@property (nonatomic, assign) long TIMESTAMP;
@property (nonatomic, copy) NSString * callAnswer;
@property (nonatomic, copy) NSString * callEnd;
@property (nonatomic, copy) NSString * callStart;
@property (nonatomic, assign) long callTime;
@property (nonatomic, assign) long call_;
@property (nonatomic, copy) NSString * dm;
@property (nonatomic, assign) float fee;
@property (nonatomic, copy) NSString * fm;
@property (nonatomic, copy) NSString * fmBlong;
@property (nonatomic, copy) NSString * hid;
@property (nonatomic, assign) long id;
@property (nonatomic, copy) NSString * noAnswerReason;
@property (nonatomic, copy) NSString * orderNo;
@property (nonatomic, copy) NSString * seqId;
@property (nonatomic, copy) NSString * tm;
@property (nonatomic, copy) NSString * tmBlong;
@property (nonatomic, copy) NSString * user_id;
@property (nonatomic, assign) long ux_id;
@property (nonatomic, copy) NSString * virtualMobile;
@end
