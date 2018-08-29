//
//  WXYingXiaoManger.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/14.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXYingXiaoManger : NSObject
+(instancetype)shareManger;

-(void)destroy;
/**
 公众号账号
 */
@property(nonatomic,copy)NSString* gzhName;

/**
 密码
 */
@property(nonatomic,copy)NSString* gzhPwd;

/**
 广告名称
 */
@property(nonatomic,copy)NSString* advName;

/**
 推广目标
 */
@property(nonatomic,copy)NSString* adGoal;
/**
 广告类型
 */
@property(nonatomic,copy)NSString* adType;

/**
 购买方式
 */
@property(nonatomic,copy)NSString* purchaseType;

/**
 区域选择
 */
@property(nonatomic,strong)NSArray* wxAreaArray;

/**
 区域选择 传参
 */
@property(nonatomic,copy)NSString* city;

/**
 兴趣选择
 */
@property(nonatomic,strong)NSMutableArray* wxFunArray;

/**
 兴趣选择 传参
 */
@property(nonatomic,copy)NSString* hobby;

/**
 投放性别
 */
@property(nonatomic,copy)NSString* pushSex;

/**
 投放年龄
 */
@property(nonatomic,copy)NSString* pushAge;

/**
 设备导入
 */
@property(nonatomic,strong)NSArray* wxSendPhone;

/**
 设备导入 传参
 */
@property(nonatomic,copy)NSString* sendPhone;

/**
 是否全天投放 0fals 1true
 */
@property(nonatomic,assign)BOOL isDayPush;

/**
 开始时段
 */
@property(nonatomic,copy)NSString* startTime;

/**
 结束时段
 */
@property(nonatomic,copy)NSString* overTime;

/**
 是否再营销 0 已关注公众号 1曾领取你的微信卡券 2 曾对你的微信广告感兴趣 3 不启用
 */
@property(nonatomic,assign)BOOL marketing;

/**
 是否排除营销 不启用 自定义
 */
@property(nonatomic,assign)BOOL wxOut;

/**
 每日预算
 */
@property(nonatomic,copy)NSString* wxEverdayPrice;

/**
 出价
 */
@property(nonatomic,copy)NSString* wxTotalPrice;

/**
 广告展现形式
 */
@property(nonatomic,copy)NSString* wxADShowType;

/**
 点击文案
 */
@property(nonatomic,copy)NSString* wxADWenAn;

/**
 详情页模板
 */
@property(nonatomic,copy)NSString* wxDetailType;

/**
 主标题
 */
@property(nonatomic,copy)NSString* wxBiaoTi;

/**
 主标题描述
 */
@property(nonatomic,copy)NSString* wxMiaoShu;

/**
 视频地址
 */
@property(nonatomic,copy)NSString* wxShipin;

/**
 提交按钮文案
 */
@property(nonatomic,copy)NSString* wxAnniuWean;

/**
 按钮跳转地址
 */
@property(nonatomic,copy)NSString* wxTiaozhuan;

/**
 分享标题
 */
@property(nonatomic,copy)NSString* wxShareTitle;

/**
 分享描述
 */
@property(nonatomic,copy)NSString* wxShareMiaoshu;


/**
 每一单唯一的key是创建的时候生成的时间戳
 */
@property(nonatomic,copy)NSString* pkey_value;


/**
 预约活动名称
 */
@property(nonatomic,copy)NSString* activityName;




@end
