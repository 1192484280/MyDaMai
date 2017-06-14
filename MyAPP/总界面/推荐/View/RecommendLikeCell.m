//
//  RecommendLikeCell.m
//  BeautyApp
//
//  Created by zhangming on 17/2/6.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "RecommendLikeCell.h"

#import "RecommendLikeModel.h"

@implementation RecommendLikeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setup];
    }
    return self;
}

- (void)setup{
    
    //图片
    UIImageView *imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:imgView];
    self.imgView = imgView;
    
    //标题
    UILabel *titleLa = [[UILabel alloc] init];
    titleLa.contentMode = UIViewContentModeTop;
    titleLa.textColor = [UIColor blackColor];
    titleLa.font = [UIFont systemFontOfSize:15];
    titleLa.numberOfLines = 2;
    [self.contentView addSubview:titleLa];
    self.titleLa = titleLa;
    
    //时间
    UILabel *timeLa = [[UILabel alloc] init];
    timeLa.textColor = [UIColor colorWithHexString:@"#999999"];
    timeLa.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:timeLa];
    self.timeLa = timeLa;
    
    //地址
    UILabel *addressLa = [[UILabel alloc] init];
    addressLa.textColor = [UIColor colorWithHexString:@"#999999"];
    addressLa.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:addressLa];
    self.addressLa = addressLa;
    
    //线
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.contentView addSubview:line];
    self.line = line;
    
}

- (void)setModel:(RecommendLikeModel *)model{
    
    _model = model;
    NSString *urlTop = @"http://pimg.damai.cn/perform/project";
    NSString *str1 = [model.id substringToIndex:4];
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/%@_n.jpg",urlTop,str1,model.id];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    
    self.titleLa.text = model.name;
    self.timeLa.text = [NSString stringWithFormat:@"时间：%@",model.show_time];
    self.addressLa.text = [NSString stringWithFormat:@"场馆：%@",model.venue_name];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.imgView.frame = CGRectMake(15, 5, 90, 130);
    
    CGFloat titleLa_X = CGRectGetMaxX(self.imgView.frame) + 15;
    CGFloat titleLa_Y = self.imgView.y + 5;
    CGFloat titleLa_W = ScreenWidth - titleLa_X - 15;
    self.titleLa.frame = CGRectMake(titleLa_X, titleLa_Y, titleLa_W, 0);
    self.titleLa.height = [self.titleLa getTextHeight];
    
    CGFloat addressLa_X = titleLa_X;
    CGFloat addressLa_Y = CGRectGetMaxY(self.imgView.frame) - 10 - 15;
    self.addressLa.frame = CGRectMake(addressLa_X, addressLa_Y, titleLa_W, 15);
    
    CGFloat time_X = titleLa_X;
    CGFloat time_Y = addressLa_Y - 10 - 15;
    self.timeLa.frame = CGRectMake(time_X, time_Y, titleLa_W, 15);
    
    self.line.frame = CGRectMake(time_X, self.height - 0.5, ScreenWidth - time_X - 15, 0.5);
}

@end
