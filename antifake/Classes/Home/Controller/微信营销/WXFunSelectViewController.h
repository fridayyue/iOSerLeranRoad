//
//  WXFunSelectViewController.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/17.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicViewController.h"

typedef void(^FunCompleteBlock) (void);

@interface WXFunSelectViewController : BasicViewController
@property(nonatomic,copy)FunCompleteBlock compleBlock;
@property(nonatomic,strong)NSMutableArray* selectArray;

@end
