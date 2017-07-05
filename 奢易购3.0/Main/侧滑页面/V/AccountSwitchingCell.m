//
//  AccountSwitchingCell.m
//  奢易购3.0
//
//  Created by Andy on 2016/10/12.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "AccountSwitchingCell.h"

@implementation AccountSwitchingCell


- (void)setDic:(NSDictionary *)dic{

    _dic = dic;

    if ([_dic[@"type"] isEqualToString:@"3"]) {
        _imageV.image = [UIImage imageNamed:@"dy@2x"];
    }else if ([_dic[@"type"] isEqualToString:@"2"]){
        _imageV.image = [UIImage imageNamed:@"dz@2x"];
    }else if ([_dic[@"type"] isEqualToString:@"1"]){
        _imageV.image = [UIImage imageNamed:@"gl@2x"];
    }
    
    _nameLabel.text = _dic[@"user_name"];
    
    _phoneLabel.text = _dic[@"mobile"];

}


@end
