//
//  sequenceView.h
//  progressCus
//
//  Created by 张东 on 2017/5/27.
//  Copyright © 2017年 张东. All rights reserved.
//

#import <UIKit/UIKit.h>
@class sequenceView;
@protocol sequenceViewDelegate <NSObject>

- (void)sequenceViewWithSequenceView:(sequenceView *)sequenceView sequenceBtn:(UIButton *)sequenceBtn;
@end


@interface sequenceView : UIView
- (void)sequenceWith:(NSArray *)titleArr contentArr: (NSArray *)contentArr;

@property (nonatomic, weak) id<sequenceViewDelegate> delegate;

@end
