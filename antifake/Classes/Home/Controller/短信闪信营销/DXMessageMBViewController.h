//
//  DXMessageMBViewController.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/23.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicViewController.h"
#import "DXMessageMBModel.h"

typedef void (^DXSelectMB)(DXMessageMBModel *mbModel);

@interface DXMessageMBViewController : BasicViewController
@property(nonatomic,copy)DXSelectMB selectBlock;

@end
