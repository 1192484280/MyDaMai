//
//  IntroductionThreeView.m
//  MyAPP
//
//  Created by zhangming on 17/3/22.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "IntroductionThreeView.h"

@interface IntroductionThreeView ()

@property (weak, nonatomic) UIView *lineView;
@property (weak, nonatomic) UIView *faultView;

@end

@implementation IntroductionThreeView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (void)setup{
    
    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 0, 20)];
    la.text = @"购票须知";
    la.font = [UIFont fontWithName:BASEFONT size:15];
    la.width = [la getTextWidth];
    [self addSubview:la];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 15 + la.height + 15, ScreenWidth - 30, 0.5)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self addSubview:lineView];
    self.lineView = lineView;
    
    UILabel *la2 = [[UILabel alloc] initWithFrame:CGRectMake(15, lineView.y + 15.5, ScreenWidth - 30, 0)];
    la2.numberOfLines = 0;
    la2.textColor = [UIColor colorWithHexString:@"#838383"];
    la2.font = [UIFont fontWithName:BASEFONT size:15];
    [self addSubview:la2];
    
    NSString *str = @"  开票公告   2017武汉草莓音乐节已正式开票,快递订单将于3月16日起安排配送,请保持手机畅通注意查收(快递信封内含您订购的门票及配送详情单,请务必核实后签收),上门自取的客户请于3月16日起凭订票人的身份证原件到大麦网武汉分公司领取。  大麦网武汉分公司  办公地址：武汉市江汉区解放大道688号武商广场写字楼2012A（原武汉广场） 营业时间：星期一至星期日:9:00-18:00   精彩演出   2017武汉草莓音乐节演出时间表：   4月2日，草莓星球将再度降落江城武汉！为期两天的2017武汉草莓音乐节，届时将有万能青年旅店、谢天...";
    NSMutableAttributedString * atbStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8];
    [atbStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [atbStr length])];
    
    la2.attributedText = atbStr;
    la2.height = [Tools getAttributedTextHeight:str MaxWidth:ScreenWidth - 40 Attributes:@{NSParagraphStyleAttributeName : paragraphStyle ,NSFontAttributeName : la2.font}];
    
    UIView *faultView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(la2.frame) + 30, ScreenWidth, 5)];
    faultView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self addSubview:faultView];
    self.faultView = faultView;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.height = CGRectGetMaxY(self.faultView.frame);
}
@end
