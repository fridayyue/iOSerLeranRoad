//
//  DataCenterModel.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/12.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicJsonModel.h"

@interface DataCenterModel : BasicJsonModel
@property(nonatomic,copy)NSString* phoneNumber;
@property(nonatomic,copy)NSString* sex;
@property(nonatomic,copy)NSString* age;
@property(nonatomic,copy)NSString* place;
@property(nonatomic,copy)NSString* consumptionLevel;

@end
