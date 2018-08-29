//
//  DXAddMBViewController.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/24.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicViewController.h"
typedef void (^DXAddBlock)(void);
@interface DXAddMBViewController : BasicViewController
@property(nonatomic,copy)DXAddBlock addBlock;

@end
