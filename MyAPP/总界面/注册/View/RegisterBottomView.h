//
//  RegisterBottomView.h
//  PianKe
//
//  Created by 胡明昊 on 16/2/29.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXCTextField;
@interface RegisterBottomView : UIView
/**
 *  昵称输入框
 */
@property (nonatomic,strong) HXCTextField *nameTextField;
/**
 *  邮箱输入框
 */
@property (nonatomic,strong) HXCTextField *YXTextField;
/**
 *  密码输入框
 */
@property (nonatomic,strong) HXCTextField *MMTextField;
/**
 *  完成注册按钮
 */
@property (nonatomic,strong) UIButton *FinishBtn;
/**
 *  片刻协议按钮
 */
@property (nonatomic,strong) UIButton *messageBtn;
@end
