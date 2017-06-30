//
//  ExpectedDeliveryType ViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/11/3.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "ExpectedDeliveryType ViewController.h"

@interface ExpectedDeliveryType_ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *dataArr;

@property (nonatomic,strong) UITableView *myTableView;

@end

@implementation ExpectedDeliveryType_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _dataArr = @[@{@"title":@"立即",@"id":@"1"},@{@"title":@"1-3天",@"id":@"2"},@{@"title":@"3-5天",@"id":@"3"},@{@"title":@"5-10天",@"id":@"4"},@{@"title":@"10天以上",@"id":@"5"}];
    
    self.navigationItem.title = @"发货时间选择";
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"Back Chevron@2x"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    
    _myTableView.delegate = self;
    
    _myTableView.dataSource = self;
    
    
    
    [self.view addSubview:_myTableView];
    
    _myTableView.tableFooterView = [[UIView alloc]init];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _dataArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExpectedDeliveryTypeCell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ExpectedDeliveryTypeCell"];
        
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
    }
    
    cell.textLabel.text = _dataArr[indexPath.row][@"title"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ExpectedDeliveryTypeNotification" object:_dataArr[indexPath.row]];

}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)leftBtnAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    //改变导航栏标题的字体颜色和大小
    UIImage *image = [UIImage imageNamed:@"navbar@2x"];
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#787fc6"]}];
    
    
    
}


@end
