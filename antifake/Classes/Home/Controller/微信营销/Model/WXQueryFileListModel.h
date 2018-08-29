//
//  WXQueryFileListModel.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/18.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicJsonModel.h"

@interface WXQueryFileListModel : BasicJsonModel

@property (nonatomic, copy) NSString * attach_size;
@property (nonatomic, copy) NSString * attach_type;
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * name_diaplay;
@property (nonatomic, copy) NSString * name_save;
@property (nonatomic, strong) NSString * name_save_thumb;
@property (nonatomic, copy) NSString * path;
@property (nonatomic, copy) NSString * pkey_value;
@property (nonatomic, assign) long state;
@property (nonatomic, copy) NSString * suffix;
@property (nonatomic, copy) NSString * tableName;

@end
