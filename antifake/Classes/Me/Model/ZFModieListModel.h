//
//  ZFModieListModel.h
//  antifake
//
//  Created by Zach on 2018/5/11.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFModieListModel : NSObject

/**< id */
@property (nonatomic, copy)NSString *id;

/**< 设备名称 */
@property (nonatomic, copy) NSString *equipmentName;

/**< businessID */
@property (nonatomic, copy)NSString *businessID;

/**< 地址 */
@property (nonatomic, copy) NSString *loaclArea;

/**< 类型 */
@property (nonatomic, copy)NSString *type;

/**< 创建日期 */
@property (nonatomic, copy) NSString *creatDate;

/**<  */
@property (nonatomic, copy)NSString *modiffDate;

/**<  */
@property (nonatomic, copy) NSString *Modifier;

/**< 图标 */
@property (nonatomic, copy)NSString *quuery;

/**< mac地址 */
@property (nonatomic, copy) NSString *sta;

/**< 身份证 */
@property (nonatomic, copy)NSString *lon;

/**< 地址 */
@property (nonatomic, copy) NSString *lat;

/**< userid */
@property (nonatomic, copy)NSString *user_id;

/**< 店铺 */
@property (nonatomic, copy) NSString *businessName;



@end
