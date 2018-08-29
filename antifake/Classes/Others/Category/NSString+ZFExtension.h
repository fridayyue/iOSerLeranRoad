//
//  NSString+ZFExtension.h
//  happymoney
//
//  Created by chengRui on 2017/10/17.
//  Copyright © 2017年 AW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZFExtension)


/********** 判断手机号码是否有效 **********/
- (BOOL)isValidPhoneNumber:(NSString *)phoneNumber;



/********** 判断手机运营商 **********/
- (NSString *)returnTheCarrieroperator:(NSString *)phoneNumber;



/********** 判断手机运营商 **********/
- (BOOL)isValibIdentityCard:(NSString *)IDCardNumber;


@end
