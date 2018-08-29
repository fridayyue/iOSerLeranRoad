//
//  WXFunModel.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/17.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicJsonModel.h"

@interface WXFunModel : BasicJsonModel
@property (nonatomic, strong) NSString * creatTime;
@property (nonatomic, assign) BOOL deleted;
@property (nonatomic, copy) NSString * hobbyName;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString * lastModifyTime;
@property (nonatomic, assign) NSInteger parent_id;
@property (nonatomic, assign) BOOL wxFriends;
@property(nonatomic,strong)NSMutableArray* chrildArray;
@property(nonatomic,assign)BOOL selected;

@end
