//
//  ErrorView.m
//  大麦
//
//  Created by 洪欣 on 16/12/21.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "ErrorView.h"

@interface ErrorView ()
@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) UILabel *titleLb;
@property (copy, nonatomic) NSString *imageName;
@property (copy, nonatomic) NSString *title;
@end

@implementation ErrorView

- (instancetype)initWithFrame:(CGRect)frame ImageName:(NSString *)imageName Title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageName = imageName;
        self.title = title;
        [self setup];
    }
    return self;
}

- (void)setup
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imageName]];
    [self addSubview:imageView];
    self.imageView = imageView;

    UILabel *titleLb = [[UILabel alloc] init];
    titleLb.text = self.title;
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.textColor = [UIColor colorWithHexString:@"#666666"];
    titleLb.font = [UIFont systemFontOfSize:13];
    [self addSubview:titleLb];
    self.titleLb = titleLb;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.centerX = self.width / 2;
    self.imageView.centerY = self.height / 2;
    
    self.titleLb.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + 10, self.width, 15);
}

@end
