//
//  ConsignmentContractView.m
//  奢易购3.0
//
//  Created by guest on 16/8/23.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "ConsignmentContractView.h"
#import "ConsignmentContractCell.h"


@implementation ConsignmentContractView

- (void)awakeFromNib{

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeCell:) name:@"NotiRemoveCell" object:nil];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    _dataArr = [NSMutableArray arrayWithArray:[defaults objectForKey:@"contractData1"]];

    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-20, 350) style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.backgroundColor = [UIColor clearColor];
    [self addSubview:_myTableView];

    [_myTableView registerNib:[UINib nibWithNibName:@"ConsignmentContractCell" bundle:nil] forCellReuseIdentifier:@"ConsignmentContractCell"];
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 70;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UITableViewHeaderFooterView *headerView= [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ContractHeaderView"];
    
    if (!headerView) {
        
        headerView=[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"ContractHeaderView"];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-20, 70)];
        label.textColor = [RGBColor colorWithHexString:@"#016fba"];
        label.font = [UIFont systemFontOfSize:20];
        label.tag = 100;
        label.text = @"寄卖客户1";
        label.textAlignment = NSTextAlignmentCenter;
        [headerView.contentView addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"继续添加" forState:UIControlStateNormal];
        button.frame = CGRectMake(kScreenWidth-100, 0, 70, 80);
        [button addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[RGBColor colorWithHexString:@"#6666666"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];

        [headerView.contentView addSubview:button];
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button1 setTitle:@"全部删除" forState:UIControlStateNormal];
        button1.frame = CGRectMake(10, 0, 70, 90);
        [button1 addTarget:self action:@selector(deleAction) forControlEvents:UIControlEventTouchUpInside];
        [button1 setTitleColor:[RGBColor colorWithHexString:@"#6666666"] forState:UIControlStateNormal];
        button1.titleLabel.font = [UIFont systemFontOfSize:15];
        [headerView.contentView addSubview:button1];

        
    }
    
    UILabel *label = [headerView.contentView viewWithTag:100];
    label.text = [NSString stringWithFormat:@"%@",_dataArr[0][@"name"]];
    
    return headerView;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UITableViewHeaderFooterView *footerView= [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ContractFooterView"];
    
    if (!footerView) {
        
        footerView=[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"ContractFooterView"];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 1.0/3*(kScreenWidth-20)-10, 20)];
        label1.textColor = [RGBColor colorWithHexString:@"#666666"];
        label1.font = [UIFont systemFontOfSize:12];
        label1.tag = 201;
        [footerView.contentView addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(1.0/3*(kScreenWidth-20), 0, 1.0/3*(kScreenWidth-20), 20)];
        label2.textColor = [RGBColor colorWithHexString:@"#666666"];
        label2.font = [UIFont systemFontOfSize:12];
        label2.tag = 202;
        label2.textAlignment = NSTextAlignmentCenter;
        [footerView.contentView addSubview:label2];

        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(2.0/3*(kScreenWidth-20), 0, 1.0/3*(kScreenWidth-20)-10, 20)];
        label3.textColor = [RGBColor colorWithHexString:@"#666666"];
        label3.font = [UIFont systemFontOfSize:12];
        label3.tag = 203;
        label3.textAlignment = NSTextAlignmentRight;
        [footerView.contentView addSubview:label3];

    }
    
    UILabel *label1 = [footerView.contentView viewWithTag:201];
    UILabel *label2 = [footerView.contentView viewWithTag:202];
    UILabel *label3 = [footerView.contentView viewWithTag:203];

    label1.text = [NSString stringWithFormat:@"客户姓名:%@",_dataArr[0][@"name"]];
    
    NSInteger num = 0;
    for (NSDictionary *dic in _dataArr) {
        
        num = num + [dic[@"number"] integerValue];
    }
    
    label2.text = [NSString stringWithFormat:@"送交%ld件商品寄卖",num];
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    label3.text = [NSString stringWithFormat:@"日期:%@",dateString];

    return footerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    
    if (_dataArr.count != 0) {
        return 1;
    }

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ConsignmentContractCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConsignmentContractCell" forIndexPath:indexPath];
    cell.index = indexPath.row;
    cell.dic = _dataArr[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NotiPushCell" object:[NSString stringWithFormat:@"%ld",indexPath.row]];
    
}

- (IBAction)tureAction:(id)sender {
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"寄卖单已经发送到你的电子邮箱与PC客户端" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];

    NSArray *arr = [defaults objectForKey:@"contractData1"];

    for (int i = 0; i < arr.count; i++) {
        
            NSDictionary *params = arr[i];
            
            [DataSeviece requestUrl:add_goodshtml params:[params mutableCopy] success:^(id result) {
                NSLog(@"%@ %@",result[@"result"],result[@"result"][@"msg"]);
                
                if ([result[@"result"][@"code"] isEqualToString:@"1"]) {

                    if (i == 0) {
                        
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"ContractNotification" object:nil];
                        [defaults removeObjectForKey:@"contractData1"];
                        [alertV show];

                    }
                    
                }else{
                    
                    alertV.title = @"提示";
                    alertV.message = result[@"result"][@"msg"];
                    [alertV show];
                    [defaults removeObjectForKey:@"contractData1"];

                }
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];
    }


}
//继续添加
- (void)addAction{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"AddContractNotification" object:nil];

}
//全部删除
- (void)deleAction{
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否全部删除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alertV show];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 0) {
        
        
    }else if (buttonIndex == 1){
    
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults removeObjectForKey:@"contractData1"];
        
        [defaults synchronize];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RemoveAllCell" object:nil];

    
    }

}


- (void)removeCell:(NSNotification*)noti{
    
    int index = [[noti object] intValue];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    _dataArr = [NSMutableArray arrayWithArray:[defaults objectForKey:@"contractData1"]];

    NSLog(@"%d %@",index,_dataArr);
    
    
    if (_dataArr.count != 0) {
        
        if (_dataArr.count -1 >= index) {
         
            if (_dataArr[index]) {
                NSDictionary *dic = _dataArr[index];
                
                [_dataArr removeObject:dic];
                
                [defaults setObject:_dataArr forKey:@"contractData1"];
                
            }

        }
    }
    [_myTableView removeFromSuperview];
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-20, 350) style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.backgroundColor = [UIColor clearColor];
    [self addSubview:_myTableView];
    
    [_myTableView registerNib:[UINib nibWithNibName:@"ConsignmentContractCell" bundle:nil] forCellReuseIdentifier:@"ConsignmentContractCell"];

    if (_dataArr.count == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RemoveAllCell" object:nil];
    }
    
}

@end
