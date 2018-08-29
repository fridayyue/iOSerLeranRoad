//
//  NetLogModel.h
//  DaiFuBao
//
//  Created by Liu Hui on 2018/5/14.
//  Copyright © 2018年 come.daifubao.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetLogModel : NSObject
@property (copy, nonatomic) NSString*   requestUrl;
@property (copy, nonatomic) id          parameters;
@property (copy, nonatomic) id          respondData;
@property (assign, nonatomic) NSTimeInterval    requestStarTime;
@property (assign, nonatomic) NSTimeInterval    endRequestTime;
@end
