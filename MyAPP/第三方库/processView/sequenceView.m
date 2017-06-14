//
//  sequenceView.m
//  progressCus
//
//  Created by 张东 on 2017/5/27.
//  Copyright © 2017年 张东. All rights reserved.
//

#import "sequenceView.h"

#define kColor(hex) [UIColor colorWithRed:((CGFloat)((hex & 0xFF0000) >> 16)) / 255.0 green:((CGFloat)((hex & 0xFF00) >> 8)) / 255.0 blue:((CGFloat)(hex & 0xFF)) / 255.0 alpha:1]

// 起始位置的Y
#define Start_Position_Y  50
// 起始位置的Y
#define Start_Position_X  15
// 直径
#define Round_Directly  23
// 连接的线长
#define Line_Length   88

@implementation sequenceView

- (void)sequenceWith:(NSArray *)titleArr contentArr: (NSArray *)contentArr {
    
    self.backgroundColor = kColor(0xffffff);
    
    
    for (NSInteger i = 0; i < titleArr.count; i ++) {
        // 阶段
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(Start_Position_X, Start_Position_Y + i * (Round_Directly + Line_Length), Round_Directly, Round_Directly)];
        btn.layer.cornerRadius = Round_Directly * 0.5;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = kColor(0x358fd7).CGColor;
        btn.layer.borderWidth = 1;
        [btn setTitle:[NSString stringWithFormat:@"%ld", i + 1] forState:UIControlStateNormal];
        [btn setTitleColor:kColor(0x358fd7) forState:UIControlStateNormal];
        btn.tag = i + 1;
        [btn addTarget:self action:@selector(sequenceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
//        每个btn 起始y的位置
        //        50                            50 + 23 + 88
        //        50 + 23 + 88 + 23 + 88        50 + 23 + 88 + 23 + 88 + 23 + 88
//        连接线的起始y位置
        //        50 + 23                       50 + 23 + 88 + 23
        //        50 + 23 + 88 + 23 + 88 +23    50 + 23 + 88 + 23 + 88 + 88
        
        if (i < titleArr.count - 1) {
//            连接线
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(Start_Position_X + Round_Directly * 0.5 - 0.5,Start_Position_Y + Round_Directly + (Line_Length + Round_Directly) * i , 1, Line_Length)];
            lineView.backgroundColor = kColor(0x358fd7);
            [self addSubview:lineView];
        }
        
        
        UILabel *titleLb = [self lableWithFrame:CGRectMake(CGRectGetMaxX(btn.frame) + 15, CGRectGetMidY(btn.frame) - Round_Directly * 0.5, self.frame.size.width - CGRectGetMaxX(btn.frame) - 15, Round_Directly) text:titleArr[i] textColor:kColor(0x358fd7) font:19];
        [self addSubview:titleLb];
        
        
        UILabel *contentlb = [self lableWithFrame:CGRectMake(CGRectGetMinX(titleLb.frame), CGRectGetMaxY(titleLb.frame) + 11.5, titleLb.frame.size.width, 17) text:contentArr[i] textColor:kColor(0x666666) font:14];
        [self addSubview:contentlb];
    }
    
}

- (UILabel *)lableWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(NSInteger)font {
    
    UILabel *cusLb = [[UILabel alloc] initWithFrame:frame];
    cusLb.text = text;
    cusLb.textColor = textColor;
    cusLb.font = [UIFont systemFontOfSize:font];
    
    return cusLb;
}



- (void)sequenceBtnClick: (UIButton *)sequenceBtn {
    
    if ([self.delegate respondsToSelector:@selector(sequenceViewWithSequenceView:sequenceBtn:)]) {
        
        [self.delegate sequenceViewWithSequenceView:self sequenceBtn:sequenceBtn];
    }
    
}


@end
