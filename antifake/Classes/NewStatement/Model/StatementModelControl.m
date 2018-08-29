//
//  StatementModelControl.m
//  antifake
//
//  Created by 岳腾飞 on 2018/7/4.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "StatementModelControl.h"

@implementation StatementModelControl
+(void)smsList:(NSDictionary *)paramtar
       success:(void (^)(NSArray *))success
       failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_smsList paramaters:paramtar succeed:^(id respond, NSInteger status) {
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
+(void)flashSmsList:(NSDictionary *)paramtar
            success:(void (^)(NSArray *))success
            failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_flashSmsList paramaters:paramtar succeed:^(id respond, NSInteger status) {
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
+(void)callLogList:(NSDictionary *)paramtar
           success:(void (^)(NSArray *))success
           failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_callLogList paramaters:paramtar succeed:^(id respond, NSInteger status) {
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
