//
//  BillModelControl.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/24.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BillModelControl.h"

@implementation BillModelControl
+(void)getConsumerList:(NSDictionary *)paramtar
               success:(void (^)(NSArray *))success
               failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_consumerList paramaters:paramtar  succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            NSArray *data = [respond objectForKey:@"data"];
            success(data);
        }else{
            failure(nil);
        }
    } failure:^(NSError *error, NSInteger stauts) {
        failure(error);
    }];
}
@end
