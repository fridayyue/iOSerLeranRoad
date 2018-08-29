//
//  NetLog.m
//  DaiFuBao
//
//  Created by Liu Hui on 2018/5/14.
//  Copyright © 2018年 come.daifubao.com. All rights reserved.
//

#import "NetLog.h"

@implementation NetLog
-(void)dealloc{
    self.logModel = nil;
}
-(void)logNet{
    NSString *logString = [NSString stringWithFormat:@"\n--------------------NET_STAET--------------------\nREQUESTURL\n%@  \nREQUESTPARAMTARS\n\t  %@\nREQUESTRESPOND%@  \n\t\nREQUESTTIME\n\t%lf  \n--------------------NET_END--------------------",_logModel.requestUrl,_logModel.parameters,_logModel.respondData,(_logModel.endRequestTime - _logModel.requestStarTime)];
    CLog(@"%@",logString);
}
@end
