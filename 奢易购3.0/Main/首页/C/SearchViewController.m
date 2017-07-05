//
//  SearchViewController.m
//  奢易购3.0
//
//  Created by guest on 16/7/26.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchTypeViewController.h"
#import "SearchTypeCell.h"
#import "MerchandiseViewController.h"
#import "StockDetailsViewController.h"
#import "TransactionRecordViewController.h"
#import "AppDelegate.h"
#import "BooksDetailsViewController.h"

@interface SearchViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>{
    UITableView *myTableView;
    UILabel *serhLabel;
    UIImageView *serhImageV;
    UIView *serhV;
}



@property (nonatomic,strong) UIImageView *searchView;
@property (nonatomic,strong) UITextField *searchTextField;
@property (nonatomic,strong) NSMutableArray *consighmentArr;
@property (nonatomic,strong) NSMutableArray *paylogArr;
@property (nonatomic,strong) NSMutableArray *goodsArr;
@property (nonatomic,strong) NSMutableArray *salesArr;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _consighmentArr = [NSMutableArray array];
    _goodsArr = [NSMutableArray array];
    _salesArr = [NSMutableArray array];
    _paylogArr = [NSMutableArray array];

    //改变导航栏标题的字体颜色和大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏背景.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f7f7fb"];

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[UIView alloc]init]];
    
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 35, 30);
    [rightBtn setTitle:@"取消" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    _searchView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7, kScreenWidth-75, 30)];
    _searchView.image = [UIImage imageNamed:@"搜索框.png"];
    _searchView.hidden = NO;
    _searchView.userInteractionEnabled = YES;
    [self.navigationController.navigationBar addSubview:_searchView];
    
    
    _searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(30, 0, _searchView.width-40, 30)];
    _searchTextField.placeholder = @"搜索";
    _searchTextField.textColor = [RGBColor colorWithHexString:@"#999999"];
    _searchTextField.font = [UIFont systemFontOfSize:15];
    _searchTextField.delegate = self;
     _searchTextField.clearButtonMode = UITextFieldViewModeAlways;
    _searchTextField.clearsOnBeginEditing = NO;
    [_searchTextField setReturnKeyType:UIReturnKeySearch];
    [_searchView addSubview:_searchTextField];
    
    NSArray *imageArr = @[@"寄卖单",@"账本",@"库存货品",@"销售记录"];
    
    
    for (int i = 0 ; i < 4; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kScreenWidth/4*i, 50, kScreenWidth/4, 51);
        button.tag = 100+i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 51, 51)];
        imageV.center = button.center;
        imageV.image = [UIImage imageNamed:imageArr[i]];
        [self.view addSubview:imageV];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 ,75, 20)];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [RGBColor colorWithHexString:@"#333333"];
        label.text = imageArr[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.center = button.center;
        label.top = button.bottom+12;
        [self.view addSubview:label];
    }
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.backgroundColor = [RGBColor colorWithHexString:@"#f7f7fb"];
    myTableView.hidden = YES;
    [self.view addSubview:myTableView];
    [myTableView registerNib:[UINib nibWithNibName:@"SearchTypeCell" bundle:nil] forCellReuseIdentifier:@"SearchTypeCell"];
    
    serhV = [[UIView alloc]initWithFrame:self.view.bounds];
    
    serhV.backgroundColor = [RGBColor colorWithHexString:@"#f7f7fb"];
    serhV.hidden = YES;
    [self.view addSubview:serhV];
    
    
    serhImageV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 53, 50, 105, 106)];
    serhImageV.image = [UIImage imageNamed:@"serh@2x"];
    serhImageV.hidden = YES;
    [serhV addSubview:serhImageV];
    
    serhLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, serhImageV.bottom+30, kScreenWidth, 20)];
    
    serhLabel.textColor = [RGBColor colorWithHexString:@"#999999"];
    serhLabel.font = [UIFont systemFontOfSize:15];
    serhLabel.text = @"抱歉,没有找到您搜索的内容";
    serhLabel.hidden = YES;
    serhLabel.textAlignment = NSTextAlignmentCenter;
    [serhV addSubview:serhLabel];
    
}


//button点击方法
- (void)buttonAction:(UIButton*)bt{
    
    _searchView.hidden = YES;
    [_searchTextField resignFirstResponder];

    SearchTypeViewController *searchTypeVC = [[SearchTypeViewController alloc]init];
    searchTypeVC.selectArr = _selectArr;
    if (bt.tag == 100) {
        searchTypeVC.type = @"1";
    }else if (bt.tag == 101){
        searchTypeVC.type = @"2";
    }else if (bt.tag == 102){
        searchTypeVC.type = @"3";
    }else if (bt.tag == 103){
        searchTypeVC.type = @"4";
    }

    [self.navigationController pushViewController:searchTypeVC animated:YES];
    
}

