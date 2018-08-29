//
//  ZFConst.m
//  CooperativeWorking
//
//  Created by chengRui on 2017/5/23.
//  Copyright © 2017年 chengRui. All rights reserved.
//

#import <UIKit/UIKit.h>

/******** 系统配置信息 ********/
/** 配置信息请求地址 */
NSString * const ZFConfigURL = @"index/Getconfig";




/******** 登录-注册-忘记密码 ********/
/** 登录请求地址 */
NSString * const ZFLoginURL = @"app/toLogin";

/** 注册请求地址 */
NSString * const ZFRegisterURL = @"user/register";

/** 忘记密码请求地址 */
NSString * const ZFForgetPasswordURL = @"user/updatepass";

/** 获取验证码请求地址 */
NSString * const ZFMessageCodeURL = @"user/getcode";

/** 修改请求地址 */




/******** 首页 ********/
/** 首页数据请求地址 */
NSString * const ZFHomeDataURL = @"app/statData";

/** 金额数量请求地址 */
NSString * const ZFMoneyAmountURL = @"index/GetAmount";




/******** Me ********/
/** Me数据请求地址 */
NSString * const ZFMeDataURL = @"app/personalInformation";

/** 支付宝请求地址 */
NSString * const ZFAliURL = @"app/payAli";

/** 店铺列表请求地址 */
NSString * const ZFShopListURL = @"app/businessList";

/** 添加店铺请求地址 */
NSString * const ZFAddShopURL = @"app/addBusiness";

/** 店铺设备列表请求地址 */
NSString * const ZFShopEqListURL = @"app/maodieList";


/** 所有设备列表请求地址 */
NSString * const ZFEqListURL = @"app/maodieList";

/** 店铺设备列表请求地址 */
NSString * const ZFAddEqURL = @"app/boundMaodie";


/** 消费明细列表请求地址 */
NSString * const ZFFareListURL = @"app/consumerList";


NSString * const ZFAPPVersion = @"app/appVersionsIos";
