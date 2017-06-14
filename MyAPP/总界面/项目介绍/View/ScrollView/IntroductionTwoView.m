//
//  IntroductionTwoView.m
//  MyAPP
//
//  Created by zhangming on 17/3/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "IntroductionTwoView.h"

@interface IntroductionTwoView ()

@property (weak, nonatomic) UIView *faultView;
@end

@implementation IntroductionTwoView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (void)setup{
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    
    [self addSubview:topView];
    topView.userInteractionEnabled = YES;
    [topView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTopView)]];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 0, 15)];
    title.text = @"项目详情";
    title.font = [UIFont fontWithName:BASEFONT size:15];
    title.width = [title getTextWidth];
    [topView addSubview:title];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, title.height+15+15, ScreenWidth - 30, 0.5)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [topView addSubview:lineView];
    
    UIImageView *im = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_film_more"]];
    im.x = ScreenWidth - 15 - im.image.size.width;
    im.centerY = topView.centerY;
    
    [topView addSubview:im];
    
    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(15, 65, ScreenWidth - 30, 0)];
    la.numberOfLines = 0;
    la.textColor = [UIColor colorWithHexString:@"#838383"];
    la.font = [UIFont fontWithName:BASEFONT size:15];
    [self addSubview:la];
    
    NSString *str = @"  开票公告   2017武汉草莓音乐节已正式开票,快递订单将于3月16日起安排配送,请保持手机畅通注意查收(快递信封内含您订购的门票及配送详情单,请务必核实后签收),上门自取的客户请于3月16日起凭订票人的身份证原件到大麦网武汉分公司领取。  大麦网武汉分公司  办公地址：武汉市江汉区解放大道688号武商广场写字楼2012A（原武汉广场） 营业时间：星期一至星期日:9:00-18:00   精彩演出   2017武汉草莓音乐节演出时间表：   4月2日，草莓星球将再度降落江城武汉！为期两天的2017武汉草莓音乐节，届时将有万能青年旅店、谢天...";
    NSMutableAttributedString * atbStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8];
    [atbStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [atbStr length])];
    
    la.attributedText = atbStr;
    la.height = [Tools getAttributedTextHeight:str MaxWidth:ScreenWidth - 40 Attributes:@{NSParagraphStyleAttributeName : paragraphStyle ,NSFontAttributeName : la.font}];
    
    UIView *faultView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(la.frame) + 30, ScreenWidth, 5)];
    faultView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self addSubview:faultView];
    self.faultView = faultView;
}

- (void)onTopView{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"项目介绍" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    [self.getCurrentViewController presentViewController:alert animated:YES completion:^{
        
    }];

}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.height = CGRectGetMaxY(self.faultView.frame);;
}
@end
