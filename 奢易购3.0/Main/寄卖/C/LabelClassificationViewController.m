//
//  LabelClassificationViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/10/11.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "LabelClassificationViewController.h"

@interface LabelClassificationViewController ()<UITableViewDataSource,UITableViewDelegate>{

    BOOL flag[100];

    
    NSArray *colorArr;
}


@property (nonatomic,strong) UIButton *selectButton;

@property (nonatomic,strong) UITableView *myTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) NSMutableArray *selectArr;


@end

@implementation LabelClassificationViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    _dataArr = [NSMutableArray array];
    _selectArr = [NSMutableArray array];
    self.navigationItem.title = @"标签分类";
    
    
    colorArr = @[@"#404CCF",@"#2B2D46",@"#595E93",@"#8087D6",@"#5665FF",@"#B8BDF0",@"#1A26A2",@"#989DCB",@"#0918B2",@"#A2AAFF"];
    
    //改变导航栏标题的字体颜色和大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏背景.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"返回（20x38）.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    //右边Item
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 35, 30);
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self.view addSubview:_myTableView];
    
    //加载数据
    [self loadData];
}


//加载数据
- (void)loadData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    [params setObject:_category_id forKey:@"category_id"];
    
    [DataSeviece requestUrl:get_category_attributehtml params:params success:^(id result) {
        
        
        NSLog(@"%@",result);
        NSLog(@"%@",result[@"result"][@"msg"]);
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            
            if ([dic[@"type"] isEqualToString:@"group"]) {
                
                [_dataArr addObject:dic];

                NSMutableArray *arr = [NSMutableArray array];

                for (NSDictionary *dic1 in dic[@"childen"]) {

                    for (NSDictionary *dic2 in _oldArr) {
                        
                        for (NSDictionary *dic3 in dic1[@"selectitem"]) {
                            
                            if ([dic3[@"id"] isEqualToString:dic2[@"id"]]) {
                                
                                [arr addObject:dic3];
                                
                            }
                        }
                    }
                }
                [_selectArr addObject:arr];

            }
            
            if ([dic[@"type"] isEqualToString:@"select"]) {
                [_dataArr addObject:dic];
                
                NSMutableArray *arr = [NSMutableArray array];
                
                for (NSDictionary *dic1 in _oldArr) {

                    for (NSDictionary *dic2 in dic[@"selectitem"]) {
                        
                        if ([dic1[@"id"] isEqualToString:dic2[@"id"]]) {
                            
                            [arr addObject:dic2];
                        }
                    }
                }
                [_selectArr addObject:arr];
            }
        }
        
        
        if (_dataArr.count == 0) {
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 128)/2, 80, 128, 128)];
            imageV.image = [UIImage imageNamed:@"bq@2x"];
            
            [self.view addSubview:imageV];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, imageV.bottom+10, kScreenWidth, 20)];
            
            label.text = @"请登录PC网页版奢易购添加分类标签";
            
            label.textColor = [RGBColor colorWithHexString:@"#666666"];
            
            label.font = [UIFont systemFontOfSize:16];
            label.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:label];
        }
        
        [_myTableView reloadData];
        NSLog(@"%@",_dataArr);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LabelClassification"];
    

    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.contentView.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    NSDictionary *dic = _dataArr[indexPath.section];

    if ([dic[@"type"] isEqualToString:@"group"]) {

        if (flag[indexPath.section]) {

            CGFloat left = 20;
            CGFloat top = 10;
            
            NSArray *childenArr = dic[@"childen"];
            
            for (int j = 0; j < childenArr.count; j++) {
            
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, top, 100, 20)];
                label.text = childenArr[j][@"attribute_name"];
                label.font = [UIFont systemFontOfSize:16];
                label.textColor = [RGBColor colorWithHexString:@"#666666"];
                [cell.contentView addSubview:label];
                NSArray *labelArr = childenArr[j][@"selectitem"];
                
                top = top +30;
                
                for (int i = 0; i < labelArr.count; i++) {
                    
                    CGRect rect = [labelArr[i][@"attribute_name"] boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
                    
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                    
                    if (left + rect.size.width > kScreenWidth - 40) {
                        top = top +30;
                        left = 20;
                    }
                    button.frame = CGRectMake(left, top, rect.size.width+10, 20);
                    [button setTitle:labelArr[i][@"attribute_name"] forState:UIControlStateNormal];
                    button.titleLabel.font = [UIFont systemFontOfSize:15];
                    
                    NSInteger a = indexPath.section%10;
                    
                    button.backgroundColor = [RGBColor colorWithHexString:colorArr[a]];
                    
                    button.layer.cornerRadius = 3;
                    button.layer.masksToBounds = YES;
                    button.tag = indexPath.section *100 + 10*j + i;
                    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:button];
                    left = left + rect.size.width + 20;
                    
                    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(button.right - 6, button.top - 6, 13, 13)];
                    imageV.image = [UIImage imageNamed:@"choise@2x"];
                    imageV.tag = button.tag + 1000;
                    imageV.hidden = YES;
                    [cell.contentView addSubview:imageV];
                    
                    for (NSDictionary *dic in _selectArr[indexPath.section]) {
                        
                        if ([dic[@"id"] isEqualToString:labelArr[i][@"id"] ]) {
                            button.selected = YES;
                            imageV.hidden = NO;
                        }
                       }
                    
                    if (i == labelArr.count - 1) {
                        
                        top = top+30;
                        left = 20;
                    }
                    }
            }
        }else{
        
            NSArray *labelArr = _selectArr[indexPath.section];
            CGFloat left = 20;
            CGFloat top = 10;
            for (int i = 0; i < labelArr.count; i++) {
                
                CGRect rect = [labelArr[i][@"attribute_name"] boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                
                if (left + rect.size.width > kScreenWidth - 40) {
                    top = top +30;
                    left = 20;
                }
                
                button.frame = CGRectMake(left, top, rect.size.width+10, 20);
                [button setTitle:labelArr[i][@"attribute_name"] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:15];
                
                NSInteger a = indexPath.section%10;
                
                button.backgroundColor = [RGBColor colorWithHexString:colorArr[a]];
                
                button.layer.cornerRadius = 3;
                button.layer.masksToBounds = YES;
                button.tag = indexPath.section * 100 + i + 5000;
                [button addTarget:self action:@selector(buttonAction1:) forControlEvents:UIControlEventTouchUpInside];
                button.selected = YES;
                [cell.contentView addSubview:button];
                left = left + rect.size.width + 20;
                
                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(button.right - 6, button.top - 6, 13, 13)];
                imageV.image = [UIImage imageNamed:@"choise@2x"];
                imageV.tag = button.tag + 1000;
                [cell.contentView addSubview:imageV];

            }
        }
        
        
    }else{

    
    if (flag[indexPath.section]) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 100, 20)];
        label.text = @"细分标签1:";
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [RGBColor colorWithHexString:@"#666666"];
        [cell.contentView addSubview:label];
        
        NSArray *labelArr = _dataArr[indexPath.section][@"selectitem"];
        CGFloat left = 20;
        CGFloat top = 40;
        
        for (int i = 0; i < labelArr.count; i++) {
        
            CGRect rect = [labelArr[i][@"attribute_name"] boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if (left + rect.size.width > kScreenWidth - 40) {
                top = top +30;
                left = 20;
            }
            button.frame = CGRectMake(left, top, rect.size.width+10, 20);
            [button setTitle:labelArr[i][@"attribute_name"] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            NSInteger a = indexPath.section%10;
            
            button.backgroundColor = [RGBColor colorWithHexString:colorArr[a]];
            
            button.layer.cornerRadius = 3;
            button.layer.masksToBounds = YES;
            button.tag = indexPath.section *100 + i;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:button];
            left = left + rect.size.width + 20;
            
            
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(button.right - 6, button.top - 6, 13, 13)];
            imageV.image = [UIImage imageNamed:@"choise@2x"];
            imageV.tag = button.tag + 1000;
            imageV.hidden = YES;
            [cell.contentView addSubview:imageV];
            
            for (NSDictionary *dic in _selectArr[indexPath.section]) {
                
                if ([dic[@"id"] isEqualToString:labelArr[i][@"id"] ]) {
                    
                    button.selected = YES;
                    imageV.hidden = NO;
                }
                
            }
        }
    }else{
    
        NSArray *labelArr = _selectArr[indexPath.section];
        CGFloat left = 20;
        CGFloat top = 10;
        for (int i = 0; i < labelArr.count; i++) {
            
            CGRect rect = [labelArr[i][@"attribute_name"] boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if (left + rect.size.width > kScreenWidth - 40) {
                top = top +30;
                left = 20;
            }
            
            button.frame = CGRectMake(left, top, rect.size.width+10, 20);
            [button setTitle:labelArr[i][@"attribute_name"] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15];

            NSInteger a = indexPath.section%10;
            
            button.backgroundColor = [RGBColor colorWithHexString:colorArr[a]];
            button.layer.cornerRadius = 3;
            button.layer.masksToBounds = YES;
            button.tag = indexPath.section * 100 + i + 5000;;
            [button addTarget:self action:@selector(buttonAction1:) forControlEvents:UIControlEventTouchUpInside];
            button.selected = YES;
            [cell.contentView addSubview:button];
            
            left = left + rect.size.width + 20;
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(button.right - 6, button.top - 6, 13, 13)];
            imageV.image = [UIImage imageNamed:@"choise@2x"];
            imageV.tag = button.tag + 1000;
            [cell.contentView addSubview:imageV];
            
        }
    }
    }
    return cell;
    
}

