//
//  SearchTypeCell.m
//  奢易购3.0
//
//  Created by guest on 16/8/16.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "SearchTypeCell.h"

@implementation SearchTypeCell


- (void)setModel:(SearchTypeModel *)model{

    _model = model;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    

    if ([_type isEqualToString:@"1"]) {
        
        _nameLabel.text = _model.customer_name;
        _SPMLabel.text = _model.goods_name;
        


        _timeLabel.text = _model.add_time;
        
        _imageV2.image = [UIImage imageNamed:@""];

        if ([[defaults objectForKey:[NSString stringWithFormat:@"%@switch",SYGData[@"id"]]] isEqualToString:@"1"]) {
            
            _moneyLabel.text = [NSString stringWithFormat:@"客户到手价:%ld",(long)[_model.customer_price integerValue]];
            
        }else{
            
            _moneyLabel.text = @"客户到手价:***";
        }

        
    }else if ([_type isEqualToString:@"2"]){

        _nameLabel.text = _model.operation_user;
        _SPMLabel.text = _model.remark;
        if ([_model.type isEqualToString:@"1"]) {
            if ([[defaults objectForKey:[NSString stringWithFormat:@"%@switch",SYGData[@"id"]]] isEqualToString:@"1"]) {
                
                _moneyLabel.text = [NSString stringWithFormat:@"支出:%ld",(long)[_model.amount integerValue]];
                
            }else{
                
                _moneyLabel.text = @"支出:***";
            }

        }else{
            
            if ([[defaults objectForKey:[NSString stringWithFormat:@"%@switch",SYGData[@"id"]]] isEqualToString:@"1"]) {
                
                _moneyLabel.text = [NSString stringWithFormat:@"收入:%ld",(long)[_model.amount integerValue]];
                
            }else{
                
                _moneyLabel.text = @"收入:***";
            }
        }
        _timeLabel.text = _model.add_time;
        _imageV2.image = [UIImage imageNamed:@""];

    }else if ([_type isEqualToString:@"3"]){
        _timeLabel.text = @"";
        _SPMLabel.text = _model.goods_name;
        _nameLabel.text = _model.customer_name;
        if ([_model.type isEqualToString:@"HS"]) {
            _imageV2.image = [UIImage imageNamed:@"回收2"];
            if ([[defaults objectForKey:[NSString stringWithFormat:@"%@switch",SYGData[@"id"]]] isEqualToString:@"1"]) {
                
                _moneyLabel.text = [NSString stringWithFormat:@"进货价:%ld",(long)[_model.cost integerValue]];
                
            }else{
                
                _moneyLabel.text = @"进货价:***";
            }

        }else if ([_model.type isEqualToString:@"JM"]){
            _imageV2.image = [UIImage imageNamed:@"寄卖2"];
            if ([[defaults objectForKey:[NSString stringWithFormat:@"%@switch",SYGData[@"id"]]] isEqualToString:@"1"]) {
                
                _moneyLabel.text = [NSString stringWithFormat:@"客户到手价:%ld",(long)[_model.cost integerValue]];
                
            }else{
                
                _moneyLabel.text = @"客户到手价:***";
            }
        }
    }else if ([_type isEqualToString:@"4"]){
       
        _nameLabel.text = _model.customer_name;
        _SPMLabel.text = _model.goods_name;
        if ([[defaults objectForKey:[NSString stringWithFormat:@"%@switch",SYGData[@"id"]]] isEqualToString:@"1"]) {
            
            _timeLabel.text = [NSString stringWithFormat:@"利润:%ld",(long)[_model.total_profit integerValue]];
            _moneyLabel.text = [NSString stringWithFormat:@"卖价:%ld",(long)[_model.total_price integerValue]];

        }else{
            _timeLabel.text = @"利润:***";

            _moneyLabel.text = @"卖价:***";
        }

        
        if ([_model.is_pause isEqualToString:@"1"]) {
            _imageV2.image = [UIImage imageNamed:@"挂单中.jpg"];
        }else{
            _imageV2.image = [UIImage imageNamed:@""];

        }
        
    }
    
    
}


@end
