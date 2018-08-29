//
//  LoginModelControl.h
//  antifake
//
//  Created by 岳腾飞 on 2018/5/28.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"
#import "GetVocodeModel.h"

@interface LoginModelControl : NSObject

/**
 登录
 */
+(void)loginWith:(id)paratmtar
         success:(void(^)(LoginModel *loginModel))success
         failure:(void(^)(NSError *error))failure;

/**
 获注册取短信验证码
 */
+(void)getsmsCode:(id)paratmtar
          success:(void(^)(GetVocodeModel *getVcodeModel))success
          failure:(void(^)(NSError *error))failure;
//获取忘记密码的验证码
+(void)getFogetPWDsmsCode:(id)paramtar
                  success:(void(^)(GetVocodeModel *vcodeModel))success
                  failure:(void(^)(NSError *error))failure;
/**
 验证短信是否正确
 */
+(void)vertifyVcode:(id)paramtar success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 注册用户
 */
+(void)registerUser:(id)paramtar success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 忘记、重置登录密码
 */
+(void)fogetLoginPwd:(id)paramtar success:(void(^)(void))success failure:(void(^)(NSError *error))failure;
@end
