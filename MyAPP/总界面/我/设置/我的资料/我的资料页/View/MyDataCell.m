//
//  MyDataCell.m
//  BeautyApp
//
//  Created by zhangming on 17/2/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "MyDataCell.h"

@implementation MyDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.setLa.font = [UIFont fontWithName:@"迷你简启体" size:17.0];
    //self.titleLa.font = [UIFont fontWithName:@"迷你简启体" size:17.0];
}


+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    
    NSString *identity = @"";
    NSInteger index = 0;
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    identity = @"CELL1";
                    index = 0;
                    break;
                default:
                    identity = @"CELL2";
                    index = 1;
                    break;
            }
            break;
            
        default:
            identity = @"CELL2";
            index = 1;
            break;
    }
    
    MyDataCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyDataCell" owner:identity options:nil] objectAtIndex:index];
    }
    return cell;
}

#pragma mark - 生成cell
+ (instancetype)cell:(NSIndexPath *)indexPath{
    
    NSString *className = NSStringFromClass([self class]);
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            return [[NSBundle mainBundle] loadNibNamed:className owner:self options:nil][0];
        }else{
            
            return [[NSBundle mainBundle] loadNibNamed:className owner:self options:nil][1];
        }

    }else{
        
        return [[NSBundle mainBundle] loadNibNamed:className owner:self options:nil][1];
    }
    
}

#pragma mark - 高度
+ (CGFloat)Height:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self cell:indexPath];
    
    return cell.frame.size.height;
}


- (void)reciveInfoWithTitleArr:(NSArray *)titlesArr andTitlesArr2:(NSArray *)titlesArr2 andTitlesArr3:(NSArray *)titlesArr3 andTitlesArr4:(NSArray *)titlesArr4 andIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            
            switch (indexPath.row) {
                case 0:
                    self.headLa.text = titlesArr[indexPath.row];
                    self.headIm.image = [UIImage imageWithData:titlesArr3[indexPath.row]];
                    break;
                case 4:
                    self.titleLa.text = titlesArr[indexPath.row];
                    self.setLa.text = @"";
                    break;
                default:
                    self.titleLa.text = titlesArr[indexPath.row];
                    if ([titlesArr3[indexPath.row] length]>0) {
                        
                        self.setLa.text = titlesArr3[indexPath.row];
                    }else{
                        
                        self.setLa.text = @"未设置";
                    }
                    
                    break;
            }
            
            break;
            
        default:
            self.titleLa.text = titlesArr2[indexPath.row];
            
            if ([titlesArr4[indexPath.row] length] > 0) {
                
                self.setLa.text = titlesArr4[indexPath.row];
            }else{
                
                self.setLa.text = @"未设置";
            }
            
            break;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
