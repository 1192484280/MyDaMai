//
//  ZKADImageView.m
//  BBC
//
//  Created by 张日奎 on 16/11/14.
//  Copyright © 2016年 bestdew. All rights reserved.
//

#import "ZKADView.h"

@interface ZKADView ()

@property (nonatomic, strong) UITapGestureRecognizer *tap; // 广告图点击手势
@property (nonatomic, strong) CATransition *transition;
@property (nonatomic, strong) UIButton *skipButton; // 跳过按钮
@property (nonatomic, strong) dispatch_source_t timer; // 显示计时器
@property (nonatomic, strong) dispatch_source_t timer_wait; // 等待计时器
@property (nonatomic, assign) BOOL flag; // 用于判断是否将要执行消失动画；

@end

@implementation ZKADView

#pragma mark -- 初始化
- (instancetype)init
{
    if (self = [super init]) {
        
        [self defaultConfiguration];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self defaultConfiguration];
}

#pragma mark -- Actions
/** 跳过按钮点击事件 */
- (void)skipAction:(UIButton *)sender
{
    if (_skipType == SkipButtonTypeTime) return;
    
    if (_timer) dispatch_source_cancel(_timer);
    
    [self dismiss];
}

/** 广告图点击事件 */
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    if (_duration <= 0) return;
    
    if ([self.delegate respondsToSelector:@selector(adImageDidClick:)]) {
        
        [self.delegate adImageDidClick:self];
    }
}

/** 消失广告图 */
- (void)dismiss
{
    [UIView animateWithDuration:0.6 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.transform = CGAffineTransformMakeScale(1.1, 1.1);
        self.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

#pragma mark -- methods
- (void)reloadDataWithURL:(nullable NSURL *)url
{
    if (!url) {
        
        if (_timer_wait) dispatch_source_cancel(_timer_wait);
        
        [self dismiss];
        
        return;
    }

    self -> _url = url;
    
    __weak typeof(self) weakSelf = self;
    
    [ZKWebImage downloadImageWithURL:_url options:_options complete:^(UIImage *image) {
        
        if (!image || weakSelf.flag) return;
        
        weakSelf.image = image;
        
        weakSelf.userInteractionEnabled = YES;
        
        [weakSelf addGestureRecognizer:weakSelf.tap];
        
        [weakSelf.layer addAnimation:weakSelf.transition forKey:@"transition"];
        
        [weakSelf scheduledTimer]; // 启动倒计时
        
        if ([weakSelf.delegate respondsToSelector:@selector(adImageLoadFinish:image:)])
            
            [weakSelf.delegate adImageLoadFinish:self image:image];
    }];
}

#pragma mark -- others
/** 广告图显示倒计时 */
- (void)scheduledTimer
{
    if (_timer_wait) dispatch_source_cancel(_timer_wait);
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); // 每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (_duration <= 0) {
                
                dispatch_source_cancel(_timer);
                
                [self dismiss]; // 关闭界面
            }
            
            [self showSkipBtnTitleTime:_duration];
            
            _duration--;
        });
    });
    dispatch_resume(_timer);
}

/** 广告图加载前等待计时器 */
- (void)scheduledWaitTimer
{
    if (_timer_wait) dispatch_source_cancel(_timer_wait);
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer_wait = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer_wait, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(_timer_wait, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (_waitTime <= 0) {
                
                dispatch_source_cancel(_timer_wait);
                
                _flag = YES;
                
                [self dismiss]; // 关闭界面
            }
            _waitTime--;
        });
    });
    dispatch_resume(_timer_wait);
}

- (void)showSkipBtnTitleTime:(NSInteger)timeLeave
{
    switch (_skipType) {
        case SkipButtonTypeNone:
            
            self.skipButton.hidden = YES;
            
            break;
        case SkipButtonTypeTime:
            
            [self.skipButton setTitle:[NSString stringWithFormat:@"%ld S", timeLeave] forState:UIControlStateNormal];
            
            break;
        case SkipButtonTypeText:
            
            [self.skipButton setTitle:@"跳过" forState:UIControlStateNormal];
            
            break;
            
        case SkipButtonTypeTimeAndText:
            
            [self.skipButton setTitle:[NSString stringWithFormat:@"%ld 跳过", timeLeave] forState:UIControlStateNormal];
            
            break;
            
        default:
            break;
    }
}

/** 默认配置 */
- (void)defaultConfiguration
{
    self.flag = NO;
    
    self.duration = 5;
    
    self.waitTime = 3;
    
    self.skipType = SkipButtonTypeTimeAndText;
    
    self.image = [self getLaunchImage];
    
    self.frame = [[UIScreen mainScreen] bounds];
}

/** 获取启动图片 */
- (UIImage *)getLaunchImage
{
    UIImage *lauchImage = nil;
    NSString *viewOrientation = nil;
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        
        viewOrientation = @"Landscape";
        
    }else{
        
        viewOrientation = @"Portrait";
    }
    
    NSArray *imagesDictionary = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in imagesDictionary) {
        
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            
            lauchImage = [UIImage imageNamed:dict[@"UILaunchImageName"]];
        }
    }
    return lauchImage;
}

- (void)dealloc
{
    NSLog(@"销毁！");
}

#pragma mark -- setter & getter
- (UITapGestureRecognizer *)tap
{
    if (!_tap) {
        
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    }
    return _tap;
}

- (CATransition *)transition
{
    if (!_transition) {
        
        _transition = [CATransition animation];
        _transition.type = kCATransitionFade;
        _transition.duration = 0.2;
    }
    return _transition;
}

- (UIButton *)skipButton
{
    if (!_skipButton) {
        
        _skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _skipButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 70, 30, 60, 30);
        _skipButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        _skipButton.layer.cornerRadius = 15;
        //_skipButton.layer.masksToBounds = YES;
        _skipButton.titleLabel.font = [UIFont systemFontOfSize:13.5];
        [_skipButton addTarget:self action:@selector(skipAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_skipButton];
    }
    return _skipButton;
}

- (void)setDuration:(NSUInteger)duration
{
    _duration = duration;
    
    if (duration < 3) _duration = 3;
}

- (void)setWaitTime:(NSUInteger)waitTime
{
    _waitTime = waitTime;
    
    if (waitTime < 1) _waitTime = 1;
    
    [self scheduledWaitTimer]; // 启动等待计时器
}

- (void)setFrame:(CGRect)frame
{
    frame = [[UIScreen mainScreen] bounds];
    
    [super setFrame:frame];
}

@end
