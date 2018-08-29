//
//  GetVocodeModel.h
//  antifake
//
//  Created by 岳腾飞 on 2018/5/29.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicJsonModel.h"

@interface GetVocodeModel : BasicJsonModel
@property(nonatomic,copy)NSString* data;
@property(nonatomic,assign)NSInteger flag;

@end
