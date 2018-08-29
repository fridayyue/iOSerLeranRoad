//
//  ZFShopListModel.h
//  antifake
//
//  Created by Zach on 2018/5/11.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFShopListModel : NSObject

/**< 图标 */
@property (nonatomic, copy)NSString *id;

/**< 店铺名称 */
@property (nonatomic, copy) NSString *businessName;

/**< userid */
@property (nonatomic, copy)NSString *user_id;

/**< 店主姓名 */
@property (nonatomic, copy) NSString *managerName;

/**< 店铺手机号 */
@property (nonatomic, copy)NSString *bus_phone;

/**< 店员 */
@property (nonatomic, copy) NSString *membership;

/**< 创建日期 */
@property (nonatomic, copy)NSString *creatDate;

/**<  */
@property (nonatomic, copy) NSString *modiffDate;

/**< 图标 */
@property (nonatomic, copy)NSString *Modifier;

/**< 主营业务 */
@property (nonatomic, copy) NSString *industry;

/**< 身份证 */
@property (nonatomic, copy)NSString *bus_idCard;

/**< 地址 */
@property (nonatomic, copy) NSString *bus_site;

/**< 营业执照号 */
@property (nonatomic, copy)NSString *bus_license_number;

/**< 类型 */
@property (nonatomic, copy) NSString *type;

/**< 猫碟号 */
@property (nonatomic, copy) NSString *maodieNum;

@end
