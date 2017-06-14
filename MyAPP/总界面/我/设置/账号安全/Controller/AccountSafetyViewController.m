//
//  AccountSafetyViewController.m
//  BeautyApp
//
//  Created by zhangming on 17/2/17.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "AccountSafetyViewController.h"

#define offsetLeftHand      60

#define rectLeftHand        CGRectMake(61-offsetLeftHand, 90, 40, 65)
#define rectLeftHandGone    CGRectMake(ScreenWidth / 2 - 100, vLogin.frame.origin.y - 22, 40, 40)

#define rectRightHand       CGRectMake(headIm.frame.size.width / 2 + 60, 90, 40, 65)
#define rectRightHandGone   CGRectMake(ScreenWidth / 2 + 62, vLogin.frame.origin.y - 22, 40, 40)

@interface AccountSafetyViewController ()<UITextFieldDelegate>
{
    UITextField *txtUser;
    UITextField *txtPwd;
    UITextField *txtPwd2;
    
    UIImageView* leftArm;
    UIImageView* rightArm;
    
    UIImageView* leftHand;
    UIImageView* rightHand;
    
    HXCShowType showType;
}
@end

@implementation AccountSafetyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBarWithTitle:@"账号安全"];
    
    UIView* vLogin = [[UIView alloc] initWithFrame:CGRectMake(15, 130, ScreenWidth - 30, 200)];
    vLogin.layer.borderWidth = 0.5;
    vLogin.layer.borderColor = [NAVBARCOLOR CGColor];
    vLogin.layer.cornerRadius = 5;
    vLogin.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vLogin];
    
    
    txtUser = [[UITextField alloc] initWithFrame:CGRectMake(30, (vLogin.frame.size.height/3-44)/2, vLogin.frame.size.width - 60, 44)];
    txtUser.delegate = self;
    txtUser.layer.cornerRadius = 5;
    txtUser.placeholder = @"输入原密码";
    txtUser.layer.borderColor = [NAVBARCOLOR CGColor];
    txtUser.layer.borderWidth = 0.5;
    txtUser.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    txtUser.leftViewMode = UITextFieldViewModeAlways;
    UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(11, 11, 22, 22)];
    imgUser.image = [UIImage imageNamed:@"password"];
    [txtUser.leftView addSubview:imgUser];
    [vLogin addSubview:txtUser];
    
    txtPwd = [[UITextField alloc] initWithFrame:CGRectMake(30, (vLogin.frame.size.height/3-44)/2+vLogin.frame.size.height/3, vLogin.frame.size.width - 60, 44)];
    txtPwd.delegate = self;
    txtPwd.layer.cornerRadius = 5;
    txtPwd.placeholder = @"输入新密码";
    txtPwd.layer.borderColor = [NAVBARCOLOR CGColor];
    txtPwd.layer.borderWidth = 0.5;
    txtPwd.secureTextEntry = YES;
    txtPwd.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    txtPwd.leftViewMode = UITextFieldViewModeAlways;
    UIImageView* imgPwd = [[UIImageView alloc] initWithFrame:CGRectMake(11, 11, 22, 22)];
    imgPwd.image = [UIImage imageNamed:@"password"];
    [txtPwd.leftView addSubview:imgPwd];
    [vLogin addSubview:txtPwd];
    
    txtPwd2 = [[UITextField alloc] initWithFrame:CGRectMake(30, (vLogin.frame.size.height/3-44)/2+vLogin.frame.size.height/3*2, vLogin.frame.size.width - 60, 44)];
    txtPwd2.delegate = self;
    txtPwd2.layer.cornerRadius = 5;
    txtPwd2.placeholder = @"确认新密码";
    txtPwd2.layer.borderColor = [NAVBARCOLOR CGColor];
    txtPwd2.layer.borderWidth = 0.5;
    txtPwd2.secureTextEntry = YES;
    txtPwd2.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    txtPwd2.leftViewMode = UITextFieldViewModeAlways;
    UIImageView* imgPwd2 = [[UIImageView alloc] initWithFrame:CGRectMake(11, 11, 22, 22)];
    imgPwd2.image = [UIImage imageNamed:@"password"];
    [txtPwd2.leftView addSubview:imgPwd2];
    [vLogin addSubview:txtPwd2];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField isEqual:txtUser]) {
        if (showType != HXCShowTypePass)
        {
            showType = HXCShowTypeUser;
            return;
        }
        showType = HXCShowTypeUser;
        [UIView animateWithDuration:0.5 animations:^{
            leftArm.frame = CGRectMake(leftArm.frame.origin.x - offsetLeftHand, leftArm.frame.origin.y + 30, leftArm.frame.size.width, leftArm.frame.size.height);
            
            rightArm.frame = CGRectMake(rightArm.frame.origin.x + 48, rightArm.frame.origin.y + 30, rightArm.frame.size.width, rightArm.frame.size.height);
            
            
            leftHand.frame = CGRectMake(leftHand.frame.origin.x - 70, leftHand.frame.origin.y, 40, 40);
            
            rightHand.frame = CGRectMake(rightHand.frame.origin.x + 30, rightHand.frame.origin.y, 40, 40);
            
            
        } completion:^(BOOL b) {
        }];
        
    }
    else if ([textField isEqual:txtPwd]) {
        if (showType == HXCShowTypePass)
        {
            showType = HXCShowTypePass;
            return;
        }
        showType = HXCShowTypePass;
        [UIView animateWithDuration:0.5 animations:^{
            leftArm.frame = CGRectMake(leftArm.frame.origin.x + offsetLeftHand, leftArm.frame.origin.y - 30, leftArm.frame.size.width, leftArm.frame.size.height);
            rightArm.frame = CGRectMake(rightArm.frame.origin.x - 48, rightArm.frame.origin.y - 30, rightArm.frame.size.width, rightArm.frame.size.height);
            
            
            leftHand.frame = CGRectMake(leftHand.frame.origin.x + 70, leftHand.frame.origin.y, 0, 0);
            
            rightHand.frame = CGRectMake(rightHand.frame.origin.x - 30, rightHand.frame.origin.y, 0, 0);
            
        } completion:^(BOOL b) {
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
    if (showType != HXCShowTypePass)
    {
        showType = HXCShowTypeUser;
        return;
    }
    showType = HXCShowTypeUser;
    [UIView animateWithDuration:0.5 animations:^{
        leftArm.frame = CGRectMake(leftArm.frame.origin.x - offsetLeftHand, leftArm.frame.origin.y + 30, leftArm.frame.size.width, leftArm.frame.size.height);
        
        rightArm.frame = CGRectMake(rightArm.frame.origin.x + 48, rightArm.frame.origin.y + 30, rightArm.frame.size.width, rightArm.frame.size.height);
        
        
        leftHand.frame = CGRectMake(leftHand.frame.origin.x - 70, leftHand.frame.origin.y, 40, 40);
        
        rightHand.frame = CGRectMake(rightHand.frame.origin.x + 30, rightHand.frame.origin.y, 40, 40);
        
        
    } completion:^(BOOL b) {
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
