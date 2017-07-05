//
//  CustomerInformationViewController.m
//  奢易购3.0
//
//  Created by Andy on 16/9/29.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "CustomerInformationViewController.h"
#import "CustomerInformationCell.h"
#import "MJRefresh.h"
#import "AddCustomerView.h"


@interface CustomerInformationViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{

    UITextField *searchTextField;
//    BOOL isType;
    NSInteger page;
    
    NSString *keyword;

    AddCustomerView *addCustomerV;
    
    UIView *bgView;
    
    
}

@property (nonatomic,strong) UITableView *customerTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation CustomerInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SupplierTureNotification) name:@"SupplierTureNotification" object:nil];
    
    _dataArr = [NSMutableArray array];
    
    keyword = @"";
    page = 1;
    self.navigationItem.title = @"客户信息";
    
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

    
    searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth - 80, 30)];
    searchTextField.backgroundColor = [RGBColor colorWithHexString:@"ffffff"];
    searchTextField.layer.cornerRadius = 5;
    searchTextField.layer.masksToBounds = YES;
    searchTextField.delegate = self;
    [self.view addSubview:searchTextField];
    
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    searchButton.frame = CGRectMake(kScreenWidth - 60, 10, 50, 30);
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    searchButton.backgroundColor = [RGBColor colorWithHexString:@"#787fc6"];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchButton.layer.cornerRadius = 5;
    searchButton.layer.masksToBounds = YES;
    searchButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:searchButton];
    
    _customerTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, kScreenHeight - 50 - 64) style:UITableViewStylePlain];
    
    _customerTableView.delegate = self;
    _customerTableView.dataSource = self;
    _customerTableView.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    [self.view addSubview:_customerTableView];
    
    [_customerTableView registerNib:[UINib nibWithNibName:@"CustomerInformationCell" bundle:nil] forCellReuseIdentifier:@"CustomerInformationCell"];
    _customerTableView.tableFooterView = [[UIView alloc]init];
    
    //上拉加载
    
    _customerTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        page++;
        
        [self loadData];
        
    }];
    
    //下拉刷新
    
    _customerTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        page = 1;
        
        [self loadData];

    }];

    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
//    
//    _dataArr = [NSMutableArray arrayWithArray:[defaults objectForKey:SYGData[@"id"]]];
//
    
    [self loadData];
//    [_customerTableView reloadData];

    //遮罩视图
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgView.backgroundColor = [RGBColor colorWithHexString:@"#2d2d2d"];
    bgView.alpha = .4;
    bgView.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    
    UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bgButton.frame = bgView.frame;
    [bgButton addTarget:self action:@selector(bgButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:bgButton];
    
    
}

- (void)bgButtonAction{
    
    bgView.hidden = YES;
    addCustomerV.hidden = YES;

    [addCustomerV.nameTextField resignFirstResponder];
    [addCustomerV.phoneTextField resignFirstResponder];
    [addCustomerV.weixinTextField resignFirstResponder];
}


//查找
- (void)searchAction{

    [searchTextField resignFirstResponder];

    keyword = searchTextField.text;
    
    page = 1;
    
    [self loadData];
}


//返回
- (void)leftBtnAction{

    [self.navigationController popViewControllerAnimated:YES];

}

- (void)loadData{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:keyword forKey:@"keyword"];
    
    [params setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
    
    
    [DataSeviece requestUrl:get_customerhtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        if (page == 1) {
            [_dataArr removeAllObjects];
        }
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            [_dataArr addObject:[NULLHandle NUllHandle:dic]];
        }
        
        
        [_customerTableView reloadData];
        
        [_customerTableView.header endRefreshing];
        
        [_customerTableView.footer endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [_customerTableView.header endRefreshing];
        [_customerTableView.footer endRefreshing];
        
    }];

}

//添加
- (void)addAction{

    bgView.hidden = NO;
    
    addCustomerV = [[[NSBundle mainBundle]loadNibNamed:@"AddCustomerView" owner:self options:nil]lastObject];
    addCustomerV.layer.cornerRadius = 5;
    addCustomerV.layer.masksToBounds = YES;
    addCustomerV.frame = CGRectMake(10, (kScreenHeight-275)/2, kScreenWidth - 20, 275);
    addCustomerV.isAdd = YES;
    
    [[UIApplication sharedApplication].keyWindow addSubview:addCustomerV];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CustomerInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomerInformationCell"];
    cell.dic = _dataArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    bgView.hidden = NO;
    
    addCustomerV = [[[NSBundle mainBundle]loadNibNamed:@"AddCustomerView" owner:self options:nil]lastObject];
    addCustomerV.layer.cornerRadius = 5;
    addCustomerV.layer.masksToBounds = YES;
    addCustomerV.frame = CGRectMake(10, (kScreenHeight-275)/2, kScreenWidth - 20, 275);
    addCustomerV.isAdd = NO;
    addCustomerV.dic = _dataArr[indexPath.row];
    addCustomerV.KHId = _KHId;
    [[UIApplication sharedApplication].keyWindow addSubview:addCustomerV];

    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    
    return YES;
}
//通知
- (void)SupplierTureNotification{
    bgView.hidden = YES;
    addCustomerV.hidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
