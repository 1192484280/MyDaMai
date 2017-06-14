//
//  UIBarButtonItem+Extension.m
//  BeautyApp
//
//  Created by zhangming on 17/1/22.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action{
    
    UIButton *tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagBtn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [tagBtn setBackgroundImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    [tagBtn setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    tagBtn.size = tagBtn.currentBackgroundImage.size;
    [tagBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:tagBtn];
}

+ (instancetype)itemWithTitle:(NSString *)title ImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action{
    
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [tagButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    [tagButton setTitle:title forState:UIControlStateNormal];
    [tagButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tagButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    tagButton.titleLabel.font = [UIFont systemFontOfSize:14];
    tagButton.size = tagButton.currentImage.size;
    tagButton.width += 40;
    [tagButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:tagButton];
}

+ (instancetype)itemWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName target:(id)target action:(SEL)action{
    
    UIButton *tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagBtn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [tagBtn setBackgroundImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    tagBtn.size = tagBtn.currentBackgroundImage.size;
    [tagBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:tagBtn];
}
- (BOOL)selected
{
    UIButton *button = self.customView;
    
    return button.selected;
}

- (void)setSelected:(BOOL)selected
{
    UIButton *button = self.customView;
    button.selected = selected;
}
@end
