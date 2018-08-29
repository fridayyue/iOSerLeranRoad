//
//  LoginModel.h
//  antifake
//
//  Created by 岳腾飞 on 2018/5/28.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicJsonModel.h"

@interface LoginModel : BasicJsonModel
/**< token */
@property (nonatomic,copy) NSString *id;

/**< 通讯录认证状态 */
@property (nonatomic,copy) NSString *name;

/**< 通讯录 */
@property (nonatomic,copy) NSString *user_code;

/**< 头像 */
@property (nonatomic,copy) NSString *password;

/**< 姓名 */
@property (nonatomic,copy) NSString *grade;

/**< 电话号码 */
@property (nonatomic,copy) NSString *higher_id;

/**< 通讯录版本 */
@property (nonatomic,copy) NSString *state;

/**< 学校ID */
@property (nonatomic,copy) NSString *phone;

/**< 学校名称 */
@property (nonatomic,copy) NSString *last_login_time;

/**< 令牌token */
@property (nonatomic,copy) NSString *register_time;

/**< 令牌token */
@property (nonatomic,copy) NSString *mima;

/**< 令牌token */
@property (nonatomic,copy) NSString *transaction_amount;
@end
