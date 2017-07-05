//
//  ConsignmentCell.m
//  奢易购3.0
//
//  Created by guest on 16/7/25.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "ConsignmentCell.h"

@implementation ConsignmentCell


- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    
    NSDictionary *dic2 = [NULLHandle NUllHandle:_dic];
    
    _SPMLabel.text = dic2[@"goods_name"];
    _KHMLabel.text = dic2[@"custemor_name"] ;
    _KHDSJLabel.text = [NSString stringWithFormat:@"客户到手价:%ld",[dic2[@"customer_price"] integerValue]];
    _numLabel.text = [NSString stringWithFormat:@"x%@",dic2[@"number"]];
    
    for (NSDictionary *dic in _arr) {
        if ([dic[@"id"] isEqualToString:dic2[@"category_id"]]) {
            
            if ([dic[@"category_name"] isEqualToString:@"其他"]) {
                _imageV1.image = [UIImage imageNamed:@"其他（36x42）1"];
                
            }else{
                _imageV1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@（36x42）",dic[@"category_name"]]];
            }
        }
    }
    
    if (!_imageV1.image) {
        _imageV1.image = [UIImage imageNamed:@"其他（36x42）1"];
    }
    
    if ([dic2[@"status"] isEqualToString:@"1"]) {
        _imageV3.image = [UIImage imageNamed:@"寄卖中.jpg"];
    }else if ([dic2[@"status"] isEqualToString:@"2"]){
        _imageV3.image = [UIImage imageNamed:@"待结算.png"];

    }else if ([dic2[@"status"] isEqualToString:@"3"]){
        _imageV3.image = [UIImage imageNamed:@"已完成.jpg"];

    }else if ([dic2[@"status"] isEqualToString:@"4"]){
        _imageV3.image = [UIImage imageNamed:@"已取回.png"];

    }

    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY年MM月dd日"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    if ([dateString isEqualToString:_dataTime]) {
        _imageV2.image = [UIImage imageNamed:@"new"];
    }else{
        _imageV2.image = [UIImage imageNamed:@""];

    }

}

@end
