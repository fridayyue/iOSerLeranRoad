//
//  DSPAllQualicationStateModel.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/26.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicJsonModel.h"

@interface DSPAllQualicationStateModel : BasicJsonModel
@property (nonatomic, copy) NSString * address;
@property (nonatomic, copy) NSString * brand;
@property (nonatomic, copy) NSString * busLicenseName;
@property (nonatomic, copy) NSString * busLicenseNo;
@property (nonatomic, copy) NSString * busLicenseTime;
@property (nonatomic, assign) NSInteger busLicenseUpload;
@property (nonatomic, copy) NSString * companyICPNo;
@property (nonatomic, assign) NSInteger companyICPUpload;
@property (nonatomic, copy) NSString * contact;
@property (nonatomic, copy) NSString * createTime;
@property (nonatomic, copy) NSString * iab;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString * identityCardNo;
@property (nonatomic, copy) NSString * identityTime;
@property (nonatomic, assign) NSInteger identityUpload;
@property (nonatomic, assign) NSInteger isUpOther;
@property (nonatomic, copy) NSString * legalPersonName;
@property (nonatomic, copy) NSString * orderNo;
@property (nonatomic, assign) NSInteger orgDutyProofUpload;
@property (nonatomic, assign) NSInteger orgUpload;
@property (nonatomic, copy) NSString * phone;
@property (nonatomic, copy) NSString * remark;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, copy) NSString * user_id;
@end
