//
//  MaodeiListModel.h
//  antifake
//
//  Created by 岳腾飞 on 2018/7/16.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicJsonModel.h"

@interface MaodeiListModel : BasicJsonModel

@property (nonatomic, strong) NSString * Modifier;
@property (nonatomic, copy) NSString * agent_id;
@property (nonatomic, assign) long bus_type;
@property (nonatomic, assign) long businessID;
@property (nonatomic, copy) NSString * businessName;
@property (nonatomic, copy) NSString * city;
@property (nonatomic, strong) NSString * collar_date;
@property (nonatomic, assign) long creatDate;
@property (nonatomic, copy) NSString * district;
@property (nonatomic, copy) NSString * equipmentName;
@property (nonatomic, assign) long id;
@property (nonatomic, strong) NSString * lat;
@property (nonatomic, strong) NSString * loaclArea;
@property (nonatomic, strong) NSString * lon;
@property (nonatomic, assign) long modiffDate;
@property (nonatomic, copy) NSString * province;
@property (nonatomic, strong) NSString * quuery;
@property (nonatomic, copy) NSString * sta;
@property (nonatomic, assign) long state;
@property (nonatomic, assign) long type;
@property (nonatomic, copy) NSString * user_id;

@end
