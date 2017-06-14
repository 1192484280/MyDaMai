//
//  RadioListCell.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/14.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RadioAllList;
@interface RadioListCell : UITableViewCell

@property (nonatomic,strong) RadioAllList *allList;

+ (instancetype)cellWith:(UITableView *)tabeView;


#pragma mark - 生成
+ (instancetype)cell:(NSIndexPath *)indexPath;

#pragma mark -  高度
+ (CGFloat)getCellHeight:(NSIndexPath *)indexPath;

@end
