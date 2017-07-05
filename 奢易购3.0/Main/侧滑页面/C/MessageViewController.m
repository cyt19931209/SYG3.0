//
//  MessageViewController.m
//  奢易购3.0
//
//  Created by guest on 16/8/31.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "MessageViewController.h"
#import "MJRefresh.h"
#import "MessageXQViewController.h"

@interface MessageViewController ()<UITableViewDataSource,UITableViewDelegate>{

    NSInteger page;
}

@property (nonatomic,strong) UITableView *myTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    self.navigationItem.title = @"消息中心";
    
    _dataArr = [NSMutableArray array];
    page = 1;
    //改变导航栏标题的字体颜色和大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏背景.png"] forBarMetrics:UIBarMetricsDefault];
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"返回（20x38）.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"f1f2fa"];
    
    
    [self loadData];
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_myTableView];
    
    _myTableView.tableFooterView = [[UIView alloc]init];
    
    __weak MessageViewController *weakSelf = self;
    
    //下拉刷新
    
    _myTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        page = 1;
        [weakSelf loadData];
        
    }];
    //上拉加载
    
    _myTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        page++;
        [weakSelf loadData];
        
        
    }];

    
}


//左边返回按钮
- (void)leftBtnAction{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


- (void)loadData{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
    
    
    [DataSeviece requestUrl:get_messagerie_listhtml params:params success:^(id result) {
        NSLog(@"%@",result);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            if (page == 1) {
                [_dataArr removeAllObjects];
            }
            
            for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
                
                [_dataArr addObject:[NULLHandle NUllHandle:dic]];
                
            }
            [_myTableView reloadData];
        }
        
        [_myTableView.header endRefreshing];
        [_myTableView.footer endRefreshing];
        
    } failure:^(NSError *error) {
        
        [_myTableView.header endRefreshing];
        [_myTableView.footer endRefreshing];

        NSLog(@"%@",error);
        
    }];

    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageCell"];
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 17, 10, 10)];
        imageV.tag = 100;
        imageV.backgroundColor = [RGBColor colorWithHexString:@"787fbb"];
        imageV.layer.cornerRadius = 5;
        imageV.layer.masksToBounds = YES;
        [cell.contentView addSubview:imageV];
        
    
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(imageV.right+10, 12, kScreenWidth-130, 20)];
        label1.font = [UIFont systemFontOfSize:14];
        label1.tag = 101;
        [cell.contentView addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-100, 12, 90, 20)];
        label2.font = [UIFont systemFontOfSize:14];
        label2.textAlignment = NSTextAlignmentRight;
        label2.tag = 102;
        [cell.contentView addSubview:label2];

    }
    
    UIImageView *imageV = [cell.contentView viewWithTag:100];
    
    UILabel *label1 = [cell.contentView viewWithTag:101];
    
    UILabel *label2 = [cell.contentView viewWithTag:102];


    if ([_dataArr[indexPath.row][@"is_read"] isEqualToString:@"1"]) {
        
        label1.textColor = [RGBColor colorWithHexString:@"#999999"];
        label1.text = _dataArr[indexPath.row][@"title"];
        
        label2.textColor = [RGBColor colorWithHexString:@"#999999"];
        label2.text = _dataArr[indexPath.row][@"add_time"];
        
        imageV.hidden = YES;
        
    }else{
    
        label1.textColor = [RGBColor colorWithHexString:@"#666666"];
        label1.text = _dataArr[indexPath.row][@"title"];
        
        label2.textColor = [RGBColor colorWithHexString:@"#666666"];
        label2.text = _dataArr[indexPath.row][@"add_time"];
        imageV.hidden = NO;

    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    MessageXQViewController *messageXQVC = [[MessageXQViewController alloc]init];
    
    messageXQVC.XQId = _dataArr[indexPath.row][@"id"];
    
    [self.navigationController pushViewController:messageXQVC animated:YES];
    
    
}




@end
