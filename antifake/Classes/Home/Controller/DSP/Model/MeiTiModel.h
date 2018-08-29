//
//  MeiTiModel.h
//  antifake
//
//  Created by 岳腾飞 on 2018/7/1.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicJsonModel.h"

@interface MeiTiModel : BasicJsonModel
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, copy) NSString* id;
@property (nonatomic, copy) NSString * media_name;
@property (nonatomic, copy) NSString * os;
@end
