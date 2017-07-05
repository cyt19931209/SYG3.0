//
//  BooksTableViewCell.m
//  奢易购3.0
//
//  Created by guest on 16/7/21.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "BooksTableViewCell.h"

@implementation BooksTableViewCell


- (void)setDic:(NSDictionary *)dic{
    _dic = dic;

    _nameLabel.text = _dic[@"goods_name"];
    
    if ([_dic[@"type"] isEqualToString:@"1"]) {
        _moneyLabel.text = [NSString stringWithFormat:@"支出:%ld",[_dic[@"amount"] integerValue]];
    }else{
        _moneyLabel.text = [NSString stringWithFormat:@"收入:%ld",[_dic[@"amount"] integerValue]];
    }
    if ([_dic[@"is_read"] isEqualToString:@"1"]) {
        _imageV.image = nil;
    }else{
    
        _imageV.image = [UIImage imageNamed:@"new.png"];
    }
    
}


@end
