//
//  NetWorking.h
//  DaiFuBao
//
//  Created by Liu Hui on 2018/5/14.
//  Copyright © 2018年 come.daifubao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorking : NSObject
+(instancetype)shareManger;
/**
 接口请求方法
 
 @param methodString 具体请求的方法名
 @param hostURL Host,默认是默认HOST
 @param parameters 参数，可以为空，默认会是@{}
 @param isEncoding 是否编码加密，默认是YES
 @param waitTime 请求等待时间，默认为60s
 @param succeed 成功回调，返回成功请求体，请求状态
 @param failure 失败回调，返回error，请求状态
 */
-(void)postWithMethod:(NSString *)methodString
              hostURL:(NSString *)hostURL
           paramaters:(id)parameters
           isEncoding:(BOOL )isEncoding
     waitTimeInterval:(NSTimeInterval)waitTime
             progress:(void(^)(NSProgress *progress))progressBlock
              succeed:(void (^) (id respond,NSInteger status))succeed
              failure:(void (^)(NSError *error,NSInteger stauts))failure;

/**
 接口请求方法(简写，如无特殊参数建议使用这个)
 
 @param methodString 具体请求的方法名
 @param parameters 参数，可以为空，默认会是@{}
 @param succeed 成功回调，返回成功请求体，请求状态
 @param failure 失败回调，返回error，请求状态
 */
-(void)postWithMethod:(NSString *)methodString
           paramaters:(id)parameters
              succeed:(void (^) (id respond,NSInteger status))succeed
              failure:(void (^)(NSError *error,NSInteger stauts))failure;

-(void)postWithMethod:(NSString *)methodString
           paramaters:(id)parameters
             progress:(void(^)(NSProgress *progress))progressBlock
              succeed:(void (^) (id respond,NSInteger status))succeed
              failure:(void (^)(NSError *error,NSInteger stauts))failure;
@end
