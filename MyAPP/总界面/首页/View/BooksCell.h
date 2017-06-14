//
//  BooksCell.h
//  Family
//
//  Created by zhangming on 17/5/31.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BooksCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *typeView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeView_width;
@property (weak, nonatomic) IBOutlet UIView *likeView;

@property (nonatomic, copy) NSArray *typeArr;
@property (nonatomic, copy) NSArray *likeArr;

+ (instancetype)tempWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;

+(CGFloat)getHeightWithIndexPath:(NSIndexPath *)indexPath;

+ (instancetype)cellWithIndex:(NSIndexPath *)indexPath;

@end
