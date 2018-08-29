//
//  WXSelectAreaViewController.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/17.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicViewController.h"

typedef NS_ENUM(NSInteger,SelectType){
    wxAereaSelectType = 1,
    wxFunSelectType
};

@interface WXSelectAreaViewController : BasicViewController
@property(nonatomic,assign)SelectType selectType;

@end
