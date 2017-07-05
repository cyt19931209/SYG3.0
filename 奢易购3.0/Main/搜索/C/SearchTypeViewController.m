//
//  SearchTypeViewController.m
//  奢易购3.0
//
//  Created by guest on 16/8/16.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "SearchTypeViewController.h"
#import "SearchTypeCell.h"
#import "SearchTypeModel.h"
#import "MJRefresh.h"
#import "MerchandiseViewController.h"
#import "StockDetailsViewController.h"
#import "TransactionRecordViewController.h"
#import "AppDelegate.h"
#import "BooksDetailsViewController.h"


@interface SearchTypeViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>{

    NSInteger page;
    UITableView *myTableView ;
    
    UILabel *serhLabel;
    UIImageView *serhImageV;
    
    UIView *_birthView;
    UIDatePicker *_datePicker;
    NSDate *_birthDate;
    
    
    BOOL isfirst;
    UIButton *firstButton;
    UIButton *lastButton;
    
    NSString *firstStr;
    NSString *lastStr;

}

@property (nonatomic,strong) UIImageView *searchView;
@property (nonatomic,strong) UITextField *searchTextField;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation SearchTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray array];
    page = 1;
    firstStr = @"";
    lastStr = @"";
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
    [_searchTextField setReturnKeyType:UIReturnKeySearch];
    _searchTextField.clearButtonMode = UITextFieldViewModeAlways;
    _searchTextField.clearsOnBeginEditing = NO;
    [_searchView addSubview:_searchTextField];
    
    UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 22, kScreenWidth-10, 17)];
    typeLabel.font = [UIFont systemFontOfSize:12];
    typeLabel.textColor = [RGBColor colorWithHexString:@"#999999"];
    [self.view addSubview:typeLabel];
    
    
    if ([_type isEqualToString:@"1"]) {
        _searchTextField.placeholder = @"寄卖单搜索";
        typeLabel.text = @"寄卖单";
    }else if ([_type isEqualToString:@"2"]){
        _searchTextField.placeholder = @"账本搜索";
        typeLabel.text = @"账本";
    }else if ([_type isEqualToString:@"3"]){
        _searchTextField.placeholder = @"库存搜索";
        typeLabel.text = @"库存";
    }else if ([_type isEqualToString:@"4"]){
        _searchTextField.placeholder = @"销售记录搜索";
        typeLabel.text = @"销售记录";
    }
    
    
    if ([_type isEqualToString:@"3"]){
        typeLabel.text = @"";
        
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 14)];
        timeLabel.text = @"按时间筛选:";
        timeLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
        timeLabel.font = [UIFont systemFontOfSize:12];
        [self.view addSubview:timeLabel];
        
        
        firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        firstButton.frame = CGRectMake(95, 5, 90, 24);
        
        [firstButton setTitle:@"选择起始时间" forState:UIControlStateNormal];

        [firstButton setTitleColor:[RGBColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        firstButton.titleLabel.font = [UIFont systemFontOfSize:12];

        firstButton.layer.cornerRadius = 4;
        firstButton.layer.masksToBounds = YES;
        firstButton.layer.borderWidth = 1;
        firstButton.layer.borderColor = [RGBColor colorWithHexString:@"#d9d9d9"].CGColor;
        
        [firstButton addTarget:self action:@selector(firstAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:firstButton];
        
        lastButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        lastButton.frame = CGRectMake(230, 5, 90, 24);
        
        [lastButton setTitle:@"选择截止时间" forState:UIControlStateNormal];
        
        [lastButton setTitleColor:[RGBColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        lastButton.titleLabel.font = [UIFont systemFontOfSize:12];
        
        lastButton.layer.cornerRadius = 4;
        lastButton.layer.masksToBounds = YES;
        lastButton.layer.borderWidth = 1;
        lastButton.layer.borderColor = [RGBColor colorWithHexString:@"#d9d9d9"].CGColor;
        [lastButton addTarget:self action:@selector(lastAction) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:lastButton];
        

        UIView *bgV = [[UIView alloc]initWithFrame:CGRectMake(198, 14, 20, 3)];
        bgV.backgroundColor = [RGBColor colorWithHexString:@"#666666"];
        [self.view addSubview:bgV];
        
    }
    

    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight-40-64) style:UITableViewStylePlain];
    
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:myTableView];

    [myTableView registerNib:[UINib nibWithNibName:@"SearchTypeCell" bundle:nil] forCellReuseIdentifier:@"SearchTypeCell"];
    
    __weak SearchTypeViewController *weakSelf = self;
    
    //下拉刷新
    
    myTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [weakSelf loadData];
    }];
    //上拉加载
    
    myTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        page++;
        [weakSelf loadData];
        
    }];

    serhImageV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 53, 50, 105, 106)];
    serhImageV.image = [UIImage imageNamed:@"serh@2x"];
    serhImageV.hidden = YES;
    [self.view addSubview:serhImageV];
    
    serhLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, serhImageV.bottom+30, kScreenWidth, 20)];
    
    serhLabel.textColor = [RGBColor colorWithHexString:@"#999999"];
    serhLabel.font = [UIFont systemFontOfSize:15];
    serhLabel.text = @"抱歉,没有找到您搜索的内容";
    serhLabel.hidden = YES;
    serhLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:serhLabel];

    
    _birthView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-300, kScreenWidth, 300)];
    _birthView.hidden = YES;
    _birthView.backgroundColor = [UIColor colorWithRed:236.0/255 green:236.0/255 blue:236.0/255 alpha:1];
    _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    _datePicker.locale = locale;
    [_birthView addSubview:_datePicker];
    UIButton *trueButton = [UIButton buttonWithType:UIButtonTypeSystem];
    trueButton.frame = CGRectMake(kScreenWidth-50, 0, 40, 40);
    [trueButton addTarget:self action:@selector(trueAction) forControlEvents:UIControlEventTouchUpInside];
    [trueButton setTitle:@"确定" forState:UIControlStateNormal];
    [_birthView addSubview:trueButton];
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.frame = CGRectMake(10, 0, 40, 40);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction1) forControlEvents:UIControlEventTouchUpInside];
    [_birthView addSubview:cancelButton];
    [self.view addSubview:_birthView];


}

