//
//  SortConditionViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/10/27.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "SortConditionViewController.h"

@interface SortConditionViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UITableView *myTableView;


@end

@implementation SortConditionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.navigationItem.title = @"类别选择";
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    _dataArr = [NSMutableArray array];
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"返回（20x38）.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;

    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    
    _myTableView.delegate = self;
    
    _myTableView.dataSource = self;
    
    [self.view addSubview:_myTableView];
    
 
    [self loadData];
    
    _myTableView.tableFooterView = [[UIView alloc]init];

}


- (void)loadData{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [DataSeviece requestUrl:get_share_categoryhtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            [_dataArr addObject:dic];
        }
        
        [_myTableView reloadData];
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr = _dataArr[section][@"child"];
    
    return arr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SortCell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SortCell"];
        
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
    }
    
    cell.textLabel.text = _dataArr[indexPath.section][@"child"][indexPath.row][@"category_name"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 22;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UITableViewHeaderFooterView *headerView= [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BrandHeaderView"];
    
    if (!headerView) {
        
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"BrandHeaderView"];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 20)];
        
        label.textColor = [RGBColor colorWithHexString:@"#999999"];
        
        label.font = [UIFont systemFontOfSize:14];
        
        label.tag = 200;
        
        [headerView.contentView addSubview:label];
        
        headerView.contentView.backgroundColor = [RGBColor colorWithHexString:@"#f7f7f7"];
        
    }
    
    UILabel *label = [headerView.contentView viewWithTag:200];
    
    
    
    label.text = _dataArr[section][@"category_name"];
    
    
    return headerView;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SortConditionNotification" object:_dataArr[indexPath.section][@"child"][indexPath.row]];
    
    [self.navigationController popViewControllerAnimated:YES];
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
