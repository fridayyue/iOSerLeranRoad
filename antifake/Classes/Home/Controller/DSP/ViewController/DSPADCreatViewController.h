//
//  DSPADCreatViewController.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/27.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicViewController.h"
typedef NS_ENUM(NSInteger,ADType) {
    shangquanType,
    macToufangType
};
@interface DSPADCreatViewController : BasicViewController
@property(nonatomic,assign)ADType viewType;

@end
