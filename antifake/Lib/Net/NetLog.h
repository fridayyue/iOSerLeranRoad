//
//  NetLog.h
//  DaiFuBao
//
//  Created by Liu Hui on 2018/5/14.
//  Copyright © 2018年 come.daifubao.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetLogModel.h"

@interface NetLog : NSObject
@property (strong, nonatomic) NetLogModel*  logModel;

-(void)logNet;
@end
