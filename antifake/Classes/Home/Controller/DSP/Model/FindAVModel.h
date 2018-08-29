//
//  FindAVModel.h
//  antifake
//
//  Created by 岳腾飞 on 2018/7/1.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicJsonModel.h"
#import "FindAVDetailModel.h"

@interface FindAVModel : BasicJsonModel
@property (nonatomic, copy) NSString * adv_name;
@property (nonatomic, assign) long creative_style;
@property (nonatomic, assign) float custom_price;
@property (nonatomic, strong) NSArray<FindAVDetailModel *> * detail;
@property (nonatomic, copy) NSString* id;
@property (nonatomic, copy) NSString * template_id;
@end
