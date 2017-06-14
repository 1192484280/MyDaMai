//
//  ShowViewCellModel.h
//  大麦
//
//  Created by 洪欣 on 16/12/21.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowViewCellModel : NSObject
@property (copy, nonatomic) NSString *i;
@property (copy, nonatomic) NSString *n;
@property (copy, nonatomic) NSString *p;
@property (copy, nonatomic) NSString *priceName;
@property (copy, nonatomic) NSString *t;
@property (copy, nonatomic) NSString *s;
@property (copy, nonatomic) NSString *v;
@property (copy, nonatomic) NSString *VenId;
@property (copy, nonatomic) NSString *VenName;
@property (copy, nonatomic) NSString *b;
@property (copy, nonatomic) NSString *d;
@property (assign, nonatomic) BOOL IsOnlyXuanZuo;
@property (assign, nonatomic) BOOL IsToBeAboutTo;
@property (assign, nonatomic) BOOL IsXuanZuo;
@property (copy, nonatomic) NSString *CategoryId;
@property (copy, nonatomic) NSString *CityName;
@property (copy, nonatomic) NSString *CityId;
@property (copy, nonatomic) NSString *BuySum;
@property (copy, nonatomic) NSString *StartTicketTime;
@property (copy, nonatomic) NSString *PrivilegeType;
@property (copy, nonatomic) NSString *openSum;
@property (assign, nonatomic) BOOL IsGeneralAgent;
@property (assign, nonatomic) BOOL SupportedDeductionIntegral;
@property (assign, nonatomic) BOOL isSellOut;
@end
