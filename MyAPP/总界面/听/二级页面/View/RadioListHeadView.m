//
//  RadioListHeadView.m
//  MyAPP
//
//  Created by zhangming on 17/3/9.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "RadioListHeadView.h"

@interface RadioListHeadView ()

@property (strong , nonatomic) UIImageView *im;

@property (strong , nonatomic) UIImageView *headIm;

@property (strong , nonatomic) UILabel *author;

@property (strong , nonatomic) UILabel *title;

@property (strong , nonatomic) UIButton *numBtn;

@end

@implementation RadioListHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUI];
        [self setupLayout];
    }
    
    return self;
}

- (void)setUI{
    
    [self addSubview:self.im];
    [self addSubview:self.headIm];
    [self addSubview:self.author];
    [self addSubview:self.title];
    [self addSubview:self.numBtn];
    
    
}

- (void)setupLayout{
    
    
    
    
}
- (UIImageView *)im{
    
    if (!_im) {
        
        _im = [[UIImageView alloc] init];
        
    }
    
    return _im;
}

- (UIImageView *)headIm{
    
    if (!_headIm) {
        
        _headIm = [[UIImageView alloc] init];
        
    }
    
    return _im;
    
}

- (UILabel *)author{
    
    if (!_author) {
        
        _author = [[UILabel alloc] init];
    }
    
    return _author;
}

- (UILabel *)title{
    
    if (!_title) {
        
        _title = [[UILabel alloc] init];
    }
    
    return _title;
    
}

- (UIButton *)numBtn{
    
    if (_numBtn) {
        
        _numBtn = [[UIButton alloc] init];
        
    }
    
    return _numBtn;
}
@end