//点击button
- (void)buttonAction:(UIButton*)bt{

    bt.selected = !bt.selected;
    
    NSInteger section = bt.tag/100;
    
    NSInteger row = bt.tag%100;
    
    NSInteger index = bt.tag%10;
    
    NSInteger row1 = row/10;
    
    UIImageView *imageV = [self.view viewWithTag:bt.tag +1000];
    
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:_selectArr[section]];

    NSDictionary *dic = _dataArr[section];

//    NSLog(@"%ld %ld %ld %ld %@",section,row,index,row1,dic);

    
    if (bt.selected) {
        
        imageV.hidden = NO;
        
        
        if ([dic[@"type"] isEqualToString:@"group"]) {
            
            
            [arr addObject:dic[@"childen"][row1][@"selectitem"][index]];
            
        }else{
            
            [arr addObject:_dataArr[section][@"selectitem"][row]];
        }
        
        [_selectArr replaceObjectAtIndex:section withObject:arr];
        
        
    }else{
        
        
        imageV.hidden = YES;
        
        if ([dic[@"type"] isEqualToString:@"group"]) {
            
                NSLog(@"%ld %ld %@ %@",row1,index,arr,dic[@"childen"][row1][@"selectitem"][index]);
                
                [arr removeObject:dic[@"childen"][row1][@"selectitem"][index]];

            
        }else{
            
                NSLog(@"%ld %ld %@ %@",section,row,arr,_dataArr);
                
                [arr removeObject:_dataArr[section][@"selectitem"][row]];
        
            
            
        }
        
        [_selectArr replaceObjectAtIndex:section withObject:arr];
        

    }
    
