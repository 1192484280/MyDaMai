//
//  ShowCell.h
//  MyAPP
//
//  Created by zhangming on 17/3/8.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowViewCellModel.h"
@interface ShowCell : UITableViewCell

@property (strong, nonatomic) ShowViewCellModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *im;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *adress;



#pragma mark - 生成cell
+ (instancetype)cell;

#pragma mark - 获取cell高度
+ (CGFloat)getHeight;

+ (instancetype)tempTableViewCellWith:(UITableView *)tableView;

@end
