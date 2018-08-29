//
//  DSPManger.h
//  antifake
//
//  Created by 岳腾飞 on 2018/7/3.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSPManger : NSObject
+(instancetype)shareManger;
-(void)destroy;
/**
 每一单唯一的key是创建的时候生成的时间戳
 */
@property(nonatomic,copy)NSString* pkey_value;

/**
 广告开始时间
 */
@property(nonatomic,copy)NSString* put_starttime;

/**
 广告结束时间
 */
@property(nonatomic,copy)NSString* put_endtime;

/**
 广告名
 */
@property(nonatomic,copy)NSString* media_name;
/**
 广告id
 */
@property(nonatomic,copy)NSString* media;

/**
 展示时间段
 */
@property(nonatomic,copy)NSString* time_interval;

/**
 物理地址
 */
@property(nonatomic,copy)NSString* mac;

/**
 广告类型id
 */
@property(nonatomic,copy)NSString* adv_id;

/**
 广告类型名
 */
@property(nonatomic,copy)NSString* advPlace;

/**
 广告价格
 */
@property(nonatomic,copy)NSString* custom_price;

/**
 编辑文字
 */
@property(nonatomic,copy)NSString* AdContent;
@property(nonatomic,copy)NSString* sex;

/**
 年龄选择
 */
@property(nonatomic,copy)NSString* age;
@property(nonatomic,copy)NSString* put_area;

/**
 商圈范围
 */
@property(nonatomic,copy)NSString* distance;

@end
