//
//  PayMView.m
//  奢易购3.0
//
//  Created by guest on 16/7/22.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "PayMView.h"
#import "UIView+Controller.h"
#import "StockPriceViewController.h"



@implementation PayMView



- (void)awakeFromNib{

    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShowAction) name:@"ShowNotification" object:nil];

    _account_id = @"";
    _ZHLabel.userInteractionEnabled = NO;
    self.width = kScreenWidth-20;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    
    [DataSeviece requestUrl:get_account_typehtml params:params success:^(id result) {
        NSLog(@"%@",result[@"result"]);
        
        typeArr = result[@"result"][@"data"][@"item"];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    _moneyTextField.delegate = self;
    _moneyTextField.tag = 100;
    
    
}


- (void)setSection:(NSInteger)section{
    
    _section = section;
    _selectButton.tag = 101+section;
    
    _titleLabel.text = [NSString stringWithFormat:@"收款方式%ld:",_section+1];

}


- (void)setIsSF:(NSString *)isSF{

    _isSF = isSF;
    if ([_isSF isEqualToString:@"FK"]) {
        _titleLabel.text = [NSString stringWithFormat:@"付款方式%ld:",_section+1];

    }else{
        _titleLabel.text = [NSString stringWithFormat:@"收款方式%ld:",_section+1];

    }
    
}


- (IBAction)selectAction:(UIButton *)sender {
    
    
    [_moneyTextField resignFirstResponder];
    
    //网络加载
    
    _dataArr = [NSMutableArray array];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    
    [DataSeviece requestUrl:get_accounthtm_API params:[@{@"uid":SYGData[@"id"]} mutableCopy] success:^(id result) {
        
        NSLog(@"%@",result);
        
        
        bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        bgView.backgroundColor = [RGBColor colorWithHexString:@"#2d2d2d"];
        bgView.alpha = .4;
        [[UIApplication sharedApplication].keyWindow addSubview:bgView];
        
        
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bgButton.frame = bgView.frame;
        [bgButton addTarget:self action:@selector(bgButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:bgButton];

        
        SKFSView = [[UIView alloc]initWithFrame:CGRectMake(20, 150,kScreenWidth-40,400)];
        
        SKFSView.backgroundColor = [UIColor whiteColor];
        
        [[UIApplication sharedApplication].keyWindow addSubview:SKFSView];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-40, 70)];
        titleLabel.textColor = [RGBColor colorWithHexString:@"#787fc6"];
        titleLabel.font = [UIFont systemFontOfSize:20];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [SKFSView addSubview:titleLabel];
        
        if ([_isSF isEqualToString:@"FK"]) {
            titleLabel.text = @"付款方式";

        }else{
            titleLabel.text = @"收款方式";

        }
        
        UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(10, 50, kScreenWidth-60, 1)];
        lineV.backgroundColor = [RGBColor colorWithHexString:@"#999999"];
        [SKFSView addSubview:lineV];
        
        
        UITableView *myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 71, kScreenWidth-40, 150) style:UITableViewStylePlain];
        
        myTableView.delegate = self;
        myTableView.dataSource = self;
        
        [SKFSView addSubview:myTableView];
        
        if (_isPayment) {
            
            SKFSView.height = myTableView.bottom+10;

        }else{
        
        UIButton *KWDKButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        KWDKButton.frame = CGRectMake(30, 230, kScreenWidth/4, 40);
        
        [KWDKButton setTitle:@"货物抵款" forState:UIControlStateNormal];
        [KWDKButton setTitleColor:[RGBColor colorWithHexString:@"#787fc6"] forState:UIControlStateNormal];
        [KWDKButton addTarget:self action:@selector(KWDKAction) forControlEvents:UIControlEventTouchUpInside];
        KWDKButton.layer.borderWidth = 1;
        KWDKButton.layer.borderColor = [RGBColor colorWithHexString:@"#787fc6"].CGColor;
        
        [SKFSView addSubview:KWDKButton];
        
        UIButton *QDButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        QDButton.frame = CGRectMake(kScreenWidth/2 + 30, 230, kScreenWidth/4, 40);
        
        [QDButton setTitle:@"确定" forState:UIControlStateNormal];
        
        [QDButton addTarget:self action:@selector(QDAction) forControlEvents:UIControlEventTouchUpInside];
        QDButton.backgroundColor = [RGBColor colorWithHexString:@"#787fc6"];
        [SKFSView addSubview:QDButton];
        
        SKFSView.height = QDButton.bottom+10;
        }

        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            
            [_dataArr addObject:dic];
            
        }
        [myTableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

    
    if (sender.tag-100 == _index) {
        
//        _addBlock(sender.tag-100);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AddViewNotification" object:nil];
        _index++;
        
    }
    
}
//点击隐藏视图
- (void)bgButtonAction{

    bgView.hidden = YES;
    SKFSView.hidden = YES;
    [bgView removeFromSuperview];
    [SKFSView removeFromSuperview];
    
}

- (void)KWDKAction{

//    self.hidden = YES;
    
    bgView.hidden = YES;
    
    SKFSView.hidden = YES;
 
    [[NSNotificationCenter defaultCenter]postNotificationName:@"PushHideViewAction" object:nil];
    
    
}

- (void)QDAction{

    bgView.hidden = YES;
    SKFSView.hidden = YES;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayMViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PayMViewCell"];
     
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(80, 10, 21, 21)];
        imageV.tag = 100;
        [cell.contentView addSubview:imageV];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imageV.right+10, 10, kScreenWidth-200, 21)];
        label.tag = 101;
        label.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:label];
        
    }
    
    UIImageView *imageV = [cell.contentView viewWithTag:100];
    UILabel *label = [cell.contentView viewWithTag:101];
    
    label.text = _dataArr[indexPath.row][@"account"];
    NSInteger type = 0;
    for (NSDictionary *dic in typeArr) {
        
        if ([_dataArr[indexPath.row][@"type"] isEqualToString:dic[@"id"]]) {
            imageV.image = [UIImage imageNamed:dic[@"name"]];
            type = 1;
        }
        
    }

    if (type == 0) {
        imageV.image = nil;

    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    bgView.hidden = YES;
    SKFSView.hidden = YES;
    
    for (NSDictionary *dic in typeArr) {
        
        if ([_dataArr[indexPath.row][@"type"] isEqualToString:dic[@"id"]]) {
            _imageV.image = [UIImage imageNamed:dic[@"name"]];
        }
        
    }

    _ZHLabel.text = _dataArr[indexPath.row][@"account"];

    _account_id = _dataArr[indexPath.row][@"id"];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}


- (void)ShowAction{
    
    bgView.hidden = YES;
    
}


- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
