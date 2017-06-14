//
//  SetViewController.m
//  BeautyApp
//
//  Created by zhangming on 17/2/15.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "SetViewController.h"
#import "AccountSafetyViewController.h"
#import "VersionViewController.h"
#import "MyDataViewController.h"

@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) UITableView *tabView;
@property (strong , nonatomic) NSArray *titles;

@end

@implementation SetViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (NSArray *)titles{
    
    if (!_titles) {
        
        _titles = @[@"我的资料",@"账号安全",@"检测缓存",@"关于安源"];
        
    }
    
    return _titles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBarWithTitle:@"设置"];
    
    [self setupUI];
    
    //登陆
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable) name:NOTIFY_LOGIN object:nil];
    
    //退出登录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable) name:NOTIFY_LOGINOUT object:nil];
}


#pragma mark - 登录状态改变，刷新页面数据
- (void)reloadTable{
    
    [self.tabView reloadData];
}

#pragma mark - 返回
- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 创建tableview
- (void)setupUI{
    
    UITableView *tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    [self.view addSubview:tabView];
    tabView.backgroundColor = TABBGCOLOR;
    tabView.delegate = self;
    tabView.dataSource = self;
    
    [tabView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tabView = tabView;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = self.titles[indexPath.row];
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            
            [self myData];
            
            break;
    
        case 1:
            
            [self myAccount];
            
            break;
        case 2:
            
            [MBProgressHUD showMessag:@"正在检测" toView:self.view];
            [self performSelector:@selector(cleanAlert) withObject:nil afterDelay:2];
            
            break;
        case 3:
            
            [self MyVersion];
            
            break;
        default:
            break;
    }
}

#pragma mark - 定制段尾
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 70)];
    view.backgroundColor = TABBGCOLOR;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, 50)];
    [view addSubview:btn];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitle:@"退出登录" forState:0];
    //btn.titleLabel.font = [UIFont fontWithName:@"迷你简启体" size:17.0];
    [btn setTitleColor:[UIColor redColor] forState:0];
    [btn addTarget:self action:@selector(onLoginOut) forControlEvents:UIControlEventTouchUpInside];
    return view;
    
}
//段尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self getUid].length>0) {
        
        return 70;
    }else{
        
        return 0;
    }

}
#pragma mark - 我的资料
- (void)myData{
    
    if ([self getUid].length>0) {
     
        MyDataViewController *myDataVC = [[MyDataViewController alloc] init];
        [self.navigationController pushViewController:myDataVC animated:YES];
    }else{
        
        [self goLogin];
        
    }
}



#pragma mark - 账号安全
- (void)myAccount{
    
    if ([self getUid].length>0) {
        
        AccountSafetyViewController *accountSafetyVC = [[AccountSafetyViewController alloc] init];
        [self.navigationController pushViewController:accountSafetyVC animated:YES];
    }else{
        
        [self goLogin];
        
    }
    
}

#pragma mark - 缓存清理
- (void)cleanAlert{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if ([self filePath] == 0) {
        
        [MBProgressHUD showSuccess:@"未检测到缓存" toView:self.view];

        
    }else{
       
        NSString *title = [NSString stringWithFormat:@"检测出%.1fM缓存",[self filePath]];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"清理" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [MBProgressHUD showMessag:@"正在清理" toView:self.view];
            [self performSelector:@selector(cleanFile) withObject:nil afterDelay:2];
            
        }]];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }
    

}

- (void)cleanFile{
    
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
    
    NSLog ( @"cachpath = %@" , cachPath);
    
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        
        NSString * path = [cachPath stringByAppendingPathComponent :p];
        
        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
            
            [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
            
        }
    }
    
    [ self performSelectorOnMainThread : @selector (clearCachSuccess) withObject : nil waitUntilDone : YES ];
}

-(void)clearCachSuccess
{
    NSLog ( @" 清理成功 " );
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [MBProgressHUD showSuccess:@"清理成功" toView:self.view];
    
    
}

#pragma mark - 版本介绍
- (void)MyVersion{
   
    VersionViewController *versionVC = [[VersionViewController alloc] init];
    [self.navigationController pushViewController:versionVC animated:YES];
}




#pragma mark - 退出登录
- (void)onLoginOut{
    
    [MBProgressHUD showMessag:@"退出登录" toView:self.view];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"" forKey:@"uid"];
    [ud setObject:@"" forKey:@"pass"];
    [ud synchronize];
    
    [self performSelector:@selector(reloadTeble) withObject:nil afterDelay:2.0];
}

- (void)reloadTeble{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self postNotifyWithName:NOTIFY_LOGINOUT];
}

#pragma mark - 显示缓存大小
-( float )filePath

{
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];

    return [ self folderSizeAtPath :cachPath];
}

//1:首先我们计算一下 单个文件的大小
- ( long long ) fileSizeAtPath:( NSString *) filePath{

    NSFileManager * manager = [ NSFileManager defaultManager ];

    if ([manager fileExistsAtPath :filePath]){

        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];

    }

    return 0 ;
}

//2:遍历文件夹获得文件夹大小，返回多少 M（提示：你可以在工程界设置（)m）
- ( float ) folderSizeAtPath:( NSString *) folderPath{

    NSFileManager * manager = [ NSFileManager defaultManager ];

    if (![manager fileExistsAtPath :folderPath]) return 0 ;

    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];

    NSString * fileName;

    long long folderSize = 0 ;

    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){

        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];

        folderSize += [ self fileSizeAtPath :fileAbsolutePath];

    }

    return folderSize/( 1024.0 * 1024.0 );

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
