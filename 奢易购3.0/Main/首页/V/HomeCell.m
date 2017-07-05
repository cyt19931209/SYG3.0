//
//  HomeCell.m
//  奢易购3.0
//
//  Created by guest on 16/7/20.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell



- (void)setModel:(HomeModel *)model{
    _model = model;
    
    for (NSDictionary *dic in _arr) {
        if ([dic[@"id"] isEqualToString:model.category_id]) {
            
            _imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",dic[@"category_name"]]];
        }
    }
    
    if (!_imageV.image) {
        _imageV.image = [UIImage imageNamed:@"其他"];
    }

    _SPMLabel.text = [NSString stringWithFormat:@"%@  x%@",_model.goods_name,_model.quantity];
    
    _moneyLabel.text = [NSString stringWithFormat:@"¥%@",_model.unpay];
    
    if (_homeType == 1) {
        _typeLabel.text = @"待收款";
        
        if ([_model.customer_name isEqualToString:@"默认客户"]) {
            _nameLabel.text = @"收款";

        }else{
        
        _nameLabel.text = [NSString stringWithFormat:@"向%@收款", _model.customer_name];
        }

    }else if (_homeType == 2){
        _typeLabel.text = @"待付款";
        
        _nameLabel.text = [NSString stringWithFormat:@"向%@付款", _model.customer_name];

    }else if (_homeType == 3){
        _typeLabel.text = @"待付款";
        _nameLabel.text = [NSString stringWithFormat:@"向%@结款", _model.customer_name];

    }
}

@end
