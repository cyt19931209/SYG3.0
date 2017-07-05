//
//  SupplierView.m
//  奢易购3.0
//
//  Created by guest on 16/8/3.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "SupplierView.h"
#import "MJRefresh.h"



@implementation SupplierView


- (void)awakeFromNib{
    
//    _dataArr = [NSMutableArray array];
    
    
    myTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 123, kScreenWidth-20, 200) style:UITableViewStylePlain];
    myTableview.delegate = self;
    myTableview.dataSource = self;
    myTableview.backgroundColor = [UIColor whiteColor];
    [self addSubview:myTableview];
    myTableview.tableFooterView = [[UIView alloc]init];
    
    page = 0;
    _KHId = @"";
    //上拉加载
    
    myTableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        page++;
        
        [self loadData];
        
    }];

    _phoneTextField.delegate = self;
    _nameTextField.delegate = self;
    
    [_nameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_phoneTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    _dataArr = [NSMutableArray arrayWithArray:[defaults objectForKey:SYGData[@"id"]]];
    isType = NO;
    [myTableview reloadData];

}

- (void)textFieldDidChange:(NSNotification*)Notification{
    
    
    isType = NO;
    _idStr = @"";
    page = 1;
    [self loadData];

}

- (void)loadData{

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:_nameTextField.text forKey:@"name"];
    
    [params setObject:_phoneTextField.text forKey:@"mobile"];
    
    [params setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
    
    if (page == 1) {
        [_dataArr removeAllObjects];
    }
    
    [DataSeviece requestUrl:get_customerhtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
//        _dataArr = result[@"result"][@"data"][@"item"];
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            [_dataArr addObject:[NULLHandle NUllHandle:dic]];
        }
        
        NSLog(@"%ld",_dataArr.count);
        [myTableview reloadData];
        
        if (_dataArr.count == 0) {
            _idStr = @"";
        }
        
        [myTableview.footer endRefreshing];
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [myTableview.footer endRefreshing];

        
    }];


}


- (void)setTitle:(NSString *)title{
    
    _title = title;
    
    _titleLabel.text = _title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (isType) {
        return 0;
    }
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SupplierViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SupplierViewCell"];
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, kScreenWidth/2-10-20, 20)];
        label1.tag = 100;
        label1.textColor = [RGBColor colorWithHexString:@"#666666"];
        label1.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-10, 12, kScreenWidth/2-10-20, 20)];
        label2.tag = 101;
        label2.textColor = [RGBColor colorWithHexString:@"#666666"];
        label2.font = [UIFont systemFontOfSize:16];
        label2.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:label2];
        
    }
    
    UILabel *label1 = [cell.contentView viewWithTag:100];
    UILabel *label2 = [cell.contentView viewWithTag:101];
    NSDictionary *dic = [NULLHandle NUllHandle:_dataArr[indexPath.row]];
    label1.text = dic[@"name"];
    label2.text = dic[@"mobile"];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    NSDictionary *dic = [NULLHandle NUllHandle:_dataArr[indexPath.row]];

    if ([dic[@"id"] isEqualToString:_KHId]) {
        
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"选择客户不能和出售客户相同" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        
    }else{
    
    _phoneTextField.text = dic[@"mobile"];
    
    _nameTextField.text = dic[@"name"];
    
    _idStr = dic[@"id"];
    oldDic = dic;
    isType = YES;
    [myTableview reloadData];
    [_phoneTextField resignFirstResponder];
    [_nameTextField resignFirstResponder];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    NSMutableArray *oldArr = [NSMutableArray arrayWithArray:[defaults objectForKey:SYGData[@"id"]]];
    
    if (oldArr == nil) {
        oldArr = [NSMutableArray array];
    }
    int index = 6;
    for (int i = 0; i < oldArr.count; i++) {
        NSDictionary *dic1 = oldArr[i];
        if ([dic1[@"id"] isEqualToString:dic[@"id"]]) {
            index = i;
        }
    }
    NSLog(@"%@",oldArr);
            NSLog(@"%d",index);
    
    if (index != 6) {
        [oldArr removeObjectAtIndex:index];
        
    }
    if (oldArr.count == 5) {
        [oldArr removeObjectAtIndex:4];
    }
    [oldArr insertObject:dic atIndex:0];
    [defaults setObject:[oldArr mutableCopy] forKey:SYGData[@"id"]];
    [defaults synchronize];
        
    }
}

//取消
- (IBAction)cancelAction:(id)sender {
    
    [_phoneTextField resignFirstResponder];
    [_nameTextField resignFirstResponder];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SupplierCancelNotification" object:nil];
    
}

//确定
- (IBAction)turnAction:(id)sender {
    
    [_phoneTextField resignFirstResponder];
    [_nameTextField resignFirstResponder];
    
    if (_idStr == nil||[_idStr isEqualToString:@""]) {
       
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        [params setObject:SYGData[@"id"] forKey:@"uid"];

        [params setObject:_nameTextField.text forKey:@"name"];
        
        [params setObject:_phoneTextField.text forKey:@"mobile"];
        
        NSString *url = @"";

        if ([_nameTextField.text isEqualToString:oldDic[@"name"]]||[_phoneTextField.text isEqualToString:oldDic[@"mobile"]]) {
            url = edit_customerhtml;
            [params setObject:oldDic[@"id"] forKey:@"id"];
        }else{
            url = add_customerhtml;
        }
        [DataSeviece requestUrl:url params:params success:^(id result) {
            
            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                if ([_nameTextField.text isEqualToString:oldDic[@"name"]]||[_phoneTextField.text isEqualToString:oldDic[@"mobile"]]) {
                    
                    NSDictionary *dic = @{@"phone":_phoneTextField.text,@"name":_nameTextField.text,@"id":oldDic[@"id"]};
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"SupplierTureNotification" object:dic];
  
                }else{
                _idStr = result[@"result"][@"data"][@"id"];
                NSDictionary *dic = @{@"phone":_phoneTextField.text,@"name":_nameTextField.text,@"id":_idStr};
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SupplierTureNotification" object:dic];
                }
            }else{
            
                UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:result[@"result"][@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertV show];
            }
            
            
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
            
        }];
    }else{
    
    NSDictionary *dic = @{@"phone":_phoneTextField.text,@"name":_nameTextField.text,@"id":_idStr};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SupplierTureNotification" object:dic];
    }

}
@end
