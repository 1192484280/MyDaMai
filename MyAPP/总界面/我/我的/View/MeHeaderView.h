//
//  MeHeaderView.h
//  BeautyApp
//
//  Created by zhangming on 17/1/22.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MeHeaderView;

@protocol MeHeaderViewDelegate <NSObject>

- (void)onLogin;
- (void)onLeft;
- (void)onRight;

@end

@interface MeHeaderView : UIView

@property (nonatomic,strong) id<MeHeaderViewDelegate>delegate;

@property (weak , nonatomic) UIImageView *bgView;

@property (strong , nonatomic) UIImageView *headIm;
@property (weak, nonatomic) UIButton *titleBtn;
@property (weak, nonatomic) UIView *bottomView;

@end
