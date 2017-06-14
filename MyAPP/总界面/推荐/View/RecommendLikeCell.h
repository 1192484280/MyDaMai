//
//  RecommendLikeCell.h
//  BeautyApp
//
//  Created by zhangming on 17/2/6.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecommendLikeModel;

@interface RecommendLikeCell : UITableViewCell

@property (nonatomic,strong) RecommendLikeModel *model;

@property (nonatomic,weak) UIImageView *imgView;

@property (nonatomic,weak) UILabel *titleLa;

@property (nonatomic,weak) UILabel *timeLa;

@property (nonatomic,weak) UILabel *addressLa;

@property (nonatomic,weak) UIView *line;

@end
