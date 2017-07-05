//
//  SticksCell.m
//  奢易购3.0
//
//  Created by Andy on 16/9/29.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "SticksCell.h"

@implementation SticksCell



- (void)setDic:(NSDictionary *)dic{
    
    _dic = dic;

    _nameLabel.text = _dic[@"user_name"];
    
    _phoneLabel.text = _dic[@"mobile"];
    
    if ([_dic[@"type"] isEqualToString:@"1"]) {
        _titleLabel.text = @"老板";
    }else if ([_dic[@"type"] isEqualToString:@"2"]){
        _titleLabel.text = @"店长";
    }else if ([_dic[@"type"] isEqualToString:@"3"]){
        _titleLabel.text = @"店员";
    }
    
}


@end
