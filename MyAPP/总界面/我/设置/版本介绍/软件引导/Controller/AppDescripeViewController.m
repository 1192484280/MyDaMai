//
//  AppDescripeViewController.m
//  JuHuiLife
//
//  Created by zhangming on 16/10/13.
//  Copyright © 2016年 youjiesi. All rights reserved.
//

#import "AppDescripeViewController.h"
#import "GifView.h"

@interface AppDescripeViewController ()<UIScrollViewDelegate>

@end

@implementation AppDescripeViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //重写返回按钮
    [self setupNavBarWithTitle:@"软件引导"];
    
    UIView *vie = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    [self.view addSubview:vie];
    vie.backgroundColor = [UIColor grayColor];
    
    UIScrollView *sv =[[UIScrollView alloc] init];
    sv.frame = vie.bounds;
    [vie addSubview:sv];
    sv.contentSize = CGSizeMake(vie.bounds.size.width, vie.bounds.size.height*6);
    sv.contentOffset = CGPointMake(0, vie.bounds.size.height);
    
    sv.delegate = self;
    
    sv.pagingEnabled = YES;
    
    
    
    NSArray *array1 = @[@"leaderPage_01",
                        @"leaderPage_02",
                        @"leaderPage_03",
                        @"leaderPage_04"];
    
    for (int i = 0; i<4; i++) {
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:array1[i]]];
        iv.frame = CGRectMake(0, vie.bounds.size.height*(i+1), vie.bounds.size.width, vie.bounds.size.height);
        [sv addSubview:iv];
        
        
    }
    UIImageView *iv5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:array1[3]]];
    iv5.frame = CGRectMake(0, 0, vie.bounds.size.width, vie.bounds.size.height);
    [sv addSubview:iv5];
    UIImageView *iv6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:array1[0]]];
    iv6.frame = CGRectMake(0, vie.bounds.size.height*5, vie.bounds.size.width, vie.bounds.size.height);
    [sv addSubview:iv6];
        //得到图片的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"arrow" ofType:@"gif"];
    //创建一个第三方的View显示图片
    GifView *dataView2 = [[GifView alloc] initWithFrame:CGRectMake((ScreenWidth-50)/2, ScreenHeight-60, 50, 50) filePath:path];
    [self.view addSubview:dataView2];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.y/scrollView.frame.size.height == 5) {
        scrollView.contentOffset =  CGPointMake(0, scrollView.frame.size.height);
    }else if (scrollView.contentOffset.y/scrollView.frame.size.height == 0){
        scrollView.contentOffset = CGPointMake(0, scrollView.frame.size.height*4);
    }
    
    
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
