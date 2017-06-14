//
//  CityInformationModel.h
//  大麦
//
//  Created by 洪欣 on 16/12/15.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CityInformationModel : NSObject
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *postalcode;
@property (copy, nonatomic) NSString *telCode;
@property (copy, nonatomic) NSString *firstLetter;
@property (copy, nonatomic) NSString *parentid;
@end
