//
//  SelectCityHeaderView.m
//  MyAPP
//
//  Created by zhangming on 17/3/14.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "SelectCityHeaderView.h"

@interface SelectCityHeaderView ()

@property (weak , nonatomic)UILabel *titleLabel;

@end

@implementation SelectCityHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
        [self setup];
    }
    return self;
}

- (void)setup{
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, ScreenWidth-12, self.height)];
    titleLable.textColor = [UIColor colorWithHexString:@"#444444"];
    titleLable.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:titleLable];
    self.titleLabel = titleLable;
}
- (void)setTitle:(NSString *)title{
    
    _title = title;
    self.titleLabel.text = title;
    if (title.length == 1) {
        
        self.titleLabel.x = 25;
        self.titleLabel.width = ScreenWidth - 25;
    }else{
        
        self.titleLabel.x = 12;
        self.titleLabel.width = ScreenWidth-12;
    }
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.titleLabel.height = self.height;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