- (void)trueAction{
    _birthView.hidden = YES;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormat stringFromDate:_datePicker.date];
    _birthDate = [dateFormat dateFromString:dateStr];
//    _RKSJTextField.text = dateStr;
    
    if (isfirst) {
        
        NSTimeInterval a=[_birthDate timeIntervalSince1970];

        if ([lastStr integerValue] < a&&![lastStr isEqualToString:@""]) {
            
            UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"截止时间不能小于起始时间" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertV show];
        }else{
            
            [firstButton setTitle:dateStr forState:UIControlStateNormal];
            
            [firstButton setTitleColor:[RGBColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
            
            
            firstStr =  [NSString stringWithFormat:@"%.0f", a];

        }
    }else{
        NSTimeInterval a=[_birthDate timeIntervalSince1970];

        if ([firstStr integerValue] > a) {
         
            UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"截止时间不能小于起始时间" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertV show];
        }else{
            [lastButton setTitle:dateStr forState:UIControlStateNormal];
            
            [lastButton setTitleColor:[RGBColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
            
            lastStr =  [NSString stringWithFormat:@"%.0f", a];

        }
    }
    
    
}
- (void)cancelAction1{
    _birthView.hidden = YES;
}




- (void)firstAction{

    isfirst = YES;
    _birthView.hidden = NO;

}

- (void)lastAction{

    isfirst = NO;

    _birthView.hidden = NO;

}


#pragma mark - UITableViewDataSource||UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    SearchTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchTypeCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [RGBColor colorWithHexString:@"#f7f7fb"];
    cell.type = _type;
    cell.model = _dataArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    
    if ([_type isEqualToString:@"1"]) {
        _searchView.hidden = YES;
        
        [_searchTextField resignFirstResponder];

        MerchandiseViewController *merchandiseVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"MerchandiseViewController"];
        merchandiseVC.status = @"1";
        SearchTypeModel *model = _dataArr[indexPath.row];

        merchandiseVC.merchandiseId = model.typeId;
        merchandiseVC.isSearch = YES;

        [self.navigationController pushViewController:merchandiseVC animated:YES];

    }else if ([_type isEqualToString:@"2"]){

        _searchView.hidden = YES;
        
        [_searchTextField resignFirstResponder];

        
        BooksDetailsViewController *booksDetailsVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"BooksDetailsViewController"];
        
        SearchTypeModel *model = _dataArr[indexPath.row];

        booksDetailsVC.booksId = model.typeId;
        
        [self.navigationController pushViewController:booksDetailsVC animated:YES];
        
        
    }else if ([_type isEqualToString:@"3"]){
        _searchView.hidden = YES;
        
        [_searchTextField resignFirstResponder];
        SearchTypeModel *model = _dataArr[indexPath.row];

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

    }else if ([_type isEqualToString:@"4"]){
        _searchView.hidden = YES;
        
        [_searchTextField resignFirstResponder];

        TransactionRecordViewController *transactionRecordVC = [[UIStoryboard storyboardWithName:@"Share" bundle:nil] instantiateViewControllerWithIdentifier:@"TransactionRecordViewController"];
        SearchTypeModel *model = _dataArr[indexPath.row];
        transactionRecordVC.sales_id = model.sales_id;
        transactionRecordVC.arr = _selectArr;
        [self.navigationController pushViewController:transactionRecordVC animated:YES];
    }
}


