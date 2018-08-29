//
//  FindAVDetailModel.h
//  antifake
//
//  Created by 岳腾飞 on 2018/7/1.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicJsonModel.h"

@interface FindAVDetailModel : BasicJsonModel
@property (nonatomic, assign) long index;
@property (nonatomic, copy) NSString * material_type;
@property (nonatomic, copy) NSString * material_type1;
@property (nonatomic, assign) float maxlenght;
@end
