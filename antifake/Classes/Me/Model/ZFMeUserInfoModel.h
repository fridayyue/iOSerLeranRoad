//
//  ZFMeUserInfoModel.h
//  antifake
//
//  Created by Zach on 2018/5/11.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFMeUserInfoModel : NSObject

/**< 图标 */
@property (nonatomic, copy)NSString *last_login_time;

/**< 店铺名称 */
@property (nonatomic, copy) NSString *name;

/**< userid */
@property (nonatomic, copy)NSString *user_code;

/**< 店主姓名 */
@property (nonatomic, copy) NSString *grade;

/**< 店铺手机号 */
@property (nonatomic, copy)NSString *higher_id;

/**< 店员 */
@property (nonatomic, copy) NSString *state;

/**< 创建日期 */
@property (nonatomic, copy)NSString *phone;

/**< 创建日期 */
@property (nonatomic, copy)NSString *transaction_amount;

@end
