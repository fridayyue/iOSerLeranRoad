//
//  ZFLoginModel.h
//  happymoney
//
//  Created by chengRui on 2017/10/24.
//  Copyright © 2017年 AW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFLoginModel : NSObject

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




/************ 储存数据 ************/
- (BOOL)saveData;




/************ 删除数据 ************/
- (BOOL)delateData;




/************ 解档取出数据 ************/
+ (instancetype)unarchiveDataFromSandBox;








@end
