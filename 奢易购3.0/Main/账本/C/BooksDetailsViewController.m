//
//  BooksDetailsViewController.m
//  奢易购3.0
//
//  Created by Andy on 16/9/19.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "BooksDetailsViewController.h"
#import "StockCellectionCell.h"
#import "ScanViewController.h"
#import "EditBooksViewController.h"

@interface BooksDetailsViewController ()<UICollectionViewDataSource>


@property (weak, nonatomic) IBOutlet UICollectionView *stockCollectionView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) NSDictionary *dataDic;

@end

@implementation BooksDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _dataArr = [NSMutableArray array];
    [_stockCollectionView registerNib:[UINib nibWithNibName:@"StockCellectionCell" bundle:nil] forCellWithReuseIdentifier:@"StockCellectionCell"];

    self.navigationItem.title = @"账本记录";

    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景框.png"]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"背景框.png"] forBarMetrics:UIBarMetricsDefault];
    
    
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
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    
    
//    [self loadData];
    

}

//编辑
- (void)editAction{


    EditBooksViewController *editBooksVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"EditBooksViewController"];
    
    editBooksVC.dataDic = _dataDic;
    [self.navigationController pushViewController:editBooksVC animated:YES];
    

    
}


//加载数据
- (void)loadData{


    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:_booksId forKey:@"id"];

    [DataSeviece requestUrl:get_payloghtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        NSDictionary *dic = result[@"result"][@"data"];
        
        _dataDic = dic;
        
        _SPMLabel.text = dic[@"goods_name"];
        _SPSLLabel.text = [NSString stringWithFormat:@"x%@",dic[@"nums"]];
        _JELabel.text = [NSString stringWithFormat:@"￥%@",dic[@"amount"]];
        _DFXMLabel.text = dic[@"customer_name"];
        if ([dic[@"type"] isEqualToString:@"1"]) {
            _FKZHLabel.text = [NSString stringWithFormat:@"付款账号:%@",dic[@"account"]];
            _FKJSRLabel.text = [NSString stringWithFormat:@"付款经手人:%@",dic[@"add_user_name"]];
            _FKSJLabel.text = [NSString stringWithFormat:@"付款时间:%@",dic[@"add_time"]];
        }else{
            _FKZHLabel.text = [NSString stringWithFormat:@"收款账号:%@",dic[@"account"]];
            _FKJSRLabel.text = [NSString stringWithFormat:@"收款经手人:%@",dic[@"add_user_name"]];
            _FKSJLabel.text = [NSString stringWithFormat:@"收款时间:%@",dic[@"add_time"]];
        }
        
        if ([dic[@"payment"] isEqualToString:@"1"]) {
            _imageV.image = [UIImage imageNamed:@"支付宝"];
        }else if ([dic[@"payment"] isEqualToString:@"2"]){
            _imageV.image = [UIImage imageNamed:@"微信支付"];
        }else if ([dic[@"payment"] isEqualToString:@"3"]){
            _imageV.image = [UIImage imageNamed:@"银行卡"];
        }else if ([dic[@"payment"] isEqualToString:@"4"]){
            _imageV.image = [UIImage imageNamed:@"POS机"];
        }else if ([dic[@"payment"] isEqualToString:@"5"]){
            _imageV.image = [UIImage imageNamed:@"置换"];
        }else if ([dic[@"payment"] isEqualToString:@"0"]){
            _imageV.image = nil;
        }
        
        [_dataArr removeAllObjects];
        for (NSString *str in result[@"result"][@"data"][@"imurl"]) {

            NSString *newStr = [NSString stringWithFormat:@"%@%@",imgUrl,str];
            
            [_dataArr addObject:newStr];
        }

        [_stockCollectionView reloadData];
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StockCellectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StockCellectionCell" forIndexPath:indexPath];
    
    cell.url = _dataArr[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ScanViewController *scanVC = [[ScanViewController alloc]init];
//    NSMutableArray *imageArr = [NSMutableArray array];
//    for (NSDictionary *dic in _dataArr) {
//        
//        [imageArr addObject:dic[@"image_url"]];
//    }
    scanVC.imageURLArr = _dataArr;
    scanVC.currentIndexPath = indexPath;
    [self.navigationController pushViewController:scanVC animated:YES];
    
}

//左边返回按钮
- (void)leftBtnAction{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackNotification" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

    [self loadData];
}


@end
