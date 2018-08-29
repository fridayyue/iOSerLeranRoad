//
//  DSPMACDetailModel.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/27.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicJsonModel.h"

@interface DSPMACDetailModel : BasicJsonModel
@property (nonatomic, copy) NSString * mac;
@property (nonatomic, copy) NSString * sta;
@property (nonatomic, assign) long state;
@property (nonatomic, copy) NSString * time;
@property (nonatomic, copy) NSString * user_id;
@end
