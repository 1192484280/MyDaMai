//
//  BooksCell.m
//  Family
//
//  Created by zhangming on 17/5/31.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "BooksCell.h"

@implementation BooksCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)tempWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identity = @"";
    NSInteger index = 0;
    
    switch (indexPath.section) {
        case 0:
            
            identity = @"CELL1";
            index = 0;
            break;
        case 1:
            
            identity = @"CELL2";
            index = 1;
            break;
        default:
            
            identity = @"CELL3";
            index = 2;
            break;
    }
    
    BooksCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        
        CLASSNAME
        cell = [[[NSBundle mainBundle]loadNibNamed:className owner:self options:nil]objectAtIndex:index];
    }
    return cell;
}

+(CGFloat)getHeightWithIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self  cellWithIndex:indexPath];
    return cell.frame.size.height;
}

+ (instancetype)cellWithIndex:(NSIndexPath *)indexPath{
    
    NSInteger index = 0;
    if (indexPath.section == 0) {
        
        index = 0;
    }else if(indexPath.section == 1){
        
        index = 1;
    }else{
        
        index = 2;
    }
    CLASSNAME
    return [[[NSBundle mainBundle]loadNibNamed:className owner:self options:nil] objectAtIndex:index];
}

- (void)setTypeArr:(NSArray *)typeArr{
    
    for (int i =0; i<typeArr.count; i++) {
        
        BAButton *btn = [[BAButton alloc] initWithFrame:CGRectMake(15 + i*70, 0, 70, 100)];
        btn.centerY = self.typeView.centerY;
        [btn setTitle:typeArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        NSString *str = [NSString stringWithFormat:@"type_icon0%d",i+1];
        [btn setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
        btn.padding = 12;
        btn.buttonPositionStyle = BAButtonPositionStyleTop;
        [self.typeView addSubview:btn];
        
        self.typeView_width.constant = 30 + (typeArr.count)*70;
    }
}

- (void)setLikeArr:(NSArray *)likeArr{
    
    for (int i =0; i< 3; i++) {
        
        CGFloat padding = 15;
        
        BAButton *btn = [[BAButton alloc] initWithFrame:CGRectMake(15 + i*(ScreenWidth - 4*padding)/3, 0, (ScreenWidth - 4*padding)/3, self.likeView.height - 20)];
        btn.centerY = self.likeView.centerY;
        [btn setTitle:likeArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        NSString *str = [NSString stringWithFormat:@"type_icon0%d",i+1];
        [btn setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
        btn.padding = 12;
        btn.buttonPositionStyle = BAButtonPositionStyleTop;
        [self.likeView addSubview:btn];
        
        
    }
}
@end
