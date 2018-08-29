//
//  DXShaiXuanModel.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/23.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicJsonModel.h"

@interface DXShaiXuanModel : BasicJsonModel
@property (nonatomic, copy) NSString * mac;
@property (nonatomic, copy) NSString * msg;
@property (nonatomic, copy) NSString * msisdn;
@property (nonatomic, copy) NSString * orderNo;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, copy) NSString * time;
@property (nonatomic, copy) NSString * user_id;
@property (nonatomic, assign) NSInteger xxCount;
@property(nonatomic,assign)BOOL select;

@end
