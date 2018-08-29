//
//  DXChrooseViewController.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/23.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicViewController.h"

typedef void (^DXChrooseBlock)(NSArray *dataArray);

@interface DXChrooseViewController : BasicViewController
@property(nonatomic,copy)DXChrooseBlock chrooseBlock;

@end
