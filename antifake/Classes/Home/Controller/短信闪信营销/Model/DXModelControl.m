//
//  DXModelControl.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/23.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DXModelControl.h"

@implementation DXModelControl
+(void)getChooseTelData:(NSDictionary *)paramtar
                success:(void (^)(NSArray *))success
                failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_chooseTel paramaters:paramtar  succeed:^(id respond, NSInteger status) {
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
+(void)getQuerySmsTemplate:(NSDictionary *)paramtar success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_querySmsTemplate paramaters:paramtar  succeed:^(id respond, NSInteger status) {
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
+(void)getDelSmsTemplate:(NSDictionary *)paramtar
                 success:(void (^)(NSString *))success
                 failure:(void (^)(NSError *))failure{
    
    [[NetWorking shareManger] postWithMethod:Net_delSmsTemplate paramaters:paramtar  succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            NSString *data = [respond objectForKey:@"data"];
            success(data);
        }else{
            failure(nil);
        }
    } failure:^(NSError *error, NSInteger stauts) {
        failure(error);
    }];
}
+(void)submitSmsTemplate:(NSDictionary *)paramtar
                 success:(void (^)(NSString *))success
                 failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_submitSmsTemplate paramaters:paramtar  succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            NSString *data = [respond objectForKey:@"data"];
            success(data);
        }else{
            failure(nil);
        }
    } failure:^(NSError *error, NSInteger stauts) {
        failure(error);
    }];
}
+(void)sms:(NSDictionary *)paramtar
   success:(void (^)(NSString *))success
   failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_sms paramaters:paramtar  succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            NSString *data = [respond objectForKey:@"data"];
            success(data);
        }else{
            failure(nil);
        }
    } failure:^(NSError *error, NSInteger stauts) {
        failure(error);
    }];
}
+(void)submitFlashSmsTemplate:(NSDictionary *)paramtar
                      success:(void (^)(NSString *))success
                      failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_flashSmsTemplate paramaters:paramtar  succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            NSString *data = [respond objectForKey:@"data"];
            success(data);
        }else{
            failure(nil);
        }
    } failure:^(NSError *error, NSInteger stauts) {
        failure(error);
    }];
}
+(void)getSignList:(NSDictionary *)paramtar
           success:(void (^)(NSArray *))success
           failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_signList paramaters:paramtar  succeed:^(id respond, NSInteger status) {
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
+(void)submitSign:(NSDictionary *)paramtar
          success:(void (^)(NSString *))success
          failure:(void (^)(NSError *, NSString *))failure{
    [[NetWorking shareManger] postWithMethod:Net_submitSign paramaters:paramtar  succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            NSString *data = [respond objectForKey:@"data"];
            success(data);
        }else{
            failure(nil,[respond objectForKey:@"msg"]);
        }
    } failure:^(NSError *error, NSInteger stauts) {
        failure(error,nil);
    }];
}
@end
