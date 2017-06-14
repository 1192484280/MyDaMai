//
//  ShowSelectTypeView.m
//  大麦
//
//  Created by 洪欣 on 16/12/21.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "ShowSelectTypeView.h"

@interface ShowSelectTypeView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) UITableView *leftView;
@property (weak, nonatomic) UITableView *rightView;
@property (copy, nonatomic) NSArray *leftAy;
@property (copy, nonatomic) NSArray *rightAy;
@property (assign, nonatomic) NSInteger leftIndex;
@property (strong, nonatomic) NSMutableArray *selectIndexs;
@end

@implementation ShowSelectTypeView

- (NSArray *)leftAy
{
    if (!_leftAy) {
        _leftAy = @[@[@"icon_filter_timeType_normal",@"icon_filter_sortType_normal"],@[@"时间范围",@"排序方式"]];
    }
    return _leftAy;
}

- (NSMutableArray *)selectIndexs
{
    if (!_selectIndexs) {
        _selectIndexs = [NSMutableArray arrayWithObjects:@(0),@(0), nil];
    }
    return _selectIndexs;
}

- (NSArray *)rightAy
{
    if (!_rightAy) {
        _rightAy = @[@[@"全部时间",@"今天",@"明天",@"一周内",@"一个月内"],@[@"按热门",@"按更新时间",@"按演出时间"]];
    }
    return _rightAy;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    UITableView *leftView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width * 0.4, 0) style:UITableViewStylePlain];
    leftView.dataSource = self;
    leftView.delegate = self;
    leftView.bounces = NO;
    leftView.separatorStyle = UITableViewCellSeparatorStyleNone;
    leftView.backgroundColor = [UIColor whiteColor];
    [leftView registerClass:[ShowSelectTypeLeftView class] forCellReuseIdentifier:@"leftId"];
    [self addSubview:leftView];
    self.leftView = leftView;
    [leftView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    UITableView *rightView = [[UITableView alloc] initWithFrame:CGRectMake(self.width * 0.4, 0, self.width * 0.6, 0) style:UITableViewStylePlain];
    rightView.dataSource = self;
    rightView.delegate = self;
    rightView.bounces = NO;
    rightView.separatorStyle = UITableViewCellSeparatorStyleNone;
    rightView.backgroundColor = TABBGCOLOR;
    [rightView registerClass:[ShowSelectTypeRightView class] forCellReuseIdentifier:@"rightId"];
    [self addSubview:rightView];
    self.rightView = rightView;
    [rightView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftView) {
        return [self.leftAy[1] count];
    }else {
        return [self.rightAy[self.leftIndex] count];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftView) {
        ShowSelectTypeLeftView *cell = [tableView dequeueReusableCellWithIdentifier:@"leftId"];
        cell.imageView.image = [UIImage imageNamed:self.leftAy[0][indexPath.row]];
        cell.textLabel.text = self.leftAy[1][indexPath.row];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        
        cell.index = indexPath.row;
        return cell;
    }else {
        ShowSelectTypeRightView *cell = [tableView dequeueReusableCellWithIdentifier:@"rightId"];
        cell.textLabel.text = self.rightAy[self.leftIndex][indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftView) {
        self.leftIndex = indexPath.row;
        [self.rightView reloadData];
        NSInteger row = [self.selectIndexs[indexPath.row] integerValue];
        [self.rightView selectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    }else {
        [self.selectIndexs replaceObjectAtIndex:self.leftIndex withObject:@(indexPath.row)];
        SingleClass *single = [SingleClass sharedInstance];
        if (self.leftIndex == 0) {
            NSString *startTime;
            NSString *endTime;
            switch (indexPath.row) {
                case 0:
                    startTime = @"";
                    endTime = @"";
                    break;
                case 1:
                    startTime = [NSDate getCurrentDate];
                    endTime = [NSDate getTomorrowDay];
                    break;
                case 2:
                    startTime = [NSDate getTomorrowDay];
                    endTime = [NSDate getAfterTomorrowDate];
                    break;
                case 3:
                    startTime = [NSDate getCurrentDate];
                    endTime = [NSDate getWeekDate];
                    break;
                case 4:
                    startTime = [NSDate getCurrentDate];
                    endTime = [NSDate getMonthDate];
                    break;
                default:
                    break;
            }
            single.startTime = startTime;
            single.endTime = endTime;
        }else {
            single.ot = indexPath.row;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_TYPESELECT object:nil];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.leftView.height = self.height;
    self.rightView.height = self.height;
}

@end


@interface ShowSelectTypeLeftView ()
@property (copy, nonatomic) NSArray *selectImg;
@property (strong, nonatomic) UIView *lineView;
@end

@implementation ShowSelectTypeLeftView

- (NSArray *)selectImg
{
    if (!_selectImg) {
        _selectImg = @[@[@"icon_filter_timeType_normal",@"icon_filter_sortType_normal"], @[@"icon_filter_timeType_selected",@"icon_filter_sortType_selected"]];
    }
    return _selectImg;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.textLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
        [self.contentView addSubview:self.lineView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.lineView.frame = CGRectMake(0, self.height - 0.5, self.width, 0.5);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    NSString *imageName;
    if (selected) {
        imageName = self.selectImg[1][self.index];
    }else {
        imageName = self.selectImg[0][self.index];
    }
    self.imageView.image = [UIImage imageNamed:imageName];
    
    self.backgroundColor = selected ? TABBGCOLOR : [UIColor whiteColor];
}

@end


@interface ShowSelectTypeRightView ()
@property (weak, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UIView *lineView;
@end

@implementation ShowSelectTypeRightView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = TABBGCOLOR;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"duigou"]];
        icon.width = 15;
        icon.height = 10;
        [self.contentView addSubview:icon];
        self.icon = icon;
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.textLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
        [self.contentView addSubview:self.lineView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    self.icon.hidden = !selected;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.icon.x = self.width - 15 - self.icon.width;
    self.icon.centerY = self.height / 2;
    self.lineView.frame = CGRectMake(0, self.height - 0.5, self.width, 0.5);
}

@end
