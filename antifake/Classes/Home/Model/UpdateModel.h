//
//  UpdateModel.h
//  antifake
//
//  Created by 岳腾飞 on 2018/5/18.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicJsonModel.h"

@interface UpdateModel : BasicJsonModel
@property(nonatomic,copy)NSString* IOSRemarks;
@property(nonatomic,copy)NSString* IOSVersionCode;
@property(nonatomic,copy)NSString* IOSVersionName;
@property(nonatomic,copy)NSString* IOSDownLoadUrl;

@end
