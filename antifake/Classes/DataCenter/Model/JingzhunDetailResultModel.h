//
//  JingzhunDetailResultModel.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/13.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicJsonModel.h"
//{"shouji":"17679088329","province":"江西","city":"南昌","company":"中国联通","cardtype":"","areacode":"0791"}
@interface JingzhunDetailResultModel : BasicJsonModel
@property(nonatomic,copy)NSString* shouji;
@property(nonatomic,copy)NSString* province;
@property(nonatomic,copy)NSString* city;
@property(nonatomic,copy)NSString* company;
@property(nonatomic,copy)NSString* cardtype;
@property(nonatomic,copy)NSString* areacode;

@end
