//
//  RadioListViewController.m
//  MyAPP
//
//  Created by zhangming on 17/3/9.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "RadioListViewController.h"
#import "RadioListHeadView.h"

@interface RadioListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong , nonatomic) UITableView *radioListtableView;

@end

@implementation RadioListViewController

- (UITableView *)radioListtableView{
    
    if (!_radioListtableView) {
        
        _radioListtableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        
        _radioListtableView.delegate = self;
        _radioListtableView.dataSource = self;
        [self.view addSubview:_radioListtableView];
    }
    return _radioListtableView;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUI];
    
}

- (void)setUI{
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
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