//    [_myTableView reloadData];

    
    //        刷新方法
    NSIndexSet *indexSet=[NSIndexSet indexSetWithIndex:section];
    
    [_myTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    

}


- (void)buttonAction1:(UIButton*)bt{


    NSInteger section = (bt.tag - 5000)/100;
    
    NSInteger row = bt.tag%100;
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:_selectArr[section]];

    [arr removeObjectAtIndex:row];

    [_selectArr replaceObjectAtIndex:section withObject:arr];

    //        刷新方法
    NSIndexSet *indexSet=[NSIndexSet indexSetWithIndex:section];
    
    [_myTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    
    

}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{


    UITableViewHeaderFooterView *headerView= [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LabelClassificationHeaderView"];
    
    if (!headerView) {
        
        headerView=[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"LabelClassificationHeaderView"];
        
        headerView.contentView.backgroundColor = [UIColor whiteColor];
        UIButton *salesButton = [UIButton buttonWithType:UIButtonTypeCustom];
        salesButton.frame = CGRectMake(0, 0, kScreenWidth, 82);
        [salesButton addTarget:self action:@selector(salesButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [headerView.contentView addSubview:salesButton];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 150, 44)];
        label1.textColor = [RGBColor colorWithHexString:@"#666666"];
        label1.font = [UIFont systemFontOfSize:16];
        label1.tag = 1102;
        [headerView.contentView addSubview:label1];
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-24, 18, 14, 8)];
        imageV.tag = 1105;
        [headerView.contentView addSubview:imageV];
        
        UIView *bgV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        bgV.backgroundColor = [RGBColor colorWithHexString:@"#d9d9d9"];
        [headerView.contentView addSubview:bgV];
        
    }
    
    
    UILabel *label1 = [headerView.contentView viewWithTag:1102];
    
    UIImageView *imageV = [headerView.contentView viewWithTag:1105];
    
    label1.text = _dataArr[section][@"attribute_name"];
    
    if (flag[section]) {
        imageV.image = [UIImage imageNamed:@"下拉展开后箭头.png"];
        
    }else{
        imageV.image = [UIImage imageNamed:@"下拉箭头.png"];
    }
    
    headerView.tag = 1110+section;
    return headerView;


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    NSDictionary *dic = _dataArr[indexPath.section];
    
    
    if ([dic[@"type"] isEqualToString:@"group"]) {
        
        if (flag[indexPath.section]) {
            
            CGFloat left = 20;
            CGFloat top = 10;
            
            NSArray *childenArr = dic[@"childen"];
            
            for (int j = 0; j < childenArr.count; j++) {
                
                
                NSArray *labelArr = childenArr[j][@"selectitem"];
                
                top = top +30;
                
                for (int i = 0; i < labelArr.count; i++) {
                    
                    CGRect rect = [labelArr[i][@"attribute_name"] boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
                    
                    
                    if (left + rect.size.width > kScreenWidth - 40) {
                        top = top +30;
                        left = 20;
                    }
                    
                    
                    if (i == labelArr.count - 1) {
                        
                        top = top+30;
                        left = 10;
                    }
                    
                }
            }
            return top;
        }else{
        
            NSArray *labelArr = _selectArr[indexPath.section];
            
            if (labelArr.count == 0) {
                return 0;
            }
            CGFloat left = 20;
            CGFloat top = 10;
            for (int i = 0; i < labelArr.count; i++) {
                
                CGRect rect = [labelArr[i][@"attribute_name"] boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
                
                
                if (left + rect.size.width > kScreenWidth - 40) {
                    top = top +30;
                    left = 20;
                }
                left = left + rect.size.width + 20;
                
            }
            
            return top + 34;
            
        }

    }else{

    
    if (flag[indexPath.section]) {

        NSArray *labelArr = _dataArr[indexPath.section][@"selectitem"];
        CGFloat left = 20;
        CGFloat top = 40;
        NSLog(@"%@",labelArr);
        for (int i = 0; i < labelArr.count; i++) {
            
            CGRect rect = [labelArr[i][@"attribute_name"] boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
            
            NSLog(@"%lf",rect.size.width);
            
            
            if (left + rect.size.width > kScreenWidth - 40) {
                top = top +30;
                left = 20;
            }
            
            left = left + rect.size.width +20;
            
        }
        
        NSLog(@"%lf",top);
        return top + 30;
        
    }else{
        
        NSArray *labelArr = _selectArr[indexPath.section];

        if (labelArr.count == 0) {
            return 0;
        }
        CGFloat left = 20;
        CGFloat top = 10;
        for (int i = 0; i < labelArr.count; i++) {
            
            CGRect rect = [labelArr[i][@"attribute_name"] boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
            
            
            if (left + rect.size.width > kScreenWidth - 40) {
                top = top +30;
                left = 20;
            }
            left = left + rect.size.width + 20;
            
        }
        
        return top + 34;
        
    }
    }
    
    
    return 44;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01f;
}



//展开收缩cell
- (void)salesButtonAction:(UIButton*)bt{
   

    NSLog(@"%@",_selectArr);
    NSInteger section = bt.superview.superview.tag - 1110;

    flag[section]=!flag[section];

//        刷新方法
    NSIndexSet *indexSet=[NSIndexSet indexSetWithIndex:section];
    
    [_myTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    
}



//返回
- (void)leftBtnAction{

    [self.navigationController popViewControllerAnimated:YES];

}
//保存
- (void)editAction{
    
    NSMutableArray *arr1 = [NSMutableArray array];

    for (NSArray *arr in _selectArr) {
        
        if (arr.count != 0) {
            
            for (NSDictionary *dic in arr) {
                [arr1 addObject:dic];
            }
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LabelClassificationNotification" object:[arr1 copy]];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
