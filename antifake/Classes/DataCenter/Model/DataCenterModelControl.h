//
//  DataCenterModelControl.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/12.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataCenterJingzhunDetailModel.h"

@interface DataCenterModelControl : NSObject
//http://flb.huarenpay.com/app/getBigDataByTerm
+(void)getBigDataByTerm:(id)paramtar
                success:(void(^)(NSArray *dataArray))success
                 faiure:(void(^)(NSError *error))failure;

+(void)getPhoneProvide:(id)paramtar
               success:(void(^)(DataCenterJingzhunDetailModel *dataModel))success
                faiure:(void(^)(NSError *error))failure;
+(void)getCallDeta:(NSDictionary *)paramtar
           success:(void(^)(NSString *phone))success
            faiure:(void(^)(NSError *error))failure;
@end
