//
//  ExistingInventoryViewController.m
//  奢易购3.0
//
//  Created by Andy on 16/10/9.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "ExistingInventoryViewController.h"
#import "SearchTypeViewController.h"
#import "StockModel.h"
#import "ExistingInventoryCell.h"
#import "ExistingInventoryCollectionViewCell.h"
#import "StockDetailsViewController.h"
#import "MerchandiseViewController.h"
#import "MJRefresh.h"


@interface ExistingInventoryViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>{

    UIButton *rightBtn;
    
    NSInteger page;
    
    
    NSString *sort;
    
    NSString *category;
    
    UIView *bgV;
    
    UITableView *leftTableView;
    UITableView *rightTableView;
    
    UIButton *rightButton;
    UIButton *leftButton;
    
}

@property (nonatomic,strong) UITableView *myTableView;

@property (nonatomic,strong) UICollectionView *myCollectionView;


@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation ExistingInventoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EditNotification) name:@"EditNotification" object:nil];
    
    _dataArr = [NSMutableArray array];
    
    page = 1;
    
    sort = @"desc";
    
    category = @"";
    
    [self loadData];

    self.navigationItem.title = @"现有库存";


    
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
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    
    //右边Item
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 22, 22);
    [rightBtn setImage:[UIImage imageNamed:@"搜索按钮（44x44）1"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    
    bgView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:bgView];
    
    
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    leftButton.frame = CGRectMake(kScreenWidth/6 - 39, 2, 78, 26);
    
    [leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [bgView addSubview:leftButton];
    
    UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 40, 26)];
    
    leftLabel.text = @"排序";
    
    leftLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
    
    leftLabel.font = [UIFont systemFontOfSize:15];
    
    [leftButton addSubview:leftLabel];
    
    UIImageView *leftImageV = [[UIImageView alloc]initWithFrame:CGRectMake(78 - 10 - 14, 9, 14, 8)];
    leftImageV.image = [UIImage imageNamed:@"下拉箭头"];
    
    [leftButton addSubview:leftImageV];
    
    
    rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightButton.frame = CGRectMake(kScreenWidth/6 - 39 +kScreenWidth/3*2, 2, 78, 26);
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:rightButton];
    
    UILabel *rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 40, 26)];
    
    rightLabel.text = @"筛选";
    
    rightLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
    
    rightLabel.font = [UIFont systemFontOfSize:15];
    
    [rightButton addSubview:rightLabel];
    
    UIImageView *rightImageV = [[UIImageView alloc]initWithFrame:CGRectMake(78 - 10 - 14, 9, 14, 8)];
    rightImageV.image = [UIImage imageNamed:@"下拉箭头"];
    
    [rightButton addSubview:rightImageV];
    
    
    
    UIButton *centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    centerButton.frame = CGRectMake(kScreenWidth/2 - 39, 2, 78, 26);
    
    [centerButton setTitle:@"相册模式" forState:UIControlStateNormal];
    
    [centerButton setTitleColor:[RGBColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    
    centerButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [centerButton addTarget:self action:@selector(centerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:centerButton];
    
    centerButton.layer.masksToBounds = YES;
    centerButton.layer.cornerRadius = 5;
    centerButton.layer.borderWidth = 1;
    centerButton.layer.borderColor = [RGBColor colorWithHexString:@"#787fc6"].CGColor;
    
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight - 64 - 40) style:UITableViewStylePlain];
    
    _myTableView.delegate = self;
    
    _myTableView.dataSource = self;
    _myTableView.hidden = YES;
    [self.view addSubview:_myTableView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    flowLayout.itemSize = CGSizeMake((kScreenWidth - 50)/3, (kScreenWidth- 50)/3/112*170);
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(10,10,10,10);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight - 40 - 64) collectionViewLayout:flowLayout];
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
    _myCollectionView.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    [self.view addSubview:_myCollectionView];
    
    [_myTableView registerNib:[UINib nibWithNibName:@"ExistingInventoryCell" bundle:nil] forCellReuseIdentifier:@"ExistingInventoryCell"];
    
    [_myCollectionView registerNib:[UINib nibWithNibName:@"ExistingInventoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ExistingInventoryCollectionViewCell"];
    
    
    __weak ExistingInventoryViewController *weakSelf = self;

    
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

    //下拉刷新
    
    _myCollectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        page = 1;
        
        [weakSelf loadData];
        
    }];
    //上拉加载
    
    _myCollectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        
        page++;
        
        [weakSelf loadData];
        
    }];
    
    
    
    bgV = [[UIView alloc]initWithFrame:CGRectMake(0, 94, kScreenWidth, kScreenHeight - 94)];
    
    bgV.backgroundColor = [RGBColor colorWithHexString:@"#2d2d2d"];
    bgV.alpha = .4;
    bgV.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:bgV];
    
    UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bgButton.frame = bgView.frame;
    [bgButton addTarget:self action:@selector(bgButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [bgV addSubview:bgButton];
    

    
    leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 94, 150, 39*2)];
    leftTableView.backgroundColor = [UIColor whiteColor];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    leftTableView.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:leftTableView];
    
    rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth/3*2, 94, kScreenWidth/3, 39*6)];
    rightTableView.backgroundColor = [UIColor whiteColor];
    rightTableView.delegate = self;
    rightTableView.dataSource = self;
    rightTableView.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:rightTableView];

    
}

