//
//  DSPCreatAD3ViewController.h
//  antifake
//
//  Created by 岳腾飞 on 2018/7/3.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicViewController.h"
typedef void (^UpdateBlock)(BOOL isUpDate);
@interface DSPCreatAD3ViewController : BasicViewController
@property(nonatomic,copy)UpdateBlock updateBlock;

@end
