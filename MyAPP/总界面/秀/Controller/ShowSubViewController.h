//
//  ShowSubViewController.h
//  MyAPP
//
//  Created by zhangming on 17/3/10.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShowRequestModel;

@interface ShowSubViewController : BaseViewController

@property (weak , nonatomic) UITableView *tableView;

- (void)loadData:(ShowRequestModel *)model Complete:(void(^)())complete;

@end
