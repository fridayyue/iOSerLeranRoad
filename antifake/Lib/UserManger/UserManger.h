//
//  UserManger.h
//  antifake
//
//  Created by 岳腾飞 on 2018/5/28.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"

@interface UserManger : NSObject
+(instancetype)shareManger;
@property(nonatomic,copy)NSString* morenPhone;
@property(nonatomic,copy)NSString* password;
@property(nonatomic,copy)NSString* amount;

/**
 获取用户登录状态
 */
-(BOOL)getLgoinStatus;

/**
 获取用户手机号
 */
-(NSString *)getUserPhone;
/**
 获取用户ID
 */
-(NSString *)getUserID;

/**
 用户登录

 @param loginModel 登录model
 */
-(void)userLogin:(LoginModel *)loginModel;

/**
 用户登出
 */
-(void)userLogout;
@end
