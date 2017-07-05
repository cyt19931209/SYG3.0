//
//  StockCell.m
//  奢易购3.0
//
//  Created by guest on 16/7/20.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "StockCell.h"

@implementation StockCell


- (void)setModel:(StockModel *)model{
    _model = model;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    [params setObject:@"1" forKey:@"classify"];
    
    for (NSDictionary *dic in _arr) {
        if ([dic[@"id"] isEqualToString:_model.category_id]) {
            
            if ([dic[@"category_name"] isEqualToString:@"其他"]) {
                _categoryImageV.image = [UIImage imageNamed:@"其他（36x42）1"];

            }else{
                _categoryImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@（36x42）",dic[@"category_name"]]];
            }
        }
    }

   if (!_categoryImageV.image) {
       _categoryImageV.image = [UIImage imageNamed:@"其他（36x42）1"];
    }

    
    _nameLabel.text = [NSString stringWithFormat:@"%@  x%@",_model.goods_name,_model.number];
    
    
    if ([_model.type isEqualToString:@"JM"]) {
        _typeImageV.image = [UIImage imageNamed:@"寄卖1"];
        _moneyLabel.text = [NSString stringWithFormat:@"客户到手价:%ld",[model.customer_price integerValue]];
        
    }else{
        _typeImageV.image = [UIImage imageNamed:@"回收1"];
        _moneyLabel.text = [NSString stringWithFormat:@"标价:%ld",[model.price integerValue]];

    }
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    
    float addtime = [_model.add_time floatValue];
    
    if (interval - addtime >24*60*60) {
        _NewImageV.hidden = YES;
    }else{
        _NewImageV.hidden = NO;
    }

}

@end
