//
//  MyDataCell.h
//  BeautyApp
//
//  Created by zhangming on 17/2/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyDataCell : UITableViewCell

//头像label
@property (weak, nonatomic) IBOutlet UILabel *headLa;

@property (weak, nonatomic) IBOutlet UIImageView *headIm;

@property (weak, nonatomic) IBOutlet UILabel *titleLa;

@property (weak, nonatomic) IBOutlet UILabel *setLa;


+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

#pragma mark - 生成cell
+ (instancetype)cell:(NSIndexPath *)indexPath;

#pragma mark - 高度
+ (CGFloat)Height:(NSIndexPath *)indexPath;

- (void)reciveInfoWithTitleArr:(NSArray *)titlesArr andTitlesArr2:(NSArray *)titlesArr2 andTitlesArr3:(NSArray *)titlesArr3 andTitlesArr4:(NSArray *)titlesArr4 andIndexPath:(NSIndexPath *)indexPath;

@end
