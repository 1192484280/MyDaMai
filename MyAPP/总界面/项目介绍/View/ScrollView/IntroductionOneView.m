//
//  IntroductionOneView.m
//  MyAPP
//
//  Created by zhangming on 17/3/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "IntroductionOneView.h"

@interface IntroductionOneView ()

@property (weak, nonatomic) UIView *topView;
@property (weak, nonatomic) UIView *bottomView;
@property (weak, nonatomic) UILabel *addressLb2;
@property (weak, nonatomic) UILabel *addressLb3;
@property (weak, nonatomic) UIView *faultView;
@end

@implementation IntroductionOneView

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
    self.topView = topView;
    
    UILabel *timeLb = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 0, 15)];
    timeLb.text = @"演出时间:  ";
    timeLb.font = [UIFont fontWithName:BASEFONT size:15];
    timeLb.width = [timeLb getTextWidth];
    timeLb.centerY = topView.height / 2;
    [topView addSubview:timeLb];
    
    UILabel *timeLb2 = [[UILabel alloc] init];
    timeLb2.textColor = [UIColor colorWithHexString:@"#838383"];
    timeLb2.font = [UIFont fontWithName:BASEFONT size:15];
    timeLb2.frame = CGRectMake(timeLb.width + 15, 0, ScreenWidth - timeLb.width - 15 , 15);
    timeLb2.text = [self currentTime];
    timeLb2.centerY = timeLb.centerY;
    [topView addSubview:timeLb2];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 49.5, ScreenWidth - 30, 0.5)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [topView addSubview:lineView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), ScreenWidth, 0)];
    bottomView.userInteractionEnabled = YES;
    [bottomView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBottomView)]];
    [self addSubview:bottomView];
    self.bottomView = bottomView;
    
    UILabel *addressLb = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 0, 15)];
    addressLb.text = @"演出场馆:  ";
    addressLb.font = [UIFont fontWithName:BASEFONT size:15];
    addressLb.width = [addressLb getTextWidth];
    [bottomView addSubview:addressLb];
    
    
    CGFloat addressLbX = CGRectGetMaxX(addressLb.frame);
    UILabel *addressLb2 = [[UILabel alloc] init];
    addressLb2.text = @"大连体育中心（原大连体育中心体育馆）";
    addressLb2.textColor = [UIColor colorWithHexString:@"#838383"];
    addressLb2.font = [UIFont fontWithName:BASEFONT size:15];
    addressLb2.frame = CGRectMake(addressLb.width + 15, addressLb.y-1, ScreenWidth - addressLbX - 15 - 30 , 0);
    addressLb2.numberOfLines = 0;
    [bottomView addSubview:addressLb2];
    self.addressLb2 = addressLb2;
    
    UILabel *addressLb3 = [[UILabel alloc] init];
    addressLb3.text = @"甘井子火炬路22号";
    addressLb3.textColor = [UIColor colorWithHexString:@"#838383"];
    addressLb3.font = [UIFont fontWithName:BASEFONT size:15];
    addressLb3.frame = CGRectMake(addressLb2.x, 0, ScreenWidth - addressLbX - 15 -30, 15);
    addressLb3.numberOfLines = 0;
    [bottomView addSubview:addressLb3];
    self.addressLb3 = addressLb3;
    
    UIImageView *im = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_film_more"]];
    im.x = ScreenWidth - 15 - im.image.size.width;
    im.centerY = bottomView.centerY;
    
    [bottomView addSubview:im];
    
    UIView *faultView = [[UIView alloc] init];
    faultView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self addSubview:faultView];
    self.faultView = faultView;
}

- (NSString *)currentTime{
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *DateTime = [formatter stringFromDate:date];
    
    return DateTime;
}

- (void)onBottomView{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"演出场馆" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    [self.getCurrentViewController presentViewController:alert animated:YES completion:^{
        
    }];

}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.addressLb2.height = [self.addressLb2 getTextHeight];
    self.addressLb3.height = [self.addressLb3 getTextHeight];
    
    self.addressLb3.y = CGRectGetMaxY(self.addressLb2.frame) + 5;
    
    self.bottomView.height = CGRectGetMaxY(self.addressLb3.frame) + 20;
    self.bottomView.y = CGRectGetMaxY(self.topView.frame);
    self.faultView.frame = CGRectMake(0, CGRectGetMaxY(self.bottomView.frame), ScreenWidth, 5);
    self.height = CGRectGetMaxY(self.faultView.frame);
}
@end
