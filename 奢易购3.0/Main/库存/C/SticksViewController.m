//
//  SticksViewController.m
//  奢易购3.0
//
//  Created by Andy on 16/9/29.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "SticksViewController.h"
#import "SticksCell.h"
#import "FinanceViewController.h"

@interface SticksViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UITableView *sticksTableView;



@end

@implementation SticksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SticksNotification) name:@"SticksNotification" object:nil];
    
    _dataArr = [NSMutableArray array];
    
    self.navigationItem.title = @"经手人";
    
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
    
    //右边Item
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 35, 30);
    [rightBtn setTitle:@"添加" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    _sticksTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    _sticksTableView.delegate = self;
    _sticksTableView.dataSource = self;
    [self.view addSubview:_sticksTableView];
    
    _sticksTableView.tableFooterView = [[UIView alloc]init];
    
    [_sticksTableView registerNib:[UINib nibWithNibName:@"SticksCell" bundle:nil] forCellReuseIdentifier:@"SticksCell"];
    
    [self loadData];
    
}
//加载数据
- (void)loadData{

    //网络加载
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    
    [DataSeviece requestUrl:get_userhtml params:[@{@"uid":SYGData[@"id"]} mutableCopy] success:^(id result) {
        
        NSLog(@"%@",result);
        NSString *msgStr = result[@"result"][@"msg"];
        NSLog(@"%@",msgStr);
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            [_dataArr addObject:dic];
        }
        
        [_sticksTableView reloadData];
        
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
    
    SticksCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SticksCell"];
    
    cell.dic = _dataArr[indexPath.section];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"AddSticksNotification" object:_dataArr[indexPath.section]];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 70;
}

//返回
- (void)leftBtnAction{

    [self.navigationController popViewControllerAnimated:YES];
    
}

//添加
- (void)addAction{
    
    //人员管理
    FinanceViewController *financeVC = [[FinanceViewController alloc]init];
    financeVC.isPersonnel = YES;
    
    [self.navigationController pushViewController:financeVC animated:YES];
    

}

- (void)SticksNotification{

    [_dataArr removeAllObjects];
    
    [self loadData];
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}


@end
