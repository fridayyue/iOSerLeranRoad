//
//  DXSignListViewController.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/24.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicViewController.h"

typedef void (^SignSelectBlock)(NSString *blockString);

@interface DXSignListViewController : BasicViewController
@property(nonatomic,copy)SignSelectBlock signBlock;

@end