- (void)bgButtonAction{
    bgV.hidden = YES;
    leftTableView.hidden = YES;
    rightTableView.hidden = YES;
    
    leftButton.selected = NO;
    rightButton.selected = NO;

}

//左边选择
- (void)leftButtonAction:(UIButton*)bt{

    rightTableView.hidden = YES;
    rightButton.selected = NO;

    
    bt.selected = !bt.selected;
    
    if (bt.selected) {
        
        bgV.hidden = NO;
        leftTableView.hidden = NO;
        
    }else{
        
        bgV.hidden = YES;
        leftTableView.hidden = YES;
        
    }

}


//右边选择
- (void)rightButtonAction:(UIButton*)bt{

    leftTableView.hidden = YES;
    leftButton.selected = NO;
    
    bt.selected = !bt.selected;

    if (bt.selected) {
        
        bgV.hidden = NO;
        rightTableView.hidden = NO;
        
    }else{
        
        bgV.hidden = YES;
        rightTableView.hidden = YES;

    }
}

//模式切换
- (void)centerButtonAction:(UIButton*)bt{
    
    bgV.hidden = YES;
    leftTableView.hidden = YES;
    rightTableView.hidden = YES;
    leftButton.selected = NO;
    rightButton.selected = NO;
    
    bt.selected = !bt.selected;
    
    if (bt.selected) {
        _myCollectionView.hidden = YES;
        _myTableView.hidden = NO;
        
        [bt setTitle:@"列表模式" forState:UIControlStateNormal];
    }else{
        
        _myCollectionView.hidden = NO;
        _myTableView.hidden = YES;
        
        [bt setTitle:@"相册模式" forState:UIControlStateNormal];

    }
    

}

//加载数据
- (void)loadData{

    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];

    [params setObject:sort forKey:@"sort"];
    
    [params setObject:category forKey:@"category"];
    
    //列表数据
    [DataSeviece requestUrl:get_goods_listhtml params:params success:^(id result) {
        NSLog(@"%@",result);
        
        
        if (page == 1) {
            [_dataArr removeAllObjects];
        }
        
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            NSDictionary *dic1 = [NULLHandle NUllHandle:dic];
            StockModel *model = [[StockModel alloc]initWithContentsOfDic:dic1];
            model.SPID = dic1[@"id"];
            [_dataArr addObject:model];
            
        }
        [_myCollectionView reloadData];
        [_myTableView reloadData];

        [_myCollectionView.header endRefreshing];
        [_myCollectionView.footer endRefreshing];
        [_myTableView.header endRefreshing];
        [_myTableView.footer endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [_myCollectionView.header endRefreshing];
        [_myCollectionView.footer endRefreshing];
        [_myTableView.header endRefreshing];
        [_myTableView.footer endRefreshing];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (tableView == _myTableView) {
        return _dataArr.count;
    }else if (tableView == leftTableView){
        return 2;
    }else if (tableView == rightTableView){
        return 6;
    }
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == _myTableView) {
        ExistingInventoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExistingInventoryCell" forIndexPath:indexPath];
        
        cell.model = _dataArr[indexPath.row];
        return cell;
   
    }else if (tableView == leftTableView){
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftTableViewCell"];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftTableViewCell"];
            cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);

        }
        cell.textLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
        cell.textLabel.font = [UIFont systemFontOfSize:15];

        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"时间从晚到早";
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"时间从早到晚";
        }
        
        if ([sort isEqualToString:@"desc"]) {
            if (indexPath.row == 1) {
                cell.tintColor = [RGBColor colorWithHexString:@"#787fc6"];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }else{
            if (indexPath.row == 0) {
                cell.tintColor = [RGBColor colorWithHexString:@"#787fc6"];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
                
            }

        }
        
        return cell;
    }else if (tableView == rightTableView){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightTableViewCell"];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rightTableViewCell"];
            cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);

        }
