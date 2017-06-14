//
//  LoginViewController.m
//  BeautyApp
//
//  Created by zhangming on 17/2/17.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "LoginTopView.h"
#import "LoginBottomView.h"
#import "HXCTextField.h"
#import "LoginStore.h"
#define offsetLeftHand      60

#define rectLeftHand        CGRectMake(61-offsetLeftHand, 90, 40, 65)
#define rectLeftHandGone    CGRectMake(ScreenWidth / 2 - 100, vLogin.frame.origin.y - 22, 40, 40)

#define rectRightHand       CGRectMake(headIm.frame.size.width / 2 + 60, 90, 40, 65)
#define rectRightHandGone   CGRectMake(ScreenWidth / 2 + 62, vLogin.frame.origin.y - 22, 40, 40)

@interface LoginViewController ()<UITextFieldDelegate>
{
    
    UIImageView* leftArm;
    UIImageView* rightArm;
    
    UIImageView* leftHand;
    UIImageView* rightHand;
    
    HXCShowType showType;
    
}
/**
 *  邮箱文本输入框
 */
@property (nonatomic,strong) HXCTextField *YXtextField;
/**
 *  密码文本输入框
 */
@property (nonatomic,strong) HXCTextField *MMtextField;
/**
 *  确认按钮
 */
@property (nonatomic,strong) UIButton *LoginBtn;
/**
 *  邮箱文本框下方的线条
 */
@property (nonatomic,strong) UIView *YXlineView;
/**
 *  密码文本框下方的线条
 */
@property (nonatomic,strong) UIView *MMlineView;

@property (nonatomic, strong) LoginTopView *topView;
@property (nonatomic, strong) LoginBottomView *bottomView;
@end

@implementation LoginViewController

//隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}


#pragma mark - 懒加载
- (LoginTopView *)topView
{
    if (!_topView) {
        _topView = [[LoginTopView alloc] init];
    }
    return _topView;
}

- (LoginBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[LoginBottomView alloc] init];
    }
    return _bottomView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupUI];
}



- (void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)registerUser{
    
    RegisterViewController *UserVC = [[RegisterViewController alloc] init];
    
    [self presentViewController:UserVC animated:YES completion:nil];
}

