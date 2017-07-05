//
//  StockPriceCell.m
//  奢易购3.0
//
//  Created by guest on 16/8/29.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "StockPriceCell.h"

@implementation StockPriceCell

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
                _categoryImageV.image = [UIImage imageNamed:@"其他"];
                
            }else{
                _categoryImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",dic[@"category_name"]]];
            }
        }
    }
    
    if (!_categoryImageV.image) {
        _categoryImageV.image = [UIImage imageNamed:@"其他"];
    }
    
    
    _nameLabel.text = [NSString stringWithFormat:@"%@  x%@",_model.goods_name,_model.number];
    
    
    if ([_model.type isEqualToString:@"JM"]) {
        _typeImageV.image = [UIImage imageNamed:@"寄卖2"];
        _moneyLabel.text = [NSString stringWithFormat:@"客户到手价:%@",model.cost];
        
    }else{
        _typeImageV.image = [UIImage imageNamed:@"回收2"];
        _moneyLabel.text = [NSString stringWithFormat:@"进价:%@",model.cost];
        
    }

}

@end
