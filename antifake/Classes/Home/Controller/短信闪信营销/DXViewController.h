//
//  DXViewController.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/18.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicViewController.h"

typedef NS_ENUM(NSInteger,DXViewType) {
    duxninType = 0,
    shanxinType
};

@interface DXViewController : BasicViewController
@property(nonatomic,assign)DXViewType viewType;

@end
