//
//  StatementSMSDetailViewController.h
//  antifake
//
//  Created by 岳腾飞 on 2018/7/4.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicViewController.h"
#import "StatementSMSModel.h"
#import "StatementFlashSmsModel.h"

typedef NS_ENUM(NSInteger,Type){
    smsType,
    fashType,
    callType
};

@interface StatementSMSDetailViewController : BasicViewController
@property(nonatomic,strong)StatementSMSModel* smsModel;
@property(nonatomic,strong)StatementFlashSmsModel* fashModel;

@property(nonatomic,assign)Type viewType;

@end
