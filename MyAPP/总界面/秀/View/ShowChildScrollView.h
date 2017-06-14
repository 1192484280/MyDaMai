//
//  ShowChildScrollView.h
//  MyAPP
//
//  Created by zhangming on 17/3/13.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShowChildScrollViewDelegate <NSObject>

- (void)scrollViewEndSlideWithIndex:(NSInteger)index;

@end

@interface ShowChildScrollView : UIScrollView

@property (weak, nonatomic) id<ShowChildScrollViewDelegate>myDelegate;

- (instancetype)initWithFrame:(CGRect)frame ChildViewControllers:(NSArray *)children MaxCount:(NSInteger)maxCount;

- (void)scrollViewWithIndex:(NSInteger)index;

@end
