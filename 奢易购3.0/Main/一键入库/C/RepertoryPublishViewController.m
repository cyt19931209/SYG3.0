//
//  RepertoryPublishViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/10/25.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "RepertoryPublishViewController.h"
#import "RepertoryPublishCell.h"

@interface RepertoryPublishViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UITableView *myTableView;


@end

@implementation RepertoryPublishViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    _dataArr = [NSMutableArray array];
    self.navigationItem.title = @"库存发布";
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];

    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"Back Chevron@2x"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 56)];
    
    whiteView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:whiteView];
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 55, kScreenWidth, 1)];
    
    lineV.backgroundColor = [RGBColor colorWithHexString:@"#d9d9d9"];
    
    [whiteView addSubview:lineV];
    
    UITextField *findTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth - 80, 34)];
    
    findTextField.backgroundColor = [RGBColor colorWithHexString:@"#f7f7f7"];
    
    findTextField.font = [UIFont systemFontOfSize:16];
    
    findTextField.placeholder = @"请输入你要查找的内容";
    
    findTextField.borderStyle = UITextBorderStyleRoundedRect;

    [whiteView addSubview:findTextField];
    
    UIButton *findButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    findButton.backgroundColor = [RGBColor colorWithHexString:@"#787fc6"];
    
    findButton.frame = CGRectMake(kScreenWidth - 60 , 10, 50, 34);
    
    [findButton setTitle:@"查找" forState:UIControlStateNormal];
    
    findButton.titleLabel.font = [UIFont systemFontOfSize:16];
    findButton.layer.cornerRadius = 8;
    findButton.layer.masksToBounds = YES;
    
    [whiteView addSubview:findButton];

    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 120, kScreenWidth, kScreenHeight - 120) style:UITableViewStylePlain];
    
    _myTableView.delegate = self;
    
    _myTableView.dataSource = self;
    
    [self.view addSubview:_myTableView];
    
    [_myTableView registerNib:[UINib nibWithNibName:@"RepertoryPublishCell" bundle:nil] forCellReuseIdentifier:@"RepertoryPublishCell"];

    
    [self loadData];
    
    
}

- (void)loadData{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    
    [DataSeviece requestUrl:Shareget_goods_listhtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            
            [_dataArr addObject:dic];
        }
        
        [_myTableView reloadData];
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RepertoryPublishCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RepertoryPublishCell" forIndexPath:indexPath];
    
    cell.dic = _dataArr[indexPath.row];
    
    return cell;
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

    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#787fc6"]}];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 110;
}



@end
