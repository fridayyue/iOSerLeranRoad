//
//  MeModelControl.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/12.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetVocodeModel.h"

@interface MeModelControl : NSObject
+(void)getsmsCode:(id)paratmtar
          success:(void (^)(GetVocodeModel *vodeModel))success
          failure:(void (^)(NSError *error))failure;
+(void)getPhoneList:(id)paramtar
            success:(void (^)(NSArray * dataArray))success
            failure:(void (^)(NSError * error))failure;
+(void)addPhone:(id)paramtar
        success:(void (^)(NSDictionary * dic))success
        failure:(void (^)(NSError * error))failure;
+(void)delegatePhone:(id)paramtar
             success:(void (^)(NSDictionary * dic))success
             failure:(void (^)(NSError * error))failure;
@end
