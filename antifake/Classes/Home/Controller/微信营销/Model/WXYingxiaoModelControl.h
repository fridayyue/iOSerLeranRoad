//
//  WXYingxiaoModelControl.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/17.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXFunModel.h"
#import "WXQueryFileListModel.h"

@interface WXYingxiaoModelControl : NSObject
+(void)getFunSelectArray:(NSDictionary *)paramtar
                 success:(void(^)(NSArray *dataArry))success
                 failure:(void(^)(NSError *error))failure;

+(void)getqueryFileList:(NSDictionary *)paramtar
                success:(void(^)(NSArray *dataArray))success
                failure:(void(^)(NSError *error))failure;
+(void)uploadFile:(NSDictionary *)paramtar
         progress:(void(^)(NSProgress *progress))progressBlock
          success:(void(^)(NSString *data))success
          failure:(void(^)(NSError *error))failure;

+(void)deleteFile:(NSDictionary *)paramtar
          success:(void(^)(NSString *data))success
          failure:(void(^)(NSError *error))failure;
@end