#pragma mark - UITableViewDataSource||UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _consighmentArr.count;
    }else if (section == 1){
        return _paylogArr.count;
    }else if (section == 2){
        return _goodsArr.count;
    }else if (section == 3){
        return _salesArr.count;
    }

    return 0;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchTypeCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [RGBColor colorWithHexString:@"#f7f7fb"];
    if (indexPath.section == 0) {
        cell.type = @"1";
        cell.model = _consighmentArr[indexPath.row];
    }else if (indexPath.section == 1){
        cell.type = @"2";
        cell.model = _paylogArr[indexPath.row];
    }else if (indexPath.section == 2){
        cell.type = @"3";
        cell.model = _goodsArr[indexPath.row];
    }else if (indexPath.section == 3){
        cell.type = @"4";
        cell.model = _salesArr[indexPath.row];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor = [RGBColor colorWithHexString:@"#f7f7fb"];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 20)];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [RGBColor colorWithHexString:@"#999999"];
    [view addSubview:label];
    
    if (section == 0) {
        label.text = @"寄卖单";
    }else if (section == 1){
        label.text = @"账本";
    }else if (section == 2){
        label.text = @"库存";
    }else if (section == 3){
        label.text = @"销售记录";
    }

    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    
    if (indexPath.section == 0) {
        _searchView.hidden = YES;
        
        [_searchTextField resignFirstResponder];
        SearchTypeModel *model = _consighmentArr[indexPath.row];

        MerchandiseViewController *merchandiseVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"MerchandiseViewController"];
        merchandiseVC.status = @"1";
        merchandiseVC.merchandiseId = model.typeId;
        merchandiseVC.isSearch = YES;

        [self.navigationController pushViewController:merchandiseVC animated:YES];
        
    }else if (indexPath.section == 1){
        
        _searchView.hidden = YES;
        
        [_searchTextField resignFirstResponder];
        
        BooksDetailsViewController *booksDetailsVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"BooksDetailsViewController"];
        
        SearchTypeModel *model = _paylogArr[indexPath.row];
        
        booksDetailsVC.booksId = model.typeId;
        
        [self.navigationController pushViewController:booksDetailsVC animated:YES];

        
    }else if (indexPath.section == 2){
        _searchView.hidden = YES;
        
        [_searchTextField resignFirstResponder];
        SearchTypeModel *model = _goodsArr[indexPath.row];

        if ([model.type isEqualToString:@"JM"]) {
            MerchandiseViewController *merchandiseVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"MerchandiseViewController"];
            merchandiseVC.status = @"1";
            
            merchandiseVC.merchandiseId = model.consighment_id;
            merchandiseVC.isSearch = YES;
            [self.navigationController pushViewController:merchandiseVC animated:YES];
            
            
        }else{
            
            StockDetailsViewController *stockDetailVC = [[UIStoryboard storyboardWithName:@"Share" bundle:nil] instantiateViewControllerWithIdentifier:@"StockDetailsViewController"];
            stockDetailVC.isType = @"1";
            stockDetailVC.SPID = model.typeId;
            stockDetailVC.isSearch = YES;
            [self.navigationController pushViewController:stockDetailVC animated:YES];
        }


    }else if (indexPath.section == 3){
        _searchView.hidden = YES;
        
        [_searchTextField resignFirstResponder];
        
        TransactionRecordViewController *transactionRecordVC = [[UIStoryboard storyboardWithName:@"Share" bundle:nil] instantiateViewControllerWithIdentifier:@"TransactionRecordViewController"];
        SearchTypeModel *model = _salesArr[indexPath.row];
        
        
        transactionRecordVC.sales_id = model.sales_id;
        transactionRecordVC.arr = _selectArr;
        [self.navigationController pushViewController:transactionRecordVC animated:YES];
        
    }
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //改变导航栏标题的字体颜色和大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏背景.png"] forBarMetrics:UIBarMetricsDefault];
    
    _searchView.hidden = NO;
}

//取消按钮
- (void)cancelAction{
    
    _searchView.hidden = YES;
    _searchView = nil;
    [_searchTextField resignFirstResponder];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackNotification" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [_salesArr removeAllObjects];
    [_consighmentArr removeAllObjects];
    [_goodsArr removeAllObjects];
    [_paylogArr removeAllObjects];
    
    [textField resignFirstResponder];
    
    myTableView.hidden = NO;
    serhLabel.hidden = YES;
    serhImageV.hidden = YES;
    serhV.hidden = YES;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"]forKey:@"uid"];
    
    [params setObject:_searchTextField.text forKey:@"keyword"];
    
    [DataSeviece requestUrl:search_allhtml params:params success:^(id result) {
        NSLog(@"%@",result);
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"consighment"]) {
            NSDictionary *dic1 = [NULLHandle NUllHandle:dic];
            SearchTypeModel *model = [[SearchTypeModel alloc]initWithContentsOfDic:dic1];
            model.typeId = dic1[@"id"];
            [_consighmentArr addObject:model];
        }
        for (NSDictionary *dic in result[@"result"][@"data"][@"goods"]) {
            NSDictionary *dic1 = [NULLHandle NUllHandle:dic];
            SearchTypeModel *model = [[SearchTypeModel alloc]initWithContentsOfDic:dic1];
            model.typeId = dic1[@"id"];
            [_goodsArr addObject:model];
        }
        for (NSDictionary *dic in result[@"result"][@"data"][@"paylog"]) {
            NSDictionary *dic1 = [NULLHandle NUllHandle:dic];
            SearchTypeModel *model = [[SearchTypeModel alloc]initWithContentsOfDic:dic1];
            model.typeId = dic1[@"id"];
            [_paylogArr addObject:model];
        }
        for (NSDictionary *dic in result[@"result"][@"data"][@"sales"]) {
            NSDictionary *dic1 = [NULLHandle NUllHandle:dic];
            SearchTypeModel *model = [[SearchTypeModel alloc]initWithContentsOfDic:dic1];
            model.typeId = dic1[@"id"];
            [_salesArr addObject:model];
        }
        
        [myTableView reloadData];
        
        if (_consighmentArr.count == 0&&_salesArr.count == 0&&_paylogArr.count == 0&&_goodsArr.count == 0) {
            myTableView.hidden = YES;
            serhV.hidden = NO;
            serhLabel.hidden = NO;
            serhImageV.hidden = NO;
        }
        
    } failure:^(NSError *error) {
         NSLog(@"%@",error);
    }];

    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    serhV.hidden = YES;
    serhImageV.hidden = YES;
    serhLabel.hidden = YES;

    return YES;
}

@end
