//
//  DataCenterModelControl.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/12.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DataCenterModelControl.h"

@implementation DataCenterModelControl
+(void)getBigDataByTerm:(id)paramtar
                success:(void (^)(NSArray *))success
                 faiure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_getBigDataByTerm paramaters:paramtar succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            success([[respond objectForKey:@"data"] objectForKey:@"data"]);
        }
    } failure:^(NSError *error, NSInteger stauts) {
        
    }];
}
+(void)getPhoneProvide:(id)paramtar
               success:(void (^)(DataCenterJingzhunDetailModel *))success
                faiure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_phoneProvide paramaters:paramtar succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            DataCenterJingzhunDetailModel *model = [[DataCenterJingzhunDetailModel alloc] initWithDictionary:[respond objectForKey:@"data"] error:nil];
            success(model);
        }else{
            failure(nil);
        }
    } failure:^(NSError *error, NSInteger stauts) {
        
    }];
}
+(void)getCallDeta:(NSDictionary *)paramtar success:(void (^)(NSString *))success faiure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_call paramaters:paramtar    succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            NSString *data = [respond objectForKey:@"virtualMobile"];
            success(data);
        }else{
            failure(nil);
        }
    } failure:^(NSError *error, NSInteger stauts) {
        failure(error);
    }];
}
@end
