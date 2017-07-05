//
//  AccountSwitchingViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/10/12.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "AccountSwitchingViewController.h"
#import "AccountSwitchingCell.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

@interface AccountSwitchingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *myTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;


@end

@implementation AccountSwitchingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr = [NSMutableArray array];
    
    self.navigationItem.title = @"账号切换";

    //改变导航栏标题的字体颜色和大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏背景.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"f1f2fa"];
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"返回（20x38）"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    
    _myTableView.delegate = self;
    
    _myTableView.dataSource = self;
    
    _myTableView.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    [self.view addSubview:_myTableView];
    
    [_myTableView registerNib:[UINib nibWithNibName:@"AccountSwitchingCell" bundle:nil] forCellReuseIdentifier:@"AccountSwitchingCell"];
    
    
    UIButton *footView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    
    footView.backgroundColor = [UIColor whiteColor];
    
    [footView addTarget:self action:@selector(footViewAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 76, 9, 26, 26)];
    imageV.image = [UIImage imageNamed:@"add1"];
    
    [footView addSubview:imageV];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 40, 12, 100, 20)];
    
    label.textColor = [RGBColor colorWithHexString:@"#787fc6"];
    
    label.font = [UIFont systemFontOfSize:16];
    
    label.text = @"添加账号";
    
    [footView addSubview:label];
    
    _myTableView.tableFooterView = footView;
    
 
    [self loadData];

}
//
- (void)footViewAction{



    
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    [delegate.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = loginVC;
    

    
    [self dismissViewControllerAnimated:YES completion:^{
        
        [delegate.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];

    }];
    


}

- (void)loadData{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *arr = [defaults objectForKey:@"IdArr"];
    
    for (NSString *idStr in arr) {
        
        
        [DataSeviece requestUrl:get_userinfohtml params:[@{@"uid":idStr} mutableCopy] success:^(id result) {
            
            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
            
            [_dataArr addObject:result[@"result"][@"data"]];
            
            [_myTableView reloadData];
            
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
            
        }];
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    AccountSwitchingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountSwitchingCell" forIndexPath:indexPath];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    if ([SYGData[@"id"] isEqualToString:_dataArr[indexPath.row][@"id"]]) {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }else{
    
        cell.accessoryType = UITableViewCellAccessoryNone;

    }
    
    cell.dic = _dataArr[indexPath.row];
    NSLog(@"%@",_dataArr[indexPath.row]);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[NULLHandle NUllHandle:_dataArr[indexPath.row]]];
    NSDictionary *dic1 = [NULLHandle NUllHandle:dic[@"shopinfo"]];
    [dic setObject:dic1 forKey:@"shopinfo"];
    [defaults setObject:dic forKey:@"SYGData"];
    [defaults synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeNotification" object:nil];

    [_myTableView reloadData];
    
}

//返回
- (void)leftBtnAction{

    [self.navigationController popViewControllerAnimated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 59;
}

@end