- (void)setupUI{
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomView];
    //给按钮添加关联方法
    //返回按钮
    [self.topView.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    //注册按钮
    [self.topView.registerBtn addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    
    //微博按钮
    [self.bottomView.weiboButton addTarget:self action:@selector(onWB) forControlEvents:UIControlEventTouchUpInside];
    //人人按钮
    [self.bottomView.peopleButton addTarget:self action:@selector(onRR) forControlEvents:UIControlEventTouchUpInside];
    //豆瓣按钮
    [self.bottomView.doubanButton addTarget:self action:@selector(onDB) forControlEvents:UIControlEventTouchUpInside];
    //QQ按钮
    [self.bottomView.QQButton addTarget:self action:@selector(onQQ) forControlEvents:UIControlEventTouchUpInside];
    //给子控件添加约束
    [self setupAutoLayout];
    
    UIImageView *headIm = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-211)/2, 100, 211, 109)];
    headIm.image = [UIImage imageNamed:@"head"];
    headIm.layer.masksToBounds = YES;
    [self.view addSubview:headIm];
    
    leftArm = [[UIImageView alloc] initWithFrame:rectLeftHand];
    leftArm.image = [UIImage imageNamed:@"arm_left"];
    [headIm addSubview:leftArm];
    
    rightArm = [[UIImageView alloc] initWithFrame:rectRightHand];
    rightArm.image = [UIImage imageNamed:@"arm_right"];
    [headIm addSubview:rightArm];
    
    UIView* vLogin = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(headIm.frame)-8, ScreenWidth - 30, 230)];
    vLogin.layer.borderWidth = 0.5;
    vLogin.layer.borderColor = [RGB(55, 207, 16) CGColor];
    vLogin.layer.cornerRadius = 5;
    vLogin.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vLogin];
    
    leftHand = [[UIImageView alloc] initWithFrame:rectLeftHandGone];
    leftHand.image = [UIImage imageNamed:@"hand"];
    [self.view addSubview:leftHand];
    
    rightHand = [[UIImageView alloc] initWithFrame:rectRightHandGone];
    rightHand.image = [UIImage imageNamed:@"hand"];
    [self.view addSubview:rightHand];
    
    
    
    [vLogin addSubview:self.YXtextField];
    [vLogin addSubview:self.MMtextField];
    [vLogin addSubview:self.YXlineView];
    [vLogin addSubview:self.MMlineView];
    [vLogin addSubview:self.LoginBtn];
    
    [_YXtextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vLogin.mas_top).offset(40);
        make.centerX.equalTo(vLogin.mas_centerX);
        make.left.equalTo(vLogin.mas_left).offset(30);
        make.bottom.equalTo(_MMtextField.mas_top).offset(-20) ;
    }];
    
    //密码输入框约束
    [_MMtextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_YXtextField.mas_bottom).offset(20);
        make.centerX.equalTo(vLogin.mas_centerX);
        make.left.equalTo(_YXtextField.mas_left);
        make.height.equalTo(_YXtextField.mas_height);
    }];
    
    //邮箱线条约束
    [_YXlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_YXtextField.mas_bottom);
        make.centerX.equalTo(vLogin.mas_centerX);
        make.left.equalTo(_YXtextField.mas_left).offset(5);
        make.height.mas_equalTo(1);
    }];
    
    //密码线条约束
    [_MMlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_MMtextField.mas_bottom);
        make.left.equalTo(_MMtextField.mas_left).offset(5);
        make.centerX.equalTo(vLogin.mas_centerX);
        make.height.mas_equalTo(1);
    }];
    
    //登录按钮约束
    [_LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_MMtextField.mas_bottom).offset(20);
        make.centerX.equalTo(vLogin.mas_centerX);
        make.left.equalTo(_MMtextField.mas_left);
        make.height.equalTo(_YXtextField.mas_height);
    }];

}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField isEqual:_YXtextField]) {
        
        [self outEyes];
    }
    else if ([textField isEqual:_MMtextField]) {
        
        [self setEyes];
    }
}

#pragma mark - 点击背景，光标消失
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
    [self outEyes];
}




#pragma mark - 第三方登陆
- (void)onWB{
    [self showAlertWithTitle:@"我没集成微博SDK" andStyle:0];
}
- (void)onRR{
    [self showAlertWithTitle:@"我没集成人人SDK" andStyle:0];
}
- (void)onDB{
    [self showAlertWithTitle:@"我没集成豆瓣SDK" andStyle:0];
}
-(void)onQQ{
    
    [self showAlertWithTitle:@"我没集成QQSDK" andStyle:0];
    
}

- (void)showAlertWithTitle:(NSString *)title andStyle:(NSInteger)style{
    
    
    LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"提示" message:title cancelBtnTitle:nil otherBtnTitle:@"知道了" clickIndexBlock:^(NSInteger clickIndex) {
        
        
    }];
    alert.animationStyle=style;
    [alert showLXAlertView];
}


#pragma mark - 登陆
- (void)onLogin{
    
    LoginStore *store = [[LoginStore alloc] init];
    [store requestWithSuccess:^{
        
        NSLog(@"yes");
    } failure:^(NSError *error) {
        NSLog(@"no");
    }];
    if (![self isEmpty]) {
    
        [self SaveAndLogin];
    }
    
    
}

