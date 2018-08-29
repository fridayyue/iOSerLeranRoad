//
//  NetBasicModel.h
//  DaiFuBao
//
//  Created by Liu Hui on 2018/5/14.
//  Copyright © 2018年 come.daifubao.com. All rights reserved.
//

#import "BasicJsonModel.h"

@interface NetBasicModel : BasicJsonModel
@property (strong, nonatomic) NSDictionary*  data;
@property (assign, nonatomic) NSInteger  flag;
@property (copy, nonatomic) NSString*  msg;
@end
