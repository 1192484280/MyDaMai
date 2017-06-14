//
//  TypeScrollView.h
//  大麦
//
//  Created by 洪欣 on 16/12/20.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TypeScrollViewDelegate <NSObject>

- (void)didTypeWithIndex:(NSInteger)index;

@end

@interface TypeScrollView : UIScrollView
@property (weak, nonatomic) id<TypeScrollViewDelegate> myDelegate;
- (instancetype)initWithFrame:(CGRect)frame Titles:(NSArray *)titels;
- (void)selectedButtonForIndex:(NSInteger)index;
@end