#pragma mark - 遮住眼
- (void)setEyes{
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

#pragma mark - 睁开眼
- (void)outEyes{
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

#pragma mark - 保存账号并登录
- (void)SaveAndLogin{
    
    
    LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"提示" message:@"登陆成功" cancelBtnTitle:nil otherBtnTitle:@"知道了" clickIndexBlock:^(NSInteger clickIndex) {
        
        //保存账号密码，以备下次直接登录
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:_YXtextField.text forKey:[NSString stringWithFormat:@"user"]];
        [ud setObject:_MMtextField.text forKey:[NSString stringWithFormat:@"pass"]];
        
        [ud setObject:_YXtextField.text forKey:@"uid"];
        
        UIImage *image=[UIImage imageNamed:@"myHeader_hsq"];
        
        //获取图片的data
        NSData *imageData = UIImagePNGRepresentation(image);
        
        //将获取的data本地保存到plist文件当中
        [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"headIm"];
        
        [ud synchronize];
        
        [self postNotifyWithName:NOTIFY_LOGIN];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    alert.animationStyle=2;
    [alert showLXAlertView];
    
}


#pragma mark - 判断账号和密码是否为空
- (BOOL)isEmpty{
    BOOL ret = NO;
    NSString *username = _YXtextField.text;
    NSString *password = _MMtextField.text;
    if (username.length == 0 && password.length == 0) {
        ret = YES;
        LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"提示" message:@"输入账号和密码" cancelBtnTitle:nil otherBtnTitle:@"知道了" clickIndexBlock:^(NSInteger clickIndex) {
            [_YXtextField becomeFirstResponder];
        }];
        alert.animationStyle=LXASAnimationDefault;
        [alert showLXAlertView];
        
    }
    if (username.length == 0 && password.length != 0) {
        ret = YES;
        LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"提示" message:@"输入账号" cancelBtnTitle:nil otherBtnTitle:@"知道了" clickIndexBlock:^(NSInteger clickIndex) {
            [_YXtextField becomeFirstResponder];
        }];
        alert.animationStyle=LXASAnimationDefault;
        [alert showLXAlertView];
        
    }
    if (username.length != 0 && password.length == 0) {
        ret = YES;
        LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"提示" message:@"输入密码" cancelBtnTitle:nil otherBtnTitle:@"知道了" clickIndexBlock:^(NSInteger clickIndex) {
            [_MMtextField becomeFirstResponder];
        }];
        alert.animationStyle=LXASAnimationDefault;
        [alert showLXAlertView];
        
    }
    return ret;
}

#pragma mark - 自动适配
- (void)setupAutoLayout
{
    __weak typeof(self)vc = self;
    //设置上部分视图约束
    CGFloat topViewH = self.view.frame.size.height / 2;
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(vc.view);
        make.height.mas_equalTo(topViewH);
    }];
    
    //设置底部视图的约束
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(vc.view);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height * 0.2);
    }];
}

#pragma mark -
#pragma mark - 懒加载
- (HXCTextField *)YXtextField
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];

    if (!_YXtextField) {
        //创建邮箱TextField
        _YXtextField = [[HXCTextField alloc] init];
        _YXtextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _YXtextField.delegate =self;
        _YXtextField.title = @"邮箱";
        _YXtextField.text = [ud valueForKey:@"user"];
    }
    return _YXtextField;
}

- (HXCTextField *)MMtextField
{
    
    if (!_MMtextField) {
        _MMtextField = [[HXCTextField alloc] init];
        _MMtextField.delegate = self;
        _MMtextField.title = @"密码";
        _MMtextField.secureTextEntry = YES;
        _MMtextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
    }
    return _MMtextField;
}


- (UIView *)YXlineView
{
    if (!_YXlineView) {
        _YXlineView = [[UIView alloc] init];
        _YXlineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _YXlineView;
}


- (UIView *)MMlineView
{
    if (!_MMlineView) {
        _MMlineView = [[UIView alloc] init];
        _MMlineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _MMlineView;
}

- (UIButton *)LoginBtn
{
    if (!_LoginBtn) {
        _LoginBtn = [[UIButton alloc] init];
        _LoginBtn.backgroundColor = RGB(55, 207, 16);
        [_LoginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_LoginBtn addTarget:self action:@selector(onLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _LoginBtn;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
