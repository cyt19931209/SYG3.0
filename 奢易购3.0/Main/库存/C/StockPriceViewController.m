//
//  StockPriceViewController.m
//  奢易购3.0
//
//  Created by guest on 16/8/29.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "StockPriceViewController.h"
#import "StockPriceCell.h"
#import "StockModel.h"
#import "StockDetailsViewController.h"
#import "MerchandiseViewController.h"


@interface StockPriceViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{

    NSString *keyword;
}


@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UITableView *myTableView;

@property (nonatomic,strong) UITextField *searchTextField;

@end

@implementation StockPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //类型选择
    
    [self selectTypeLoadData];

    
    _dataArr = [NSMutableArray array];
    
    keyword = @"";
    //改变导航栏标题的字体颜色和大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏背景.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f7f7fb"];
    
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"返回（20x38）.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;

    
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, kScreenHeight-50-64) style:UITableViewStylePlain];
    
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    
//    _myTableView.backgroundColor = [RGBColor colorWithHexString:@"#f7f7fb"];

    
    [self.view addSubview:_myTableView];
    

    [_myTableView registerNib:[UINib nibWithNibName:@"StockPriceCell" bundle:nil] forCellReuseIdentifier:@"StockPriceCell"];
    
    _searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-80, 30)];
    
    _searchTextField.backgroundColor = [UIColor whiteColor];
    _searchTextField.font = [UIFont systemFontOfSize:14];
    _searchTextField.delegate = self;
    _searchTextField.placeholder = @"输入货码";
    [self.view addSubview:_searchTextField];
    
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(kScreenWidth-60, 10, 50, 30);
    searchButton.backgroundColor = [RGBColor colorWithHexString:@"787fc6"];
    searchButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [searchButton setTitle:@"查找" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];
    
    
    [self loadData];
    
    
    if ([_type isEqualToString:@"JM"]) {
        self.navigationItem.title  = @"寄卖抵价";
    }else{
        self.navigationItem.title  = @"库存抵价";

    }
    
    
}

//类型选择
- (void)selectTypeLoadData{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    [params setObject:@"1" forKey:@"classify"];
    
    [DataSeviece requestUrl:get_category_listhtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            _arr = result[@"result"][@"data"][@"item"];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)loadData{

    [_dataArr removeAllObjects];
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    [params setObject:keyword forKey:@"keyword"];
//    [params setObject:_type forKey:@"type"];
    [params setObject:_goods_id forKey:@"goods_id"];
    if ([_type isEqualToString:@"1"]) {
        
        [DataSeviece requestUrl:goods_searchhtml params:params success:^(id result) {
            
            NSLog(@"%@",result);
            
            for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
                
                StockModel *model = [[StockModel alloc]initWithContentsOfDic:[NULLHandle NUllHandle:dic]];
                
                model.SPID = dic[@"id"];
                [_dataArr addObject:model];
            }
            
            [_myTableView reloadData];
            

        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
            
        }];
        
    }else{
    
    [params setObject:_KHId forKey:@"customer_id"];
    [params setObject:_type forKey:@"type"];
    [params setObject:_goods_id forKey:@"goods_id"];
    
    [DataSeviece requestUrl:search_displace_goodshtml params:params success:^(id result) {
        NSLog(@"%@",result);
        for (NSDictionary *dic in result[@"result"][@"data"]) {
            StockModel *model = [[StockModel alloc]initWithContentsOfDic:[NULLHandle NUllHandle:dic]];
            
            model.SPID = dic[@"id"];
            [_dataArr addObject:model];
        }
        
        [_myTableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

    }
}

- (void)searchAction{
    
    keyword = _searchTextField.text;
    
    [self loadData];
}

//返回
- (void)leftBtnAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    StockPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StockPriceCell" forIndexPath:indexPath];
    
    cell.arr = _arr;
    cell.model = _dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 61;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    StockModel *model = _dataArr[indexPath.row];

    if ([model.type isEqualToString:@"HS"]) {
        StockDetailsViewController *stockDetailVC = [[UIStoryboard storyboardWithName:@"Share" bundle:nil] instantiateViewControllerWithIdentifier:@"StockDetailsViewController"];
        stockDetailVC.isType = @"2";
        stockDetailVC.SPID = model.SPID;
     
        [self.navigationController pushViewController:stockDetailVC animated:YES];
        
    }else{
        
        
        MerchandiseViewController *merchandiseVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"MerchandiseViewController"];
        merchandiseVC.isType = @"6";
        merchandiseVC.status = @"1";
        
        merchandiseVC.merchandiseId = model.consighment_id;
        
        [self.navigationController pushViewController:merchandiseVC animated:YES];
        
    }

    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //改变导航栏标题的字体颜色和大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏背景.png"] forBarMetrics:UIBarMetricsDefault];

    
}



@end