//取消按钮
- (void)cancelAction{
    
    _searchView.hidden = YES;
    
    [_searchTextField resignFirstResponder];

    _searchTextField.placeholder = @"搜索";
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    page = 1;
    [_dataArr removeAllObjects];
    [textField resignFirstResponder];
    
    [self loadData];
    return YES;
}


- (void)loadData{
    
    serhImageV.hidden = YES;
    serhLabel.hidden = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
    [params setObject:_searchTextField.text forKey:@"keyword"];
    NSString *url = @"";
    
    if ([_type isEqualToString:@"1"]) {
        url = consighment_searchhtml;
        
    }else if ([_type isEqualToString:@"2"]){
        url = paylog_searchhtml;
    }else if ([_type isEqualToString:@"3"]){
        url = goods_searchhtml;
        
        [params setObject:firstStr forKey:@"start_time"];
        [params setObject:lastStr forKey:@"end_time"];

    }else if ([_type isEqualToString:@"4"]){
        url = sales_searchhtml;
    }
    
    [DataSeviece requestUrl:url params:params success:^(id result) {
        
        NSLog(@"%@",result[@"result"]);

        if (page == 1) {
            
            [_dataArr removeAllObjects];
            
        }
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            NSDictionary *dic1 = [NULLHandle NUllHandle:dic];
            
            SearchTypeModel *model = [[SearchTypeModel alloc]initWithContentsOfDic:dic1];
            model.typeId = dic1[@"id"];
            [_dataArr addObject:model];
        }
        [myTableView reloadData];
        [myTableView.header endRefreshing];
        [myTableView.footer endRefreshing];
        
//        NSArray *data = result[@"result"][@"data"][@"item"];
        
        if (_dataArr.count == 0) {
            serhImageV.hidden = NO;
            serhLabel.hidden = NO;
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [myTableView.header endRefreshing];
        [myTableView.footer endRefreshing];
    }];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏背景.png"] forBarMetrics:UIBarMetricsDefault];

    _searchView.hidden = NO;
}

@end
