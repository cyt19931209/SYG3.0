//
//  ZFFSView.m
//  奢易购3.0
//
//  Created by Andy on 2016/10/19.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "ZFFSView.h"

@implementation ZFFSView





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayMViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PayMViewCell"];
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 12, 24, 24)];
        imageV.tag = 100;
        [cell.contentView addSubview:imageV];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-20, 49)];
        label.tag = 101;
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
        
    }
    
    UIImageView *imageV = [cell.contentView viewWithTag:100];
    UILabel *label = [cell.contentView viewWithTag:101];
    
    label.text = [NSString stringWithFormat:@"%@%@",_dataArr[indexPath.row][@"use_name"],_dataArr[indexPath.row][@"account"]];
    
    if ([_dataArr[indexPath.row][@"type"] isEqualToString:@"0"]) {
        imageV.image = [UIImage imageNamed:@"cashxiao@2x"];
    }else if ([_dataArr[indexPath.row][@"type"] isEqualToString:@"1"]){
        imageV.image = [UIImage imageNamed:@"zhifubaoxiao@2x"];
    }else if ([_dataArr[indexPath.row][@"type"] isEqualToString:@"2"]){
        imageV.image = [UIImage imageNamed:@"wechatxiao@2x"];
    }else if ([_dataArr[indexPath.row][@"type"] isEqualToString:@"3"]){
        imageV.image = [UIImage imageNamed:@"cardxiao@2x"];
    }else if ([_dataArr[indexPath.row][@"type"] isEqualToString:@"4"]){
        imageV.image = [UIImage imageNamed:@"posxiao@2x"];
    }
    
    return cell;
}

//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"ZFFSNotification" object:_dataArr[indexPath.row]];

}



@end
