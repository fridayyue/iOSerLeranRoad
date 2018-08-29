//
//  DataCenterJingzhunDetailModel.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/13.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicJsonModel.h"
#import "JingzhunDetailResultModel.h"

@interface DataCenterJingzhunDetailModel : BasicJsonModel
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,copy)NSString* msg;
@property(nonatomic,strong)JingzhunDetailResultModel* result;

@end
