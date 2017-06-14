//
//  MeViewController.m
//  MyAPP
//
//  Created by zhangming on 17/1/12.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "MeViewController.h"
#import "MeHeaderView.h"
#import "SetViewController.h"
#import "LoginViewController.h"
#import "MeOtherViewController.h"
#import "MyDataViewController.h"
@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource,MeHeaderViewDelegate>

@property (copy , nonatomic) NSArray *titles;
@property (copy , nonatomic) NSArray *images;
@property (weak, nonatomic) UITableView *tableView;
@property (weak , nonatomic) MeHeaderView *headerView;

@end

@implementation MeViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (NSArray *)titles{
    
    if (!_titles) {
        _titles = @[@[@"我的订单",@"我的票夹",@"我的钱包"],@[@"我的订阅",@"我的收藏"]];
    }
    return _titles;
}

- (NSArray *)images{
    
    if (!_images) {
        
        _images = @[@[@"mine_dingdan",@"mine_ticket",@"mine_dianziqianbao"],@[@"my_subscribe",@"mine_shoucang"]];
    }
    return _images;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBar];
    
    [self setup];
    
    //登陆
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBtnTitle1) name:NOTIFY_LOGIN object:nil];
    
    //退出登录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBtnTitle2) name:NOTIFY_LOGINOUT object:nil];
    
    //修改头像
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeHeadIm) name:NOTIFY_HEADIM object:nil];
    
    //修改昵称
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBtnTitle1) name:NOTIFY_CHANGENAME object:nil];
}

- (void)changeBtnTitle1{
    
    [self.headerView.titleBtn setTitle:[self getName] forState:UIControlStateNormal];
}
- (void)changeBtnTitle2{
    
    [self.headerView.titleBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
}

- (void)changeHeadIm{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSData *headIm = [ud valueForKey:@"headIm"];
    self.headerView.headIm.image = [UIImage imageWithData:headIm];
}
- (void)setupNavBar
{
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [self.view addSubview:navBar];
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    [navBar pushNavigationItem:navItem animated:YES];
    [navBar setBackgroundImage:[UIImage imageWithColor:NAVBARCOLOR size:CGSizeMake(ScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    navItem.title = ME;
    [navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:BASEFONT size:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    UIBarButtonItem *item1 = [UIBarButtonItem itemWithImageName:@"my_setting" highImageName:@"my" target:self action:@selector(navItem1Click:)];
    
    
    UIBarButtonItem *item2 = [UIBarButtonItem itemWithImageName:@"my_message" highImageName:@"my" target:self action:@selector(navItem2Click:)];
    
    navItem.rightBarButtonItems = @[item1,item2];
    navBar.translucent = NO;
    
}

- (void)setup{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStyleGrouped];
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    tableView.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0);
    tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 49, 0);
    tableView.backgroundColor = TABBGCOLOR;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    MeHeaderView *headerView = [[MeHeaderView alloc] init];
    headerView.delegate = self;
    headerView.height = 150;
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    
    //设置登陆按钮标题
    if ([self getUid].length>0) {
        
        if ([self getName].length>0) {
            
            [self.headerView.titleBtn setTitle:[self getName] forState:UIControlStateNormal];
            
           
            self.headerView.headIm.image = [UIImage imageWithData:[self getHeadIm]];
        }
        
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.titles.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.titles[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *MeViewCellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MeViewCellId];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MeViewCellId];
        //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#444444"];
        
    }
    cell.imageView.image = [UIImage imageNamed:self.images[indexPath.section][indexPath.row]];
    cell.textLabel.text = self.titles[indexPath.section][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0.5;
    }else{
        return 9.5;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self getUid].length > 0) {
        
        [self goOtherWithTitle:self.titles[indexPath.section][indexPath.row]];
    }else{
        
        [self goLogin];
    }
    
}

#pragma mark - 设置
- (void)navItem1Click:(UIBarButtonItem *)button
{
    NSLog(@"设置");
    SetViewController *setVC = [[SetViewController alloc] init];
    [setVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:setVC animated:YES];
    
}

#pragma mark - 消息
- (void)navItem2Click:(UIBarButtonItem *)button{
    
    if ([self getUid].length >0) {
        
        NSLog(@"消息");
    }else{
        
        [self goLogin];
    }
    
}

#pragma mark - 登陆/注册
- (void)onLogin{
    
    
    if ([self getUid].length >0) {
        
        NSLog(@"%@",[self getUser]);
        MyDataViewController *myData = [[MyDataViewController alloc] init];
        [myData setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:myData animated:YES];
    }else{
        
        NSLog(@"登陆/注册");
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [loginVC setHidesBottomBarWhenPushed:YES];
        [self presentViewController:loginVC animated:YES completion:nil];

    }
    
}

#pragma mark - 优惠券
- (void)onLeft{
    
    if ([self getUid].length>0) {
        
        [self goOtherWithTitle:@"优惠券"];
    }else{
        
        [self goLogin];
    }
    
}

#pragma mark - 我的积分
- (void)onRight{

    if ([self getUid].length > 0) {
        
        [self goOtherWithTitle:@"我的积分"];
    }else{
        
        [self goLogin];
    }
    
}

- (void)goOtherWithTitle:(NSString *)title{
    
    MeOtherViewController *meOtherVC = [[MeOtherViewController alloc] init];
    [meOtherVC setupNavBarWithTitle:title];
    [meOtherVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:meOtherVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:NOTIFY_LOGINOUT];
    [[NSNotificationCenter defaultCenter] removeObserver:NOTIFY_LOGIN];
    [[NSNotificationCenter defaultCenter] removeObserver:NOTIFY_HEADIM];
    [[NSNotificationCenter defaultCenter] removeObserver:NOTIFY_CHANGENAME];
}

@end
