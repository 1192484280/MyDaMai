//
//  LoginTopView.m
//  BeautyApp
//
//  Created by zhangming on 17/2/28.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "LoginTopView.h"


@implementation LoginTopView

#pragma mark -
#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.backBtn];
        [self addSubview:self.registerBtn];
        
        [self setupAutoLayout];
    }
    return self;
}


#pragma mark -
#pragma mark - 懒加载
- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] init];
        [_backBtn setImage:[UIImage imageNamed:@"goback"] forState:UIControlStateNormal];
        [_backBtn setBackgroundColor:[UIColor clearColor]];
    }
    return _backBtn;
}


- (UIButton *)registerBtn
{
    if (!_registerBtn) {
        _registerBtn = [[UIButton alloc] init];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registerBtn setBackgroundColor:[UIColor clearColor]];
        [_registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _registerBtn;
}





#pragma mark -
#pragma mark - 自动适配
- (void)setupAutoLayout
{
    __weak typeof(self)vc = self;
    //返回按钮
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 40));
        make.left.equalTo(vc.mas_left).offset(20);
        make.top.equalTo(vc.mas_top).offset(20);
    }];
    
    //注册按钮
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 30));
        make.right.equalTo(vc.mas_right).offset(-20);
        make.centerY.equalTo(vc.backBtn.mas_centerY);
    }];
    
}

@end
