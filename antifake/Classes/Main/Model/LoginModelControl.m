//
//  LoginModelControl.m
//  antifake
//
//  Created by 岳腾飞 on 2018/5/28.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "LoginModelControl.h"

@implementation LoginModelControl
+(void)loginWith:(id)paratmtar
         success:(void (^)(LoginModel *))success
         failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_Login paramaters:paratmtar succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            LoginModel *loginModel = [[LoginModel alloc] initWithDictionary:[respond objectForKey:@"data"] error:nil];
            [[UserManger shareManger] userLogin:loginModel];
            success(loginModel);
        }else{
            
            failure(nil);
        }
        
    } failure:^(NSError *error, NSInteger stauts) {
        failure(error);
    }];
}
+(void)getsmsCode:(id)paratmtar
          success:(void (^)(GetVocodeModel *))success
          failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_GetVcode paramaters:paratmtar succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            GetVocodeModel *gevcodeModel = [[GetVocodeModel alloc] initWithDictionary:respond error:nil];
            success(gevcodeModel);
        }else{
            failure(nil);
        }
    } failure:^(NSError *error, NSInteger stauts) {
        failure(error);
    }];
}
+(void)getFogetPWDsmsCode:(id)paramtar
                  success:(void (^)(GetVocodeModel *))success
                  failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_GetVcode2 paramaters:paramtar succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            GetVocodeModel *vcodeModel = [[GetVocodeModel alloc] initWithDictionary:respond error:nil];
            success(vcodeModel);
        }else{
            failure(nil);
        }
    } failure:^(NSError *error, NSInteger stauts) {
        failure(error);
    }];
}
+ (void)vertifyVcode:(id)paramtar success:(void (^)(void))success failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_Verifi_Code paramaters:paramtar succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            success();
        }else{
            failure(nil);
        }
    } failure:^(NSError *error, NSInteger stauts) {
        failure(error);
    }];
}
+(void)registerUser:(id)paramtar
            success:(void (^)(void))success
            failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_RegistUser paramaters:paramtar succeed:^(id respond, NSInteger status) {
        if (status == 1) {
                success();
        }else{
            failure(nil);
        }
    } failure:^(NSError *error, NSInteger stauts) {
        failure(error);
    }];
}
+(void)fogetLoginPwd:(id)paramtar
             success:(void (^)(void))success
             failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_FogetLooinPWD paramaters:paramtar succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            success();
        }else{
            failure(nil);
        }
    } failure:^(NSError *error, NSInteger stauts) {
        failure(error);
    }];
}
@end
