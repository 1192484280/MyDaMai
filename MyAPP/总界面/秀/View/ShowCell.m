//
//  ShowCell.m
//  MyAPP
//
//  Created by zhangming on 17/3/8.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "ShowCell.h"

@interface ShowCell ()

@property (weak , nonatomic) UILabel *priceLa;

@property (weak , nonatomic) UILabel *seatLa;

@property (weak , nonatomic) UILabel *saleLa;

@property (weak , nonatomic) UILabel *lla;

@end

@implementation ShowCell

+ (instancetype)tempTableViewCellWith:(UITableView *)tableView{
    
    ShowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        
        NSString *className = NSStringFromClass([self class]);
        cell = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:0];
    }
    return cell;
}

#pragma mark - 生成cell
+ (instancetype)cell{
    
    NSString *className = NSStringFromClass([self class]);
    
    return [[NSBundle mainBundle] loadNibNamed:className owner:self options:nil][0];
    
}


#pragma mark - 获取高度
+ (CGFloat)getHeight{
    
    UITableViewCell *cell = [self cell];
    return cell.frame.size.height;
}

- (void)setModel:(ShowViewCellModel *)model
{
    _model = model;
    
    NSString *urlTop = @"http://pimg.damai.cn/perform/project";
    NSString *str1 = [model.i substringToIndex:4];
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/%@_n.jpg",urlTop,str1,model.i];
    
    [self.im sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    self.title.text = model.n;
    self.time.text = model.t;
    self.adress.text = model.VenName;
    
    self.priceLa.text = model.priceName;
    
    if (self.model.s.integerValue == 3) {
        
        self.saleLa.text = @"售票中";
        self.saleLa.textColor = [UIColor colorWithHexString:@"F4153D"];
        self.saleLa.layer.borderColor = [[UIColor colorWithHexString:@"F4153D"] CGColor];
        
    }else if (self.model.s.integerValue == 7){
        
        self.saleLa.text = @"预定中";
        self.saleLa.textColor = [UIColor colorWithHexString:@"FF9900"];
        self.saleLa.layer.borderColor = [[UIColor colorWithHexString:@"FF9900"] CGColor];
        
    }else if (self.model.s.integerValue == 8){
        
        self.saleLa.text = @"预售中";
        self.saleLa.textColor = [UIColor colorWithHexString:@"B3E825"];
        self.saleLa.layer.borderColor = [[UIColor colorWithHexString:@"B3E825"] CGColor];
    }
    
    
}
- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    UILabel *price = [[UILabel alloc] init];
    price.textColor = NAVBARCOLOR;
    price.font = [UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview:price];
    
    self.priceLa = price;
    
    self.saleLa = [self createLabel:@"预售中" colorHEX:@"B3E825"];
    
    self.seatLa = [self createLabel:@"座" colorHEX:@"24BCB9"];
    
}

- (UILabel *)createLabel:(NSString *)title colorHEX:(NSString *)color{
    
    UILabel *la = [[UILabel alloc] init];
    la.text = title;
    la.textColor = [UIColor colorWithHexString:color];
    la.font = [UIFont systemFontOfSize:12];
    la.textAlignment = NSTextAlignmentCenter;
    la.layer.cornerRadius = 3;
    la.layer.borderWidth = 1;
    la.layer.borderColor = [[UIColor colorWithHexString:color] CGColor];
    la.height = 18;
    la.width = [la getTextWidth]+8;
    [self.contentView addSubview:la];
    return la;
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    

    CGFloat textLbX = 120;
    
    CGFloat moneyX = textLbX;
    CGFloat moneyY = 160 - 8 - 15;
    self.priceLa.frame = CGRectMake(moneyX, moneyY, 0, 15);
    self.priceLa.width = [self.priceLa getTextWidth];
    
    CGFloat marginX = textLbX;
    if (self.model.IsXuanZuo) {
        self.seatLa.hidden = NO;
        self.seatLa.x = marginX;
        self.seatLa.centerY = self.priceLa.centerY;
        marginX = CGRectGetMaxX(self.seatLa.frame) + 5;
        self.saleLa.x = marginX;
        self.saleLa.centerY = self.priceLa.centerY;
        marginX = CGRectGetMaxX(self.saleLa.frame) + 5;
    }else {
        self.seatLa.hidden = YES;
        self.saleLa.x = marginX;
        self.saleLa.centerY = self.priceLa.centerY;
        marginX = CGRectGetMaxX(self.saleLa.frame) + 5;
    }
    
    self.priceLa.x = marginX;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
