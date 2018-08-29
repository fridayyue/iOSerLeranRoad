//
//  ZFMacNumberListModel.h
//  antifake
//
//  Created by Zach on 2018/5/12.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFMacNumberListModel : NSObject

/**< 图标 */
@property (nonatomic, copy)NSString *time;

/**< 店铺名称 */
@property (nonatomic, copy) NSString *sta;

/**< userid */
@property (nonatomic, copy)NSString *mac;

/**< 店主姓名 */
@property (nonatomic, copy) NSString *rssi;

/**< 店铺手机号 */
@property (nonatomic, copy)NSString *lat;

/**< 店员 */
@property (nonatomic, copy) NSString *lon;

/**< 创建日期 */
@property (nonatomic, copy)NSString *user_id;

/**< 创建日期 */
@property (nonatomic, copy)NSString *state;

@end
