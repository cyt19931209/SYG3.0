//
//  GradeConditionViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/10/27.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "GradeConditionViewController.h"

@interface GradeConditionViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *dataArr;

@property (nonatomic,strong) UITableView *myTableView;

@end

@implementation GradeConditionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _dataArr = @[@{@"title":@"全新(未使用)",@"id":@"1"},@{@"title":@"98成新(未使用，成列品)",@"id":@"2"},@{@"title":@"95成新(几乎未使用)",@"id":@"3"},@{@"title":@"9成新(偶尔使用)",@"id":@"4"},@{@"title":@"85成新(正常使用)",@"id":@"5"},@{@"title":@"8成新(长期使用)",@"id":@"6"}];
    
    self.navigationItem.title = @"成色选择";
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"返回（20x38）.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    
    _myTableView.delegate = self;
    
    _myTableView.dataSource = self;
    
    
    
    [self.view addSubview:_myTableView];
    

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _dataArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GradeCell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GradeCell"];
        
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

    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GradeConditionNotification" object:_dataArr[indexPath.row]];
    
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
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#ffffff"]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏背景.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    
}



@end