//        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        NSArray *titleArr = @[@"全部",@"腕表",@"首饰",@"服饰",@"箱包",@"其他"];
        cell.textLabel.text = titleArr[indexPath.row];
        
        if ([category isEqualToString:@""]) {
            if (indexPath.row == 0) {
                cell.tintColor = [RGBColor colorWithHexString:@"#787fc6"];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }else if ([category isEqualToString:@"1"]){
            if (indexPath.row == 1) {
                cell.tintColor = [RGBColor colorWithHexString:@"#787fc6"];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }else if ([category isEqualToString:@"2"]){
            if (indexPath.row == 2) {
                cell.tintColor = [RGBColor colorWithHexString:@"#787fc6"];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }else if ([category isEqualToString:@"3"]){
            if (indexPath.row == 3) {
                cell.tintColor = [RGBColor colorWithHexString:@"#787fc6"];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }else if ([category isEqualToString:@"4"]){
            if (indexPath.row == 4) {
                cell.tintColor = [RGBColor colorWithHexString:@"#787fc6"];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }else if ([category isEqualToString:@"13"]){
            if (indexPath.row == 5) {
                cell.tintColor = [RGBColor colorWithHexString:@"#787fc6"];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }



        
        return cell;
    
    }
    
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == _myTableView) {
        return 74;
    }else{
    
        return 39;
    }
    
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    ExistingInventoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ExistingInventoryCollectionViewCell" forIndexPath:indexPath];
    cell.model = _dataArr[indexPath.item];
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    cell.contentView.layer.cornerRadius = 5;
    cell.contentView.layer.masksToBounds = YES;
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (tableView == _myTableView) {
        
        StockModel *model = _dataArr[indexPath.row];
        
        if ([model.type isEqualToString:@"HS"]) {
            StockDetailsViewController *stockDetailVC = [[UIStoryboard storyboardWithName:@"Share" bundle:nil] instantiateViewControllerWithIdentifier:@"StockDetailsViewController"];
            stockDetailVC.isType = @"1";
            stockDetailVC.SPID = model.SPID;
            stockDetailVC.isSearch = YES;

            [self.navigationController pushViewController:stockDetailVC animated:YES];
            
        }else{
            MerchandiseViewController *merchandiseVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"MerchandiseViewController"];
            merchandiseVC.status = @"1";
            merchandiseVC.isSearch = YES;

            merchandiseVC.merchandiseId = model.consighment_id;
            [self.navigationController pushViewController:merchandiseVC animated:YES];
            
        }

    }else if (tableView == leftTableView){
    
        leftButton.selected = NO;
        if (indexPath.row == 0) {
            sort = @"asc";
            [tableView reloadData];
            page = 1;
            [self loadData];
            bgV.hidden = YES;
            leftTableView.hidden = YES;
            
        }else{
            sort = @"desc";
            [tableView reloadData];
            page = 1;
            [self loadData];
            bgV.hidden = YES;
            leftTableView.hidden = YES;
        }
    
    }else if (tableView == rightTableView){
        
        rightButton.selected = NO;
        
        if (indexPath.row == 0) {
            category = @"";
            [tableView reloadData];
            page = 1;
            [self loadData];
            bgV.hidden = YES;
            rightTableView.hidden = YES;
            
        }else if(indexPath.row == 1){
            category = @"1";
            [tableView reloadData];
            page = 1;
            [self loadData];
            bgV.hidden = YES;
            rightTableView.hidden = YES;
        }else if(indexPath.row == 2){
            category = @"2";
            [tableView reloadData];
            page = 1;
            [self loadData];
            bgV.hidden = YES;
            rightTableView.hidden = YES;
        }else if(indexPath.row == 3){
            category = @"3";
            [tableView reloadData];
            page = 1;
            [self loadData];
            bgV.hidden = YES;
            rightTableView.hidden = YES;
        }else if(indexPath.row == 4){
            category = @"4";
            [tableView reloadData];
            page = 1;
            [self loadData];
            bgV.hidden = YES;
            rightTableView.hidden = YES;
        }else if(indexPath.row == 5){
            category = @"13";
            [tableView reloadData];
            page = 1;
            [self loadData];
            bgV.hidden = YES;
            rightTableView.hidden = YES;
        }

    }
    

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StockModel *model = _dataArr[indexPath.item];
    
    if ([model.type isEqualToString:@"HS"]) {
        StockDetailsViewController *stockDetailVC = [[UIStoryboard storyboardWithName:@"Share" bundle:nil] instantiateViewControllerWithIdentifier:@"StockDetailsViewController"];
        stockDetailVC.isType = @"1";
        stockDetailVC.SPID = model.SPID;
        stockDetailVC.isSearch = YES;
        [self.navigationController pushViewController:stockDetailVC animated:YES];
        
    }else{
        MerchandiseViewController *merchandiseVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"MerchandiseViewController"];
        merchandiseVC.status = @"1";
        merchandiseVC.isSearch = YES;
        merchandiseVC.merchandiseId = model.consighment_id;
        [self.navigationController pushViewController:merchandiseVC animated:YES];
        
    }

}



//左边返回按钮
- (void)leftBtnAction{
    
    bgV.hidden = YES;
    bgV = nil;
    leftTableView.hidden = YES;
    leftTableView = nil;
    rightTableView.hidden = YES;
    rightTableView = nil;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackNotification" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)rightBtnAction{

    bgV.hidden = YES;
//    bgV = nil;
    leftTableView.hidden = YES;
//    leftTableView = nil;
    rightTableView.hidden = YES;
//    rightTableView = nil;
    
    SearchTypeViewController *searchTypeVC = [[SearchTypeViewController alloc]init];
    searchTypeVC.selectArr = _selectArr;
    searchTypeVC.type = @"3";
    
    [self.navigationController pushViewController:searchTypeVC animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏背景.png"] forBarMetrics:UIBarMetricsDefault];
    
  

    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)EditNotification{
    
    [_dataArr removeAllObjects];
    
    page = 1;
    
    [self loadData];

    
}


@end
