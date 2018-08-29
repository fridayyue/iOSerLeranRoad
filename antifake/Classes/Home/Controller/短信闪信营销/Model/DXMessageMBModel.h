//
//  DXMessageMBModel.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/24.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicJsonModel.h"

@interface DXMessageMBModel : BasicJsonModel
@property (nonatomic, assign) NSInteger auditState;
@property (nonatomic, assign) NSInteger beyond;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * endText;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * sign;
@property (nonatomic, assign) NSInteger smsId;
@property (nonatomic, assign) NSInteger smsSort;
@property (nonatomic, copy) NSString * submitTime;
@property (nonatomic, copy) NSString * template_class;
@end
