//
//  DiscoverHeadView.h
//  MyAPP
//
//  Created by zhangming on 17/3/1.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^Block)(NSString *URL);
#define HotImageW (ScreenWidth - 4 * 5)/3
#define Margin 5

@interface DiscoverHeadView : UIView

@property (nonatomic,strong) NSMutableArray *listArray;

@property (nonatomic ,strong) Block block;


@end
