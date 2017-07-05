//
//  HomeViewController.m
//  奢易购3.0
//
//  Created by guest on 16/7/19.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "HomeCell.h"
#import "StockCell.h"
#import "StockDetailsViewController.h"
#import "SalesRecordsCell.h"
#import "TransactionRecordViewController.h"
#import "BooksTableViewCell.h"
#import "PaymentCollectionViewController.h"
#import "StorageViewController.h"
#import "ConsignmentViewController.h"
#import "ConsignmentCell.h"
#import "MerchandiseViewController.h"
#import "SearchViewController.h"
#import "PendingPaymentViewController.h"
#import "ManagementViewController.h"
#import "StockModel.h"
#import "SalesRecordsModel.h"
#import "MJRefresh.h"
#import "BooksModel.h"
#import "consignmentModel.h"
#import "HomeModel.h"
#import "StorageView.h"
#import "QRCodeViewController.h"
#import "BooksDetailsViewController.h"
#import "PaymentTwoViewController.h"
#import "ExistingInventoryViewController.h"


@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{

    UIButton *leftBtn;
    UIButton *rightBtn;
    UIButton *sectorButton;
    //    BOOL 数组   用于判断本组的闭合状态
    BOOL flag[100];
    BOOL flag1[100];
    
    NSArray *selectArr;
    NSString *stockType;
    NSString *group;
    NSString *status;
//    NSString *stockPage;
    
    //库存翻页数
    NSInteger stockPage1;
    NSInteger stockPage2;
    NSInteger stockPage3;
    //销售记录翻页数
    NSInteger salesRecordsPage;
    //账本翻页数
    NSInteger booksPage;
    //寄卖管理翻页数
    NSInteger consignmentPage1;
    NSInteger consignmentPage2;
    NSInteger consignmentPage3;
    NSInteger consignmentPage4;
    NSInteger consignmentPage5;
    NSInteger consignmentPage6;
    NSInteger consignmentPage7;
    NSInteger consignmentPage8;
    //首页翻页数
    NSInteger homePage1;
    NSInteger homePage2;
    NSInteger homePage3;

    NSInteger homeType;
    UITextField *searchTextField;
    
    UIView *bgView;
    UIView *bgView1;

    UIButton *recoveryButton;
    UIButton *consignmentButton;
    UIButton *cashierButton;
    
    UIButton *right2;
}



@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong) UITableView *stockTableView;
@property (nonatomic,strong) UITableView *salesRecordsTableView;
@property (nonatomic,strong) UITableView *booksTableView;
@property (nonatomic,strong) UITableView *consignmentTableView;
//时间选择
@property (nonatomic,strong) UITableView *timeSelectTableView;
@property (nonatomic,strong) NSMutableArray *timeSelectArr;

//库存数据
@property (nonatomic,strong) NSArray *storkDataArr;
@property (nonatomic,strong) NSMutableArray *storkDataArr1;
@property (nonatomic,strong) NSMutableArray *storkDataArr2;
@property (nonatomic,strong) NSMutableArray *storkDataArr3;
//销售数据
@property (nonatomic,strong) NSMutableArray *salesRecordsArr;
//账本数据
@property (nonatomic,strong) NSMutableArray *booksArr;

@property (nonatomic,strong) NSDictionary *booksDic;

//寄卖管理数据
@property (nonatomic,strong) NSArray *consignmentArr;
@property (nonatomic,strong) NSMutableArray *consignmentArr1;
@property (nonatomic,strong) NSMutableArray *consignmentArr2;
@property (nonatomic,strong) NSMutableArray *consignmentArr3;
@property (nonatomic,strong) NSMutableArray *consignmentArr4;
@property (nonatomic,strong) NSMutableArray *consignmentArr5;
@property (nonatomic,strong) NSMutableArray *consignmentArr6;
@property (nonatomic,strong) NSMutableArray *consignmentArr7;
@property (nonatomic,strong) NSMutableArray *consignmentArr8;
//首页数据
@property (nonatomic,strong) NSArray *homeArr;
@property (nonatomic,strong) NSMutableArray *homeArr1;
@property (nonatomic,strong) NSMutableArray *homeArr2;
@property (nonatomic,strong) NSMutableArray *homeArr3;


@property (nonatomic,strong) UIButton *selectButton;
@property (nonatomic,strong) UIImageView *selectImageV;
@property (nonatomic,strong) UIButton *selectButton1;
@property (nonatomic,strong) UIImageView *selectImageV1;
@property (nonatomic,strong) UIButton *selectButton2;
@property (nonatomic,strong) UIImageView *selectImageV2;
@property (nonatomic,strong) UIButton *selectButton3;
@property (nonatomic,strong) UIImageView *selectImageV3;

//首页视图
@property (nonatomic,strong) UIView *homeView;
//库存视图
@property (nonatomic,strong) UIView *stockView;
//销售记录
@property (nonatomic,strong) UIView *salesRecordsView;
//账本
@property (nonatomic,strong) UIView *booksView;
//寄卖情况
@property (nonatomic,strong) UIView *consignmentView;



@end

@implementation HomeViewController


- (instancetype)init{

    if (self = [super init]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PresentAction) name:@"PresentNotification" object:nil];
 
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self selectTypeLoadData];

    _storkDataArr1 = [NSMutableArray array];
    _storkDataArr2 = [NSMutableArray array];
    _storkDataArr3 = [NSMutableArray array];
    _booksArr = [NSMutableArray array];
    stockType = @"";
    group = @"time";
    status = @"1";
    stockPage1 = 1;
    stockPage3 = 1;
    stockPage2 = 1;
    salesRecordsPage = 1;
    booksPage = 1;
    _salesRecordsArr = [NSMutableArray array];
    _timeSelectArr = [NSMutableArray array];
    
    consignmentPage1 = 1;
    consignmentPage2 = 1;
    consignmentPage3 = 1;
    consignmentPage4 = 1;
    consignmentPage5 = 1;
    consignmentPage6 = 1;
    consignmentPage7 = 1;
    consignmentPage8 = 1;
    
    _consignmentArr1 = [NSMutableArray array];
    _consignmentArr2 = [NSMutableArray array];
    _consignmentArr3 = [NSMutableArray array];
    _consignmentArr4 = [NSMutableArray array];
    _consignmentArr5 = [NSMutableArray array];
    _consignmentArr6 = [NSMutableArray array];
    _consignmentArr7 = [NSMutableArray array];
    _consignmentArr8 = [NSMutableArray array];

    homePage1 = 1;
    homePage2 = 1;
    homePage3 = 1;
    homeType = 1;
    _homeArr1 = [NSMutableArray array];
    _homeArr2 = [NSMutableArray array];
    _homeArr3 = [NSMutableArray array];

    //接收通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(StockAction) name:@"StockNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HomeAction) name:@"HomeNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(salesRecordsAction) name:@"SalesRecordsNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BooksAction) name:@"BooksNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ConsignmentAction) name:@"ConsignmentNotification" object:nil];
    
    //返回通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BackNotificationAction) name:@"BackNotification" object:nil];
    
    
    //去掉导航栏下面的线
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    
    //左边Item
    leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 22, 15);
    [leftBtn setImage:[UIImage imageNamed:@"侧滑按钮（44x30）"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //右边Item
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 22, 22);
    [rightBtn setImage:[UIImage imageNamed:@"搜索按钮（44x44）1"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;

    
    //首页视图
    _homeView = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_homeView];
    _stockView = [[UIView alloc]initWithFrame:self.view.bounds];
    _stockView.hidden = YES;
    [self.view addSubview:_stockView];
    _salesRecordsView = [[UIView alloc]initWithFrame:self.view.bounds];
    _salesRecordsView.hidden = YES;
    [self.view addSubview:_salesRecordsView];
    _booksView = [[UIView alloc]initWithFrame:self.view.bounds];
    _booksView.hidden = YES;
    [self.view addSubview:_booksView];
    
    _consignmentView = [[UIView alloc]initWithFrame:self.view.bounds];
    _consignmentView.hidden = YES;
    [self.view addSubview:_consignmentView];
    
    
    //首页
    [self creatHomeView];
    //库存
    [self creatStockView];
    //销售记录
    [self creatSalesRecordsView];
    //账本
    [self creatBooksView];
    //寄卖管理
    [self creatConsignmentView];
    
    //时间选择
    
    _timeSelectTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 322-84+35+35, kScreenWidth/2, 200) style:UITableViewStylePlain];
    _timeSelectTableView.delegate = self;
    _timeSelectTableView.dataSource = self;
    _timeSelectTableView.hidden = YES;
    [self.view addSubview:_timeSelectTableView];
    
    
    //遮罩视图
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgView.backgroundColor = [RGBColor colorWithHexString:@"#2d2d2d"];
    bgView.alpha = .4;
    bgView.hidden = YES;
    [self.view addSubview:bgView];
    
    UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bgButton.frame = bgView.frame;
    [bgButton addTarget:self action:@selector(bgButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:bgButton];
    
    
    bgView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    bgView1.backgroundColor = [RGBColor colorWithHexString:@"#2d2d2d"];
    bgView1.alpha = .4;
    bgView1.hidden = YES;
    [self.navigationController.view addSubview:bgView1];

    
    //扇形按钮
    
    sectorButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sectorButton.frame = CGRectMake(28, 496-667+kScreenHeight, 65, 65);
    [sectorButton setImage:[UIImage imageNamed:@"更多初始（130x130）.png"] forState:UIControlStateNormal];
    [sectorButton setImage:[UIImage imageNamed:@"更多点击（130x130）.png"] forState:UIControlStateSelected];
    [sectorButton addTarget:self action:@selector(sectorButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sectorButton];
    
    cashierButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cashierButton.tag = 150;
    cashierButton.hidden = YES;
    cashierButton.frame = CGRectMake(51, 433-667+kScreenHeight, 65, 65);
    [cashierButton setImage:[UIImage imageNamed:@"收银台3.jpg"] forState:UIControlStateNormal];
    //    [cashierButton setImage:[UIImage imageNamed:@"收银台点击.png"] forState:UIControlStateHighlighted];
    [cashierButton addTarget:self action:@selector(cashierButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cashierButton];
    
    consignmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    consignmentButton.tag = 151;
    consignmentButton.hidden = YES;
    consignmentButton.frame = CGRectMake(101, 481-667+kScreenHeight, 65, 65);
    [consignmentButton setImage:[UIImage imageNamed:@"寄卖3.jpg"] forState:UIControlStateNormal];
    //    [consignmentButton setImage:[UIImage imageNamed:@"寄卖点击.png"] forState:UIControlStateHighlighted];
    [consignmentButton addTarget:self action:@selector(consignmentButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:consignmentButton];
    
    recoveryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    recoveryButton.tag = 152;
    recoveryButton.hidden = YES;
    recoveryButton.frame = CGRectMake(66, 546-667+kScreenHeight, 65, 65);
    [recoveryButton setImage:[UIImage imageNamed:@"回收3.jpg"] forState:UIControlStateNormal];
    [recoveryButton addTarget:self action:@selector(recoveryButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:recoveryButton];
    
//    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
//    {
//        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
//    }
//    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
//    {
//        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
//    }
    
    
}

//点击背景
- (void)bgButtonAction{

    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModePanningCenterView];
    
    bgView.hidden = YES;
    recoveryButton.hidden = YES;
    bgView.hidden = YES;
    bgView1.hidden = YES;
    consignmentButton.hidden = YES;
    cashierButton.hidden = YES;
    sectorButton.selected =!sectorButton.selected;
    
}


- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    sectorButton.selected = NO;
    recoveryButton.hidden = YES;
    bgView1.hidden = YES;
    bgView.hidden = YES;
    consignmentButton.hidden = YES;
    cashierButton.hidden = YES;

}

//展开扇形按钮
- (void)sectorButtonAction:(UIButton*)bt{

    bt.selected = !bt.selected;
    
        if (bt.selected) {
            
            recoveryButton.hidden = NO;
            bgView.hidden = NO;
            bgView1.hidden = NO;
            consignmentButton.hidden = NO;
            cashierButton.hidden = NO;
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
            
        }else{
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModePanningCenterView];
            recoveryButton.hidden = YES;
            bgView.hidden = YES;
            bgView1.hidden = YES;
            consignmentButton.hidden = YES;
            cashierButton.hidden = YES;

        }
    
}

//收银台按钮
- (void)cashierButtonAction{
    
//    PaymentCollectionViewController *paymentCollectionVC = [[PaymentCollectionViewController alloc]init];
//    
//    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    
//    [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
//    
//    [self.navigationController pushViewController:paymentCollectionVC animated:YES];
//
    
    PaymentTwoViewController *paymentCollectionVC = [[PaymentTwoViewController alloc]init];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    paymentCollectionVC.isSF = @"SK";
    
    [self.navigationController pushViewController:paymentCollectionVC animated:YES];
        
}

//回收按钮
- (void)recoveryButtonAction{

    StorageViewController *storageVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"StorageViewController"];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    
    [self.navigationController pushViewController:storageVC animated:YES];

}

//寄卖按钮
- (void)consignmentButtonAction{
    
    ConsignmentViewController *consignmentVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"ConsignmentViewController"];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    
    [self.navigationController pushViewController:consignmentVC animated:YES];

}


//首页

- (void)creatHomeView{

    //设置标题
    self.navigationItem.title = @"奢侈品店";
    
    //改变导航栏标题的字体颜色和大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏背景.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"导航栏背景.png"]];
    

    //扫码按钮
    
    UIButton *scanCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    scanCodeButton.frame = CGRectMake(kScreenWidth/2-50, 35, 100, 100);
    [scanCodeButton setImage:[UIImage imageNamed:@"扫码按钮（200x200）"] forState:UIControlStateNormal];
    [scanCodeButton addTarget:self action:@selector(scanCodeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_homeView addSubview:scanCodeButton];
    
    UILabel *scanCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-30, scanCodeButton.bottom+23, 60, 30)];
    scanCodeLabel.text = @"扫码";
    scanCodeLabel.textColor = [RGBColor colorWithHexString:@"#ffffff"];
    scanCodeLabel.font = [UIFont systemFontOfSize:23];
    scanCodeLabel.textAlignment = NSTextAlignmentCenter;
    [_homeView addSubview:scanCodeLabel];
    
    //查找货码
    
    searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, scanCodeLabel.bottom+23, kScreenWidth-75, 35)];
    searchTextField.backgroundColor = [UIColor whiteColor];
    searchTextField.delegate = self;
    searchTextField.placeholder = @"输入货码";
    searchTextField.font = [UIFont systemFontOfSize:14];
    searchTextField.textColor = [RGBColor colorWithHexString:@"#333333"];
    searchTextField.layer.cornerRadius = 5;
    searchTextField.layer.masksToBounds = YES;
    searchTextField.tag = 888;
    [_homeView addSubview:searchTextField];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(searchTextField.right+6, searchTextField.top, 49, 35);
    [searchButton setImage:[UIImage imageNamed:@"查找按钮（98x70）"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_homeView addSubview:searchButton];
    
    //下面的示图
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, searchButton.bottom+22, kScreenWidth, kScreenHeight - searchButton.bottom-22)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [_homeView addSubview:bottomView];
    
    NSArray *titleArr = @[@"待收款",@"回收待付款",@"寄卖待结款"];
    
    _selectImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 21)];
    _selectImageV.image = [UIImage imageNamed:@"选择栏选中（104x42）.png"];
    [bottomView addSubview:_selectImageV];
    for (int i = 0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 500+i;
        button.frame = CGRectMake(kScreenWidth/3*i, 0, kScreenWidth/3, 35);
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[RGBColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:button];
        
        if (i==0) {
            button.selected = YES;
            _selectButton = button;
            _selectImageV.center = _selectButton.center;
        }
    }
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 34, kScreenWidth, 1)];
    lineView.backgroundColor = [RGBColor colorWithHexString:@"#999999"];
    [bottomView addSubview:lineView];
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 35, kScreenWidth, bottomView.height-35-64) style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [bottomView addSubview:_myTableView];
    
    [_myTableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:@"HomeCell"];


    [self HomeAction];
    
    __weak HomeViewController *weakSelf = self;
    
    //下拉刷新
    
    _myTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if (homeType == 1) {
            homePage1 = 1;
        }else if (homeType == 2){
            homePage2 = 1;
        }else{
            homePage3 = 1;
        }
        
        [weakSelf homeLoadData];
        
    }];
    //上拉加载
    
    _myTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if (homeType == 1) {
            homePage1 ++;
            
        }else if (homeType == 2){
            homePage2 ++;
            
        }else{
            
            homePage3 ++;
            
        }
        [weakSelf homeLoadData];
        
        
    }];

    
}

//库存

- (void)creatStockView{

    
    UILabel *numLabel1= [[UILabel alloc]initWithFrame:CGRectMake(0, 27, kScreenWidth/2, 40)];
    numLabel1.textAlignment = NSTextAlignmentCenter;
    numLabel1.text = @"7件";
    numLabel1.textColor = [RGBColor colorWithHexString:@"#ffc000"];
    numLabel1.font = [UIFont systemFontOfSize:29];
    numLabel1.tag = 6001;
    [_stockView addSubview:numLabel1];
    
    UILabel *numLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, 27, kScreenWidth/2, 40)];
    numLabel2.textAlignment = NSTextAlignmentCenter;
    numLabel2.text = @"21件";
    numLabel2.textColor = [RGBColor colorWithHexString:@"#ffc000"];
    numLabel2.font = [UIFont systemFontOfSize:29];
    numLabel2.tag = 6002;

    [_stockView addSubview:numLabel2];

    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/4 - 75, numLabel1.bottom+21, 75, 20)];
    label1.textAlignment = NSTextAlignmentRight;
    label1.text = @"今日入库";
    label1.textColor = [RGBColor colorWithHexString:@"434b9b"];
    label1.font = [UIFont systemFontOfSize:16];
    [_stockView addSubview:label1];
    
    UIImageView *imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/4+5, label1.top, 15, 21)];
    imageV1.image = [UIImage imageNamed:@"上涨（30x42）.png"];
    imageV1.tag = 6007;
    [_stockView addSubview:imageV1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(imageV1.right+5, label1.top, 60, 20)];
    label2.text = @"100%";
    label2.textColor = [RGBColor colorWithHexString:@"#ffc000"];
    label2.font = [UIFont systemFontOfSize:14];
    label2.tag = 6003;
    [_stockView addSubview:label2];
    
    
    UIView *line1View = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-1)/2, numLabel1.bottom, 1, 17)];
    line1View.backgroundColor = [RGBColor colorWithHexString:@"bac0fa"];
    [_stockView addSubview:line1View];

    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/4*3 - 75, numLabel1.bottom+21, 75, 20)];
    label3.textAlignment = NSTextAlignmentRight;
    label3.text = @"今日出库";
    label3.textColor = [RGBColor colorWithHexString:@"434b9b"];
    label3.font = [UIFont systemFontOfSize:16];
    [_stockView addSubview:label3];
    
    UIImageView *imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/4*3+5, label3.top, 15, 21)];
    imageV2.image = [UIImage imageNamed:@"下跌（30x42）.png"];
    imageV2.tag = 6008;
    [_stockView addSubview:imageV2];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(imageV2.right+5, label1.top, 60, 20)];
    label4.text = @"50%";
    label4.textColor = [RGBColor colorWithHexString:@"#0071b8"];
    label4.font = [UIFont systemFontOfSize:14];
    label4.tag = 6004;
    [_stockView addSubview:label4];

    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(30, label4.bottom+39, kScreenWidth-60, 1)];
    lineView.backgroundColor = [RGBColor colorWithHexString:@"bac0fa"];
    [_stockView addSubview:lineView];
    
    UIButton *existingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    existingButton.frame = CGRectMake(0, lineView.bottom, kScreenWidth/2, 100);
    
    [existingButton addTarget:self action:@selector(existingButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_stockView addSubview:existingButton];
    
    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(0, lineView.bottom+31, kScreenWidth/2, 20)];
    label5.textAlignment = NSTextAlignmentCenter;
    label5.text = @"1299件";
    label5.textColor = [RGBColor colorWithHexString:@"434b9b"];
    label5.font = [UIFont systemFontOfSize:15];
    label5.tag = 6005;
    [_stockView addSubview:label5];

    UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, lineView.bottom+31, kScreenWidth/2, 20)];
    label6.textAlignment = NSTextAlignmentCenter;
    label6.text = @"104.21万";
    label6.textColor = [RGBColor colorWithHexString:@"#434b9b"];
    label6.tag = 6006;
    label6.font = [UIFont systemFontOfSize:15];
    [_stockView addSubview:label6];
    
    UILabel *label7 = [[UILabel alloc]initWithFrame:CGRectMake(0, label5.bottom+9, kScreenWidth/2, 20)];
    label7.textAlignment = NSTextAlignmentCenter;
    label7.text = @"共有现货";
    label7.textColor = [RGBColor colorWithHexString:@"434b9b"];
    label7.font = [UIFont systemFontOfSize:15];
    [_stockView addSubview:label7];

    UILabel *label8 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, label5.bottom+9, kScreenWidth/2, 20)];
    label8.textAlignment = NSTextAlignmentCenter;
    label8.text = @"总进价";
    label8.textColor = [RGBColor colorWithHexString:@"#434b9b"];
    label8.font = [UIFont systemFontOfSize:15];
    [_stockView addSubview:label8];

    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(line1View.left, label5.bottom, 1, 17)];
    lineView2.backgroundColor = [RGBColor colorWithHexString:@"bac0fa"];
    [_stockView addSubview:lineView2];

    //下面的示图
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 322-84+35, kScreenWidth, kScreenHeight-322+84-35)];
    bottomView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"导航栏背景"]];
    [_stockView addSubview:bottomView];
    
    NSArray *titleArr = @[@"全部",@"回收",@"寄卖"];
    
    _selectImageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 21)];
    _selectImageV1.image = [UIImage imageNamed:@"选择烂选中框.png"];
    [bottomView addSubview:_selectImageV1];
    
    for (int i = 0; i<3; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 600+i;
        button.frame = CGRectMake(kScreenWidth/3*i, 0, kScreenWidth/3, 35);
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[RGBColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        [button setTitleColor:[RGBColor colorWithHexString:@"#787fc6"] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(buttonAction1:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:button];
        
        if (i==0) {
            button.selected = YES;
            _selectButton1 = button;
            _selectImageV1.center = _selectButton1.center;
        }
    }
    UIView *line2View = [[UIView alloc]initWithFrame:CGRectMake(0, 34, kScreenWidth, 1)];
    line2View.backgroundColor = [RGBColor colorWithHexString:@"#999999"];
    [bottomView addSubview:line2View];
    
    _stockTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 35, kScreenWidth, bottomView.height-35-64) style:UITableViewStyleGrouped];
    _stockTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"导航栏背景"]];
    _stockTableView.delegate = self;
    _stockTableView.dataSource = self;
    [bottomView addSubview:_stockTableView];
    
    [_stockTableView registerNib:[UINib nibWithNibName:@"StockCell" bundle:nil] forCellReuseIdentifier:@"StockCell"];
    
    __weak HomeViewController *weakSelf = self;
    
    //下拉刷新
    
    _stockTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        if ([stockType isEqualToString:@"HS"]) {
            stockPage2 = 1;
        }else if ([stockType isEqualToString:@"JM"]){
            stockPage3 = 1;
        }else{
            stockPage1 = 1;
        }

        [weakSelf stockLoadData];
        
    }];
    //上拉加载
    
    _stockTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
     
        if ([stockType isEqualToString:@"HS"]) {
            stockPage2 ++;
            
        }else if ([stockType isEqualToString:@"JM"]){
            stockPage3 ++;
            
        }else{
            
            stockPage1 ++;
            
        }
        [weakSelf stockLoadData];

    }];
    
}
//现有库存
- (void)existingButtonAction{

    ExistingInventoryViewController *existVC = [[ExistingInventoryViewController alloc]init];
    
    existVC.selectArr = selectArr;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    

    [self.navigationController pushViewController:existVC animated:YES];
    
}


//销售记录
- (void)creatSalesRecordsView{

    
    
    UILabel *numLabel1= [[UILabel alloc]initWithFrame:CGRectMake(0, 27, kScreenWidth/2, 40)];
    numLabel1.textAlignment = NSTextAlignmentCenter;
    numLabel1.text = @"52300";
    numLabel1.textColor = [RGBColor colorWithHexString:@"#ffc000"];
    numLabel1.font = [UIFont systemFontOfSize:29];
    numLabel1.tag = 7000;
    [_salesRecordsView addSubview:numLabel1];
    
    UILabel *numLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, 27, kScreenWidth/2, 40)];
    numLabel2.textAlignment = NSTextAlignmentCenter;
    numLabel2.text = @"100.52万";
    numLabel2.textColor = [RGBColor colorWithHexString:@"#ffc000"];
    numLabel2.font = [UIFont systemFontOfSize:29];
    numLabel2.tag = 7001;
    [_salesRecordsView addSubview:numLabel2];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/4 - 75, numLabel1.bottom+21, 75, 20)];
    label1.textAlignment = NSTextAlignmentRight;
    label1.text = @"今日利润";
    label1.textColor = [RGBColor colorWithHexString:@"434b9b"];
    label1.font = [UIFont systemFontOfSize:16];
    [_salesRecordsView addSubview:label1];
    
    UIImageView *imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/4+5, label1.top, 15, 21)];
    imageV1.image = [UIImage imageNamed:@"上涨（30x42）.png"];
    imageV1.tag = 7006;
    [_salesRecordsView addSubview:imageV1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(imageV1.right+5, label1.top, 60, 20)];
    label2.text = @"100%";
    label2.textColor = [RGBColor colorWithHexString:@"#ffc000"];
    label2.tag = 7002;
    label2.font = [UIFont systemFontOfSize:14];
    [_salesRecordsView addSubview:label2];
    
    
    UIView *line1View = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-1)/2, numLabel1.bottom, 1, 17)];
    line1View.backgroundColor = [RGBColor colorWithHexString:@"bac0fa"];
    [_salesRecordsView addSubview:line1View];
    
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/4*3-100, numLabel1.bottom+21, 100, 20)];
    label3.textAlignment = NSTextAlignmentRight;
    label3.text = @"今日销售额";
    label3.textColor = [RGBColor colorWithHexString:@"434b9b"];
    label3.font = [UIFont systemFontOfSize:16];
    [_salesRecordsView addSubview:label3];
    
    UIImageView *imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/4*3+5, label3.top, 15, 21)];
    imageV2.image = [UIImage imageNamed:@"下跌（30x42）.png"];
    imageV2.tag = 7007;
    [_salesRecordsView addSubview:imageV2];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(imageV2.right+5, label1.top, 60, 20)];
    label4.text = @"50%";
    label4.textColor = [RGBColor colorWithHexString:@"#0071b8"];
    label4.tag = 7003;
    label4.font = [UIFont systemFontOfSize:14];
    [_salesRecordsView addSubview:label4];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(30, label4.bottom+39, kScreenWidth-60, 1)];
    lineView.backgroundColor = [RGBColor colorWithHexString:@"bac0fa"];
    [_salesRecordsView addSubview:lineView];
    
    
    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(0, lineView.bottom+31, kScreenWidth/2, 20)];
    label5.textAlignment = NSTextAlignmentCenter;
    label5.text = @"1299.43万";
    label5.textColor = [RGBColor colorWithHexString:@"434b9b"];
    label5.font = [UIFont systemFontOfSize:15];
    label5.tag = 7004;
    [_salesRecordsView addSubview:label5];
    
    UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, lineView.bottom+31, kScreenWidth/2, 20)];
    label6.textAlignment = NSTextAlignmentCenter;
    label6.text = @"18%";
    label6.textColor = [RGBColor colorWithHexString:@"#434b9b"];
    label6.font = [UIFont systemFontOfSize:15];
    label6.tag = 7005;
    [_salesRecordsView addSubview:label6];
    
    UILabel *label7 = [[UILabel alloc]initWithFrame:CGRectMake(0, label5.bottom+9, kScreenWidth/2, 20)];
    label7.textAlignment = NSTextAlignmentCenter;
    label7.text = @"本月销售额";
    label7.tag = 7008;
    label7.textColor = [RGBColor colorWithHexString:@"434b9b"];
    label7.font = [UIFont systemFontOfSize:15];
    [_salesRecordsView addSubview:label7];
    
    UILabel *label8 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, label5.bottom+9, kScreenWidth/2, 20)];
    label8.textAlignment = NSTextAlignmentCenter;
    label8.text = @"本月利润";
    label8.tag = 7009;
    label8.textColor = [RGBColor colorWithHexString:@"#434b9b"];
    label8.font = [UIFont systemFontOfSize:15];
    [_salesRecordsView addSubview:label8];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(line1View.left, label5.bottom, 1, 17)];
    lineView2.backgroundColor = [RGBColor colorWithHexString:@"bac0fa"];
    [_salesRecordsView addSubview:lineView2];
    
    //下面的示图
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 322-84+35, kScreenWidth, kScreenHeight-322+84-35)];
    bottomView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"导航栏背景"]];
    [_salesRecordsView addSubview:bottomView];
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    NSString *dateString1 = [dateFormatter stringFromDate:currentDate];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"YYYY年"];
    NSString *dateString2 = [dateFormatter1 stringFromDate:currentDate];
    
    NSString *month = [NSString stringWithFormat:@"%ld月",(long)[dateString1 integerValue]];

    NSArray *titleArr = @[dateString2,month];
    
    for (int i = 0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 700+i;
        button.frame = CGRectMake(kScreenWidth/2*i, 0, kScreenWidth/2, 35);
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[RGBColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(buttonAction2:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:button];
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(button.width/2+25+button.left, 13, 11, 10)];
        imageV.image = [UIImage imageNamed:@"日期箭头.png"];
        [bottomView addSubview:imageV];
    }
    
    UIView *line2View = [[UIView alloc]initWithFrame:CGRectMake(0, 34, kScreenWidth, 1)];
    line2View.backgroundColor = [RGBColor colorWithHexString:@"#999999"];
    [bottomView addSubview:line2View];

    _salesRecordsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 35, kScreenWidth, bottomView.height-35-64) style:UITableViewStyleGrouped];
    _salesRecordsTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"导航栏背景"]];
    _salesRecordsTableView.delegate = self;
    _salesRecordsTableView.dataSource = self;
    [bottomView addSubview:_salesRecordsTableView];
    
    [_salesRecordsTableView registerNib:[UINib nibWithNibName:@"SalesRecordsCell" bundle:nil] forCellReuseIdentifier:@"SalesRecordsCell"];
    
    
    __weak HomeViewController *weakSelf = self;
    

    //下拉刷新
    
    _salesRecordsTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        salesRecordsPage = 1;

        [weakSelf salesRecordsLoadData];
        
    }];
    //上拉加载
    
    _salesRecordsTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        salesRecordsPage ++;
        [weakSelf salesRecordsLoadData];
        
    }];
    
}


//账本
- (void)creatBooksView{

    UILabel *numLabel1= [[UILabel alloc]initWithFrame:CGRectMake(0, 27, kScreenWidth/2, 40)];
    numLabel1.textAlignment = NSTextAlignmentCenter;
    numLabel1.text = @"¥52300";
    numLabel1.textColor = [RGBColor colorWithHexString:@"#7c1207"];
    numLabel1.font = [UIFont systemFontOfSize:29];
    numLabel1.tag = 8001;
    [_booksView addSubview:numLabel1];
    
    UILabel *numLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, 27, kScreenWidth/2, 40)];
    numLabel2.textAlignment = NSTextAlignmentCenter;
    numLabel2.text = @"100.52万";
    numLabel2.textColor = [RGBColor colorWithHexString:@"#7c1207"];
    numLabel2.font = [UIFont systemFontOfSize:29];
    numLabel2.tag = 8002;
    [_booksView addSubview:numLabel2];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, numLabel1.bottom+21, kScreenWidth/2, 20)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = @"今日收款";
    label1.textColor = [RGBColor colorWithHexString:@"ffffff"];
    label1.font = [UIFont systemFontOfSize:16];
    [_booksView addSubview:label1];
    
    
    
    UIView *line1View = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-1)/2, numLabel1.bottom, 1, 17)];
    line1View.backgroundColor = [RGBColor colorWithHexString:@"ffdfdb"];
    [_booksView addSubview:line1View];
    
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, numLabel1.bottom+21, kScreenWidth/2, 20)];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.text = @"今日付款";
    label3.textColor = [RGBColor colorWithHexString:@"ffffff"];
    label3.font = [UIFont systemFontOfSize:16];
    [_booksView addSubview:label3];
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(30, label3.bottom+39, kScreenWidth-60, 1)];
    lineView.backgroundColor = [RGBColor colorWithHexString:@"ffdfdb"];
    [_booksView addSubview:lineView];
    
    
    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(0, lineView.bottom+31, kScreenWidth, 20)];
    label5.text = @"1299.43万";
    label5.textAlignment = NSTextAlignmentCenter;
    label5.textColor = [RGBColor colorWithHexString:@"ffffff"];
    label5.font = [UIFont systemFontOfSize:15];
    label5.tag = 8003;
    [_booksView addSubview:label5];
    
 
    
    UILabel *label7 = [[UILabel alloc]initWithFrame:CGRectMake(0, label5.bottom+9, kScreenWidth, 20)];
    label7.text = @"收支概况";
    label7.textColor = [RGBColor colorWithHexString:@"ffffff"];
    label7.textAlignment = NSTextAlignmentCenter;
    label7.font = [UIFont systemFontOfSize:15];
    [_booksView addSubview:label7];
    
    
    
    //下面的示图
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 322-84+35, kScreenWidth, kScreenHeight-322+84-35)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [_booksView addSubview:bottomView];
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    NSString *dateString1 = [dateFormatter stringFromDate:currentDate];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"YYYY年"];
    NSString *dateString2 = [dateFormatter1 stringFromDate:currentDate];
    

    NSString *month = [NSString stringWithFormat:@"%ld月",[dateString1 integerValue]];
    NSArray *titleArr = @[dateString2,month];
    
    for (int i = 0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 800+i;
        button.frame = CGRectMake(kScreenWidth/2*i, 0, kScreenWidth/2, 35);
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[RGBColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(buttonAction3:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:button];
    
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(button.width/2+25+button.left, 13, 11, 10)];
        imageV.image = [UIImage imageNamed:@"日期选择.png"];
        [bottomView addSubview:imageV];
        
    }
    UIView *line2View = [[UIView alloc]initWithFrame:CGRectMake(0, 34, kScreenWidth, 1)];
    line2View.backgroundColor = [RGBColor colorWithHexString:@"#999999"];
    [bottomView addSubview:line2View];
    
    _booksTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 35, kScreenWidth, bottomView.height-35-64) style:UITableViewStyleGrouped];
    _booksTableView.backgroundColor = [UIColor whiteColor];
    _booksTableView.delegate = self;
    _booksTableView.dataSource = self;
    [bottomView addSubview:_booksTableView];
    
    [_booksTableView registerNib:[UINib nibWithNibName:@"BooksTableViewCell" bundle:nil] forCellReuseIdentifier:@"BooksTableViewCell"];
    
    
    __weak HomeViewController *weakSelf = self;

    
    //下拉刷新
    
    _booksTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        booksPage = 1;
        [weakSelf booksLoadData];
        
    }];
    //上拉加载
    
    _booksTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        booksPage ++;
        
        if (booksPage > 3 ) {
            booksPage = 3;
            [_booksTableView.footer endRefreshing];
        }else{
            
        [weakSelf booksLoadData];
            
        }
    }];


}

//寄卖管理

- (void)creatConsignmentView{

    UILabel *numLabel1= [[UILabel alloc]initWithFrame:CGRectMake(0, 27, kScreenWidth/2, 40)];
    numLabel1.textAlignment = NSTextAlignmentCenter;
    numLabel1.text = @"¥52300";
    numLabel1.textColor = [RGBColor colorWithHexString:@"#ffc000"];
    numLabel1.font = [UIFont systemFontOfSize:29];
    numLabel1.tag = 9001;
    [_consignmentView addSubview:numLabel1];
    
    UILabel *numLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, 27, kScreenWidth/2, 40)];
    numLabel2.textAlignment = NSTextAlignmentCenter;
    numLabel2.text = @"199件";
    numLabel2.textColor = [RGBColor colorWithHexString:@"#ffc000"];
    numLabel2.font = [UIFont systemFontOfSize:29];
    numLabel2.tag = 9002;
    [_consignmentView addSubview:numLabel2];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, numLabel1.bottom+21, kScreenWidth/2, 20)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = @"待结算货款";
    label1.textColor = [RGBColor colorWithHexString:@"026fbb"];
    label1.font = [UIFont systemFontOfSize:16];
    [_consignmentView addSubview:label1];
    
    
    UIView *line1View = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-1)/2, numLabel1.bottom, 1, 17)];
    line1View.backgroundColor = [RGBColor colorWithHexString:@"56b7fb"];
    [_consignmentView addSubview:line1View];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, numLabel1.bottom+21, kScreenWidth/2, 20)];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.text = @"正在寄卖中的商品";
    label3.textColor = [RGBColor colorWithHexString:@"026fbb"];
    label3.font = [UIFont systemFontOfSize:16];
    [_consignmentView addSubview:label3];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(30, label3.bottom+39, kScreenWidth-60, 1)];
    lineView.backgroundColor = [RGBColor colorWithHexString:@"56b7fb"];
    [_consignmentView addSubview:lineView];

    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(0, lineView.bottom+31, kScreenWidth/2, 20)];
    label5.textAlignment = NSTextAlignmentCenter;
    label5.text = @"9单";
    label5.textColor = [RGBColor colorWithHexString:@"026fbb"];
    label5.tag = 9003;
    label5.font = [UIFont systemFontOfSize:15];
    [_consignmentView addSubview:label5];
    
    UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, lineView.bottom+31, kScreenWidth/2, 20)];
    label6.textAlignment = NSTextAlignmentCenter;
    label6.text = @"104.23万";
    label6.textColor = [RGBColor colorWithHexString:@"#026fbb"];
    label6.tag = 9004;
    label6.font = [UIFont systemFontOfSize:15];
    [_consignmentView addSubview:label6];
    
    UILabel *label7 = [[UILabel alloc]initWithFrame:CGRectMake(0, label5.bottom+9, kScreenWidth/2, 20)];
    label7.textAlignment = NSTextAlignmentCenter;
    label7.text = @"总计寄卖单";
    label7.textColor = [RGBColor colorWithHexString:@"026fbb"];
    label7.font = [UIFont systemFontOfSize:15];
    [_consignmentView addSubview:label7];
    
    UILabel *label8 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, label5.bottom+9, kScreenWidth/2, 20)];
    label8.textAlignment = NSTextAlignmentCenter;
    label8.text = @"总佣金";
    label8.textColor = [RGBColor colorWithHexString:@"#026fbb"];
    label8.font = [UIFont systemFontOfSize:15];
    [_consignmentView addSubview:label8];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(line1View.left, label5.bottom, 1, 17)];
    lineView2.backgroundColor = [RGBColor colorWithHexString:@"56b7fb"];
    [_consignmentView addSubview:lineView2];

    //下面的示图
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 322-84+35, kScreenWidth, kScreenHeight-322+84-35)];
    bottomView.backgroundColor = [RGBColor colorWithHexString:@"026fbb"];
    [_consignmentView addSubview:bottomView];

    NSArray *titleArr = @[@"寄卖中",@"已取回",@"待结算",@"已完成"];
    
    _selectImageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 52, 21)];
    _selectImageV2.image = [UIImage imageNamed:@"选择烂选中框.png"];
    [bottomView addSubview:_selectImageV2];
    for (int i = 0; i<4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 900+i;
        button.frame = CGRectMake(kScreenWidth/4*i, 0, kScreenWidth/4, 35);
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[RGBColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        [button setTitleColor:[RGBColor colorWithHexString:@"#026fbb"] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(buttonAction4:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:button];
        if (i==0) {
            button.selected = YES;
            _selectButton2 = button;
            _selectImageV2.center = _selectButton2.center;
        }
    }
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, 34, kScreenWidth, 1)];
    lineView3.backgroundColor = [RGBColor colorWithHexString:@"56b7fb"];
    [bottomView addSubview:lineView3];
    UIView *lineView4 = [[UIView alloc]initWithFrame:CGRectMake(0, 69, kScreenWidth, 1)];
    lineView4.backgroundColor = [RGBColor colorWithHexString:@"56b7fb"];
    [bottomView addSubview:lineView4];

    
    NSArray *titleArr1 = @[@"按日期",@"按客户"];
    
    _selectImageV3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 52, 21)];
    _selectImageV3.image = [UIImage imageNamed:@"选择烂选中框.png"];
    [bottomView addSubview:_selectImageV3];
    for (int i = 0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 1000+i;
        button.frame = CGRectMake(kScreenWidth/2*i, 35, kScreenWidth/2, 35);
        [button setTitle:titleArr1[i] forState:UIControlStateNormal];
        [button setTitleColor:[RGBColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        [button setTitleColor:[RGBColor colorWithHexString:@"#026fbb"] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(buttonAction5:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:button];
        if (i==0) {
            button.selected = YES;
            _selectButton3 = button;
            _selectImageV3.center = _selectButton3.center;
        }
    }
    
    
    _consignmentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, kScreenWidth, bottomView.height-70-64) style:UITableViewStyleGrouped];
    _consignmentTableView.delegate = self;
    _consignmentTableView.dataSource = self;
    _consignmentTableView.backgroundColor = [RGBColor colorWithHexString:@"026fbb"];
    [bottomView addSubview:_consignmentTableView];
    
    [_consignmentTableView registerNib:[UINib nibWithNibName:@"ConsignmentCell" bundle:nil] forCellReuseIdentifier:@"ConsignmentCell"];
    
    __weak HomeViewController *weakSelf = self;

    
    //下拉刷新
    
    _consignmentTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if ([group isEqualToString:@"time"]) {
            if ([status isEqualToString:@"1"]) {
                consignmentPage1 = 1;
            }else if ([status isEqualToString:@"4"]){
                consignmentPage3 = 1;
            }else if ([status isEqualToString:@"2"]){
                consignmentPage5 = 1;
            }else if ([status isEqualToString:@"3"]){
                consignmentPage7 = 1;
            }
            
        }else if ([group isEqualToString:@"customer"]){
            if ([status isEqualToString:@"1"]) {
                consignmentPage2 = 1;
            }else if ([status isEqualToString:@"4"]){
                consignmentPage4 = 1;
            }else if ([status isEqualToString:@"2"]){
                consignmentPage6 = 1;
            }else if ([status isEqualToString:@"3"]){
                consignmentPage8 = 1;
            }
        }

        
        [weakSelf consignmentLoadData1];
    }];
    //上拉加载
    
    _consignmentTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if ([group isEqualToString:@"time"]) {
            if ([status isEqualToString:@"1"]) {
                consignmentPage1 ++;
            }else if ([status isEqualToString:@"4"]){
                consignmentPage3 ++;
            }else if ([status isEqualToString:@"2"]){
                consignmentPage5 ++;
            }else if ([status isEqualToString:@"3"]){
                consignmentPage7 ++;
            }
            
        }else if ([group isEqualToString:@"customer"]){
            if ([status isEqualToString:@"1"]) {
                consignmentPage2 ++;
            }else if ([status isEqualToString:@"4"]){
                consignmentPage4 ++;
            }else if ([status isEqualToString:@"2"]){
                consignmentPage6 ++;
            }else if ([status isEqualToString:@"3"]){
                consignmentPage8 ++;
            }
        }
        [weakSelf consignmentLoadData1];

    }];

}


//首页按钮点击方法
- (void)buttonAction:(UIButton*)bt{
    if (bt != _selectButton) {
        _selectImageV.center = bt.center;
        _selectButton.selected = NO;
        _selectButton = bt;
        bt.selected = YES;
        
        if (bt.tag == 500) {
            homeType = 1;
            if (_homeArr1.count == 0) {
                [self homeLoadData];
            }else{
                _homeArr = _homeArr1;
                [_myTableView reloadData];
            }
        }else if (bt.tag == 501){
            homeType = 2;
            if (_homeArr2.count == 0) {
                [self homeLoadData];
            }else{
                _homeArr = _homeArr2;
                [_myTableView reloadData];
            }

        }else if (bt.tag == 502){
            homeType = 3;
            if (_homeArr3.count == 0) {
                [self homeLoadData];
            }else{
                _homeArr = _homeArr3;
                [_myTableView reloadData];
            }
            
        }
        
    }
}
//库存按钮点击方法
- (void)buttonAction1:(UIButton*)bt{
    
    
    if (bt != _selectButton1) {
        _selectImageV1.center = bt.center;
        _selectButton1.selected = NO;
        _selectButton1 = bt;
        bt.selected = YES;
        if (bt.tag == 600) {
            stockType = @"";
            
            if (_storkDataArr1.count == 0) {
                [self stockLoadData];
            }else{
                _storkDataArr = _storkDataArr1;
                [_stockTableView reloadData];
            }
            
        }else if (bt.tag == 601){
            stockType = @"HS";
            
            if (_storkDataArr2.count == 0) {
                [self stockLoadData];
            }else{
                _storkDataArr = _storkDataArr2;
                [_stockTableView reloadData];
            }
            
        }else if (bt.tag == 602){
            stockType = @"JM";
            
            if (_storkDataArr3.count == 0) {
                [self stockLoadData];
            }else{
                _storkDataArr = _storkDataArr3;
                [_stockTableView reloadData];
            }
            
        }

    }
    
}

//销售记录按钮点击方法
- (void)buttonAction2:(UIButton*)bt{

    [_timeSelectArr removeAllObjects];
    [_timeSelectTableView reloadData];
    
    bt.selected = !bt.selected;
    
    if (bt.tag == 700) {
        
        UIButton *bt1 = [self.view viewWithTag:701];
        
        if (bt.selected) {
            _timeSelectTableView.left = 0;
            for (int i = 0; i<5; i++) {
                
                NSString *str = [NSString stringWithFormat:@"%d年",2016-i];
                
                [_timeSelectArr addObject:str];
            }
            _timeSelectTableView.hidden = NO;
            [_timeSelectTableView reloadData];

        }else{
            _timeSelectTableView.hidden = YES;
        }
        bt1.selected = NO;
    }else{
        UIButton *bt1 = [self.view viewWithTag:700];

        if (bt.selected) {
            _timeSelectTableView.left = kScreenWidth/2;
            
            for (int i = 0; i<12; i++) {
                
                NSString *str = [NSString stringWithFormat:@"%d月",i+1];
                
                [_timeSelectArr addObject:str];
            }
            _timeSelectTableView.hidden = NO;
            [_timeSelectTableView reloadData];
        }else{
            _timeSelectTableView.hidden = YES;
        }
        bt1.selected = NO;

    }
    
}
//账本按钮点击方法
- (void)buttonAction3:(UIButton*)bt{
    
    [_timeSelectArr removeAllObjects];
    [_timeSelectTableView reloadData];
    
    bt.selected = !bt.selected;
    
    if (bt.tag == 800) {
        
        UIButton *bt1 = [self.view viewWithTag:801];
        
        if (bt.selected) {
            _timeSelectTableView.left = 0;
            for (int i = 0; i<5; i++) {
                
                NSString *str = [NSString stringWithFormat:@"%d年",2016-i];
                
                [_timeSelectArr addObject:str];
            }
            _timeSelectTableView.hidden = NO;
            [_timeSelectTableView reloadData];
            
        }else{
            _timeSelectTableView.hidden = YES;
        }
        bt1.selected = NO;
    }else{
        UIButton *bt1 = [self.view viewWithTag:800];
        
        if (bt.selected) {
            _timeSelectTableView.left = kScreenWidth/2;
            
            for (int i = 0; i<12; i++) {
                
                NSString *str = [NSString stringWithFormat:@"%d月",i+1];
                
                [_timeSelectArr addObject:str];
            }
            _timeSelectTableView.hidden = NO;
            [_timeSelectTableView reloadData];
        }else{
            _timeSelectTableView.hidden = YES;
        }
        bt1.selected = NO;
        
    }

    
}

//寄卖情况按钮点击方法
- (void)buttonAction4:(UIButton*)bt{
    if (bt != _selectButton2) {
        _selectImageV2.center = bt.center;
        _selectButton2.selected = NO;
        _selectButton2 = bt;
        bt.selected = YES;
        
        if (bt.tag == 900) {
            status = @"1";
            if ([group isEqualToString:@"time"]) {
                
               if (_consignmentArr1.count == 0) {
                   [self consignmentLoadData1];
               }else{
                   _consignmentArr = _consignmentArr1;
                   [_consignmentTableView reloadData];
               }
            
            }else{
            
                if (_consignmentArr2.count == 0) {
                    [self consignmentLoadData1];
                }else{
                    _consignmentArr = _consignmentArr2;
                    [_consignmentTableView reloadData];
                }
            }
        }else if (bt.tag == 901){
            status = @"4";
            if ([group isEqualToString:@"time"]) {
                
                if (_consignmentArr3.count == 0) {
                    [self consignmentLoadData1];
                }else{
                    _consignmentArr = _consignmentArr3;
                    [_consignmentTableView reloadData];
                }
                
            }else{
                
                if (_consignmentArr4.count == 0) {
                    [self consignmentLoadData1];
                }else{
                    _consignmentArr = _consignmentArr4;
                    [_consignmentTableView reloadData];
                }
            }
        }else if (bt.tag == 902){
            status = @"2";
            if ([group isEqualToString:@"time"]) {
                
                if (_consignmentArr5.count == 0) {
                    [self consignmentLoadData1];
                }else{
                    _consignmentArr = _consignmentArr5;
                    [_consignmentTableView reloadData];
                }
                
            }else{
                
                if (_consignmentArr6.count == 0) {
                    [self consignmentLoadData1];
                }else{
                    _consignmentArr = _consignmentArr6;
                    [_consignmentTableView reloadData];
                }
            }
        }else if (bt.tag == 903){
            status = @"3";
            if ([group isEqualToString:@"time"]) {
                
                if (_consignmentArr7.count == 0) {
                    [self consignmentLoadData1];
                }else{
                    _consignmentArr = _consignmentArr7;
                    [_consignmentTableView reloadData];
                }
                
            }else{
                
                if (_consignmentArr8.count == 0) {
                    [self consignmentLoadData1];
                }else{
                    _consignmentArr = _consignmentArr8;
                    [_consignmentTableView reloadData];
                }
            }
        }
        
        
    }

}

- (void)buttonAction5:(UIButton*)bt{

    
    if (bt != _selectButton3) {
        _selectImageV3.center = bt.center;
        _selectButton3.selected = NO;
        _selectButton3 = bt;
        bt.selected = YES;

        if (bt.tag == 1000) {
            group = @"time";
            if ([status isEqualToString:@"1"]) {
                
                if (_consignmentArr1.count == 0) {
                    [self consignmentLoadData1];

                }else{
                    _consignmentArr = _consignmentArr1;
                    [_consignmentTableView reloadData];
                }
            }else if ([status isEqualToString:@"4"]){
                if (_consignmentArr3.count == 0) {
                    [self consignmentLoadData1];
                    
                }else{
                    
                    _consignmentArr = _consignmentArr3;
                    [_consignmentTableView reloadData];
                }
            
            }else if ([status isEqualToString:@"2"]){
                if (_consignmentArr5.count == 0) {
                    [self consignmentLoadData1];
                    
                }else{
                    
                    _consignmentArr = _consignmentArr5;
                    [_consignmentTableView reloadData];
                }
                
            }else if ([status isEqualToString:@"3"]){
                if (_consignmentArr7.count == 0) {
                    [self consignmentLoadData1];
                    
                }else{
                    
                    _consignmentArr = _consignmentArr7;
                    [_consignmentTableView reloadData];
                }
                
            }
        }else if (bt.tag == 1001){
        
            group = @"customer";
            if ([status isEqualToString:@"1"]) {
                
                if (_consignmentArr2.count == 0) {
                    [self consignmentLoadData1];
                    
                }else{
                    _consignmentArr = _consignmentArr2;
                    [_consignmentTableView reloadData];
                }
            }else if ([status isEqualToString:@"4"]){
                if (_consignmentArr4.count == 0) {
                    [self consignmentLoadData1];
                    
                }else{
                    
                    _consignmentArr = _consignmentArr4;
                    [_consignmentTableView reloadData];
                }
                
            }else if ([status isEqualToString:@"2"]){
                if (_consignmentArr6.count == 0) {
                    [self consignmentLoadData1];
                    
                }else{
                    
                    _consignmentArr = _consignmentArr6;
                    [_consignmentTableView reloadData];
                }
                
            }else if ([status isEqualToString:@"3"]){
                if (_consignmentArr8.count == 0) {
                    [self consignmentLoadData1];
                    
                }else{
                    _consignmentArr = _consignmentArr8;
                    [_consignmentTableView reloadData];
                }
                
            }

        
        
        }
    
    }
    
}


//左边侧滑按钮
- (void)leftBtnAction{
    
    [searchTextField resignFirstResponder];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    [delegate.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];

}

//右边搜索按钮
- (void)rightBtnAction{
    
    SearchViewController *searchVC = [[SearchViewController alloc]init];
    searchVC.selectArr = selectArr;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];

    [self.navigationController pushViewController:searchVC animated:YES];

}

//扫码按钮
- (void)scanCodeButtonAction{
    
    
    QRCodeViewController *qrcodeVC = [[QRCodeViewController alloc]init];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;

    [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    
    [self.navigationController pushViewController:qrcodeVC animated:YES];
    

    
}
//搜索按钮
- (void)searchButtonAction{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    [params setObject:SYGData[@"id"] forKey:@"uid"];

    [params setObject:searchTextField.text forKey:@"goods_sn"];
    
    [DataSeviece requestUrl:get_goods_by_snhtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
        
        if ([result[@"result"][@"data"][@"goodsinfo"][@"type"] isEqualToString:@"HS"]) {
            StockDetailsViewController *stockDetailVC = [[UIStoryboard storyboardWithName:@"Share" bundle:nil] instantiateViewControllerWithIdentifier:@"StockDetailsViewController"];
            stockDetailVC.isType = @"1";
            stockDetailVC.SPID = result[@"result"][@"data"][@"goodsinfo"][@"id"];
            
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            
            [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
            
            [self.navigationController pushViewController:stockDetailVC animated:YES];
            
        }else if ([result[@"result"][@"data"][@"goodsinfo"][@"type"] isEqualToString:@"JM"]){
            MerchandiseViewController *merchandiseVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"MerchandiseViewController"];
            
            merchandiseVC.status = @"1";
            merchandiseVC.merchandiseId = result[@"result"][@"data"][@"goodsinfo"][@"consighment_id"];
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
            [self.navigationController pushViewController:merchandiseVC animated:YES];
            
        }else{
            
            TransactionRecordViewController *transactionRecordVC = [[UIStoryboard storyboardWithName:@"Share" bundle:nil] instantiateViewControllerWithIdentifier:@"TransactionRecordViewController"];
            
            transactionRecordVC.sales_id = result[@"result"][@"data"][@"salesinfo"][@"id"];
            transactionRecordVC.arr = selectArr;
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            
            [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
            
            [self.navigationController pushViewController:transactionRecordVC animated:YES];

        
        }
        }else{
        
            UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:result[@"result"][@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alertV show];
            
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITableViewDataSource UITableViewDelegate

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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView == _salesRecordsTableView) {
        return _salesRecordsArr.count+1;
    }else if (tableView == _booksTableView){
        return _booksArr.count+1;
    }else if (tableView == _consignmentTableView){
        return _consignmentArr.count;
    }else if (tableView == _stockTableView){
        return 1;
    }
    if (tableView == _timeSelectTableView) {
        return 1;
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _salesRecordsTableView) {
        
        if (section == _salesRecordsArr.count) {
            return 1;
        }
        
        if (flag[section]) {
         
            SalesRecordsModel *model = _salesRecordsArr[section];
            
            return model.list.count;
        }
        return 0;
    }else if (tableView == _booksTableView){
        if (section == _booksArr.count) {
            return 1;
        }

        if (flag1[section]) {
            
            BooksModel *model = _booksArr[section];
        
            return model.item.count;
        }
        return 0;
    }else if (tableView == _stockTableView){
    
        return _storkDataArr.count;
    }else if (tableView == _timeSelectTableView){
    
        return _timeSelectArr.count;
    }else if (tableView == _consignmentTableView){
        
        consignmentModel *model = _consignmentArr[section];
        return model.item.count;
    }else if (tableView == _myTableView){
    
        return _homeArr.count;
    }

    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _myTableView) {
        HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell" forIndexPath:indexPath];
        cell.arr = selectArr;
        cell.homeType = homeType;
        cell.model = _homeArr[indexPath.row];
        return cell;
    }else if (tableView == _stockTableView){
        StockCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StockCell" forIndexPath:indexPath];
        cell.arr = selectArr;
        cell.model = _storkDataArr[indexPath.row];
        return cell;
    }else if (tableView == _salesRecordsTableView){
        
        if (indexPath.section == _salesRecordsArr.count) {
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"111"];
            
            return cell;
        }
        
        
        SalesRecordsModel *model = _salesRecordsArr[indexPath.section];
        
        SalesRecordsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SalesRecordsCell" forIndexPath:indexPath];
        cell.arr = selectArr;
        cell.dic = model.list[indexPath.row];
        return cell;
    
    }else if (tableView == _booksTableView){
        if (indexPath.section == _booksArr.count) {
            
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"111"];
            
            return cell;
        }

        
        BooksModel *model = _booksArr[indexPath.section];
        BooksTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BooksTableViewCell" forIndexPath:indexPath];
        cell.dic = model.item[indexPath.row];
        return cell;
        
    }else if (tableView == _consignmentTableView){
        
        ConsignmentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConsignmentCell" forIndexPath:indexPath];
        
        if (_consignmentArr.count > indexPath.section) {
            consignmentModel *model = _consignmentArr[indexPath.section];
            cell.arr = selectArr;
            cell.dataTime = model.time;
            cell.dic = model.item[indexPath.row];
        }
        
        return cell;
    }else if (tableView == _timeSelectTableView){
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimeSelectTableViewCell"];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TimeSelectTableViewCell"];
        }
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.textLabel.text = _timeSelectArr[indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        return cell;
    
    }
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _stockTableView) {
        return 61;
    }else if (tableView == _salesRecordsTableView){
    
        if (indexPath.section == _salesRecordsArr.count) {
            return 0.01f;
        }
        return 36;
    }else if (tableView == _booksTableView){
        if (indexPath.section == _booksArr.count) {
            return 0.01f;
        }

        return 36;
    }else if (tableView == _consignmentTableView){
        
        return 81;
    }else if (tableView == _myTableView){
        
        return 61;
    }
    return 44;
}

//注意使用headerView.textLabel 注意要使用平铺
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (tableView == _salesRecordsTableView) {
        
        if (section == _salesRecordsArr.count) {
            return [[UIView alloc]init];
        }
        
        UITableViewHeaderFooterView *headerView= [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SalesRecordsHeaderView"];
        
        if (!headerView) {
            
            headerView=[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"SalesRecordsHeaderView"];
            UIButton *salesButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            salesButton.tag = 1100;
            salesButton.frame = CGRectMake(0, 0, kScreenWidth, 82);
            [salesButton addTarget:self action:@selector(salesButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [headerView.contentView addSubview:salesButton];
            
            UILabel *dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 13, 50, 16)];
            dayLabel.textColor = [UIColor whiteColor];
            dayLabel.font = [UIFont systemFontOfSize:14];
            dayLabel.tag = 1101;
            [headerView.contentView addSubview:dayLabel];
            
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 53, 150, 16)];
            label1.textColor = [UIColor whiteColor];
            label1.font = [UIFont systemFontOfSize:14];
            label1.tag = 1102;
            [headerView.contentView addSubview:label1];
            
            UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-75, 53, 150, 16)];
            label2.textAlignment = NSTextAlignmentCenter;
            label2.textColor = [UIColor whiteColor];
            label2.font = [UIFont systemFontOfSize:14];
            label2.tag = 1103;
            [headerView.contentView addSubview:label2];
            
            UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-124, 53, 100, 16)];
            label3.textColor = [UIColor whiteColor];
            label3.font = [UIFont systemFontOfSize:14];
            label3.tag = 1104;
            label3.textAlignment = NSTextAlignmentRight;
            [headerView.contentView addSubview:label3];
            
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-24, label1.top+2, 14, 8)];
            imageV.tag = 1105;
            [headerView.contentView addSubview:imageV];
            
            UIView *bgV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
            bgV.backgroundColor = [RGBColor colorWithHexString:@"#999999"];
            [headerView.contentView addSubview:bgV];

        }
        
        UILabel *dayLabel = [headerView.contentView viewWithTag:1101];
        
        UILabel *label1 = [headerView.contentView viewWithTag:1102];
        
        UILabel *label2 = [headerView.contentView viewWithTag:1103];
        
        UILabel *label3 = [headerView.contentView viewWithTag:1104];

        UIImageView *imageV = [headerView.contentView viewWithTag:1105];


        SalesRecordsModel *model = _salesRecordsArr[section];
//        NSTimeInterval time=[model.sales_time doubleValue];//因为时差问题要加8小时 == 28800 sec
//        NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
//        //实例化一个NSDateFormatter对象
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        //设定时间格式,这里可以设置成自己需要的格式
//        [dateFormatter setDateFormat:@"dd"];
//        
//        NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];

        dayLabel.text = [NSString stringWithFormat:@"%@号",model.date];
        label1.text = [NSString stringWithFormat:@"销售额:%@",model.total_price];
        label2.text = [NSString stringWithFormat:@"利润:%@",model.total_profit];
        label3.text = [NSString stringWithFormat:@"卖出%@件",model.quantity];
        
        if (flag[section]) {
            imageV.image = [UIImage imageNamed:@"下拉展开后箭头.png"];
            
        }else{
            imageV.image = [UIImage imageNamed:@"下拉箭头.png"];
        }

        headerView.tag = 1110+section;
        return headerView;
    }
    
    if (tableView == _booksTableView) {
        
        if (section == _booksArr.count) {
            return [[UIView alloc]init];
        }

        UITableViewHeaderFooterView *headerView= [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BooksHeaderView"];
        
        if (!headerView) {
            headerView=[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"BooksHeaderView"];
            
            
            UIButton *salesButton = [UIButton buttonWithType:UIButtonTypeCustom];
            salesButton.frame = CGRectMake(0, 0, kScreenWidth, 82);
            [salesButton addTarget:self action:@selector(booksButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [headerView.contentView addSubview:salesButton];
            
            
            UILabel *dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 13, 50, 16)];
            dayLabel.textColor = [RGBColor colorWithHexString:@"#333333"];
            dayLabel.font = [UIFont systemFontOfSize:14];
            dayLabel.tag = 1201;
            [headerView.contentView addSubview:dayLabel];
            
            UIImageView *imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(dayLabel.right, 17, 17, 17)];
            imageV1.image = [UIImage imageNamed:@"icon"];
            [headerView.contentView addSubview:imageV1];
            
            
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(imageV1.right+10, 17, 100, 16)];
            label1.tag = 1202;
            label1.textColor = [RGBColor colorWithHexString:@"#e8695a"];
            label1.font = [UIFont systemFontOfSize:14];
            [headerView.contentView addSubview:label1];
            
            UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2+20 , 17, 120, 16)];
            label2.tag = 1203;
            label2.textColor = [RGBColor colorWithHexString:@"#333333"];
            label2.font = [UIFont systemFontOfSize:14];
            [headerView.contentView addSubview:label2];
            
            UIImageView *imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-50, 20, 19, 11)];
            imageV2.image = [UIImage imageNamed:@"new.png"];
            imageV2.tag = 1204;
            [headerView.contentView addSubview:imageV2];
            
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-24, 21, 14, 8)];
            imageV.tag = 1205;
            
            [headerView.contentView addSubview:imageV];
        }
        
        UILabel *dayLabel = [headerView.contentView viewWithTag:1201];
        
        UILabel *label1 = [headerView.contentView viewWithTag:1202];
        
        UILabel *label2 = [headerView.contentView viewWithTag:1203];
        
        UIImageView *image1 = [headerView.contentView viewWithTag:1204];
        
        UIImageView *imageV = [headerView.contentView viewWithTag:1205];

        BooksModel *model = _booksArr[section];
        
        if ([model.is_read isEqualToString:@"2"]) {
            image1.image = [UIImage imageNamed:@"new.png"];
        }else{
            image1.image = [UIImage imageNamed:@""] ;
        }

        dayLabel.text = [NSString stringWithFormat:@"%@日",model.day];
        label1.text = [NSString stringWithFormat:@"收款:%ld",[model.input integerValue]];
        label2.text = [NSString stringWithFormat:@"付款:%ld",[model.out1 integerValue]];
        
        if (flag1[section]) {
            imageV.image = [UIImage imageNamed:@"下拉展开后箭头.png"];
            
        }else{
            imageV.image = [UIImage imageNamed:@"下拉箭头.png"];
        }

        headerView.tag = 1210+section;
        
        UIView *bgV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        bgV.backgroundColor = [RGBColor colorWithHexString:@"#999999"];
        [headerView.contentView addSubview:bgV];
        
        return headerView;

    }else if (tableView == _consignmentTableView){
    
        UITableViewHeaderFooterView *headerView= [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"consignmentHeaderView"];
        
        if (!headerView) {
            
            headerView=[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"consignmentHeaderView"];
            headerView.contentView.backgroundColor = [RGBColor colorWithHexString:@"#0f5d93"];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth/2-10, 25)];
            label.tag = 1301;
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor whiteColor];
            [headerView.contentView addSubview:label];
            
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2,0,  kScreenWidth/2-10, 25)];
            label1.tag = 1302;
            label1.textAlignment = NSTextAlignmentRight;
            label1.font = [UIFont systemFontOfSize:12];
            label1.textColor = [UIColor whiteColor];
            [headerView.contentView addSubview:label1];

        }
        consignmentModel *model;
        if (_consignmentArr.count >section) {
            
            model = _consignmentArr[section];

        }
        
        UILabel *label = [headerView.contentView viewWithTag:1301];
        UILabel *label1 = [headerView.contentView viewWithTag:1302];
        
        if ([group isEqualToString:@"time"]) {
            label.text = model.time;
            label1.text = @"";
        }else if ([group isEqualToString:@"customer"]){
            
            if ([model.customer_name isKindOfClass:[NSNull class]]) {
                label.text = @"";
            }else{
                label.text = model.customer_name;
            }
            if ([model.mobile isKindOfClass:[NSNull class]]) {
                label1.text = @"";
            }else{
                label1.text = model.mobile;
            }
        }else if ([status isEqualToString:@"4"]){
            label.text = model.time;
            label1.text = @"";
        }else if ([status isEqualToString:@"2"]){
            label.text = model.time;
            label1.text = @"";
        }else if ([status isEqualToString:@"3"]){
            label.text = model.time;
            label1.text = @"";
        }
        return headerView;
    }
    
    return nil;
}
//销售记录展开收缩cell
- (void)salesButtonAction:(UIButton*)bt{

    
    NSInteger section = bt.superview.superview.tag - 1110;
    
    flag[section]=!flag[section];


    //    刷新方法
    NSIndexSet *indexSet=[NSIndexSet indexSetWithIndex:section];
    
    [_salesRecordsTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    
}

//账本展开收缩cell
- (void)booksButtonAction:(UIButton*)bt{
    
    NSInteger section = bt.superview.superview.tag - 1210;
    
    flag1[section]=!flag1[section];
    
    
    //    刷新方法
    NSIndexSet *indexSet=[NSIndexSet indexSetWithIndex:section];
    
    [_booksTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    
    
    BooksModel *model = _booksArr[section];
    
    if ([model.is_read isEqualToString:@"2"]) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
        [params setObject:SYGData[@"id"] forKey:@"uid"];
       
        NSString *str = @"";
        
        for (NSDictionary *dic in model.item) {
            str = [NSString stringWithFormat:@"%@,%@",str,dic[@"id"]];
        }
        
        str = [str substringFromIndex:1];
        
        [params setObject:str forKey:@"id"];
        
        [DataSeviece requestUrl:pay_log_readhtml params:params success:^(id result) {
            
            NSLog(@"%@",result);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                model.is_read = @"1";
//                [_booksTableView reloadData];
 
                NSMutableArray *arr = [NSMutableArray array];
                for (int i = 0; i<model.item.count; i++) {
                    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:model.item[i]];
                    [dic setObject:@"1" forKey:@"is_read"];
                    [arr addObject:dic];
                }
                model.item = [arr copy];
            }
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
            
        }];
    }
    
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (tableView == _salesRecordsTableView) {
        if (section == _salesRecordsArr.count) {
            return 0.01;
        }
        return 82;
    }else if (tableView == _booksTableView){
        if (section == _booksArr.count) {
            return 0.01;
        }
        return 51;
    }else if (tableView == _consignmentTableView){
        
        return 25;
    }
    
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == _stockTableView) {
        StockModel *model = _storkDataArr[indexPath.row];

        if ([model.type isEqualToString:@"HS"]) {
            StockDetailsViewController *stockDetailVC = [[UIStoryboard storyboardWithName:@"Share" bundle:nil] instantiateViewControllerWithIdentifier:@"StockDetailsViewController"];
            stockDetailVC.isType = @"1";
            stockDetailVC.SPID = model.SPID;
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            
            [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
            
            [self.navigationController pushViewController:stockDetailVC animated:YES];
  
        }else{
            MerchandiseViewController *merchandiseVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"MerchandiseViewController"];
            merchandiseVC.status = @"1";
            
            merchandiseVC.merchandiseId = model.consighment_id;
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            
            [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
            
            [self.navigationController pushViewController:merchandiseVC animated:YES];

        }
        
    }else if (tableView == _salesRecordsTableView){
        
        TransactionRecordViewController *transactionRecordVC = [[UIStoryboard storyboardWithName:@"Share" bundle:nil] instantiateViewControllerWithIdentifier:@"TransactionRecordViewController"];
        SalesRecordsModel *model = _salesRecordsArr[indexPath.section];
        transactionRecordVC.sales_id = model.list[indexPath.row][@"sales_id"];
        transactionRecordVC.arr = selectArr;
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        
        [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        
        [self.navigationController pushViewController:transactionRecordVC animated:YES];

    }else if (tableView == _consignmentTableView){
        
    
        MerchandiseViewController *merchandiseVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"MerchandiseViewController"];
        merchandiseVC.status = status;

        consignmentModel *model = _consignmentArr[indexPath.section];
        merchandiseVC.merchandiseId = model.item[indexPath.row][@"id"];
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        
        [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        
        [self.navigationController pushViewController:merchandiseVC animated:YES];
        
    }else if (tableView == _myTableView){
        
        PendingPaymentViewController *pendingPaymentVC = [[PendingPaymentViewController alloc]init];
        pendingPaymentVC.arr = selectArr;
        HomeModel *model = _homeArr[indexPath.row];
        if (homeType == 1) {
            
            pendingPaymentVC.type = @"1";
            pendingPaymentVC.salesId = model.SPID;
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
            [self.navigationController pushViewController:pendingPaymentVC animated:YES];
            
        }else if (homeType == 2){
            pendingPaymentVC.type = @"2";

            pendingPaymentVC.salesId = model.goods_id;

            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            
            [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
            
            [self.navigationController pushViewController:pendingPaymentVC animated:YES];

            
        }else if (homeType ==3){
            pendingPaymentVC.type = @"3";

            pendingPaymentVC.salesId = model.sales_id;

            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            
            [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
            [self.navigationController pushViewController:pendingPaymentVC animated:YES];
        }
        
    }else if (tableView == _timeSelectTableView){
    
        _timeSelectTableView.hidden = YES;
        
        if (!_booksView.hidden) {
            
            UIButton *bt = [self.view viewWithTag:800];
            UIButton *bt1 = [self.view viewWithTag:801];
            
            if (bt.selected) {
                [bt setTitle:_timeSelectArr[indexPath.row] forState:UIControlStateNormal];
            }else{
                [bt1 setTitle:_timeSelectArr[indexPath.row] forState:UIControlStateNormal];
            }
            bt.selected = NO;
            bt1.selected = NO;
            booksPage = 1;
            [_booksArr removeAllObjects];
            [self booksLoadData];
      }else{
        
          UIButton *bt = [self.view viewWithTag:700];
          UIButton *bt1 = [self.view viewWithTag:701];
        
          if (bt.selected) {
              [bt setTitle:_timeSelectArr[indexPath.row] forState:UIControlStateNormal];
          }else{
              [bt1 setTitle:_timeSelectArr[indexPath.row] forState:UIControlStateNormal];
          }
          bt.selected = NO;
          bt1.selected = NO;
          
          salesRecordsPage = 1;
          [_salesRecordsArr removeAllObjects];
          [self salesRecordsLoadData];
        }
    }else if (tableView == _booksTableView){
    
        
    
        
        BooksDetailsViewController *booksDetailsVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"BooksDetailsViewController"];

        BooksModel *model = _booksArr[indexPath.section];
        
        booksDetailsVC.booksId = model.item[indexPath.row][@"id"];
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        
        [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        
        [self.navigationController pushViewController:booksDetailsVC animated:YES];

        
    }
}

//接收通知

//首页

- (void)HomeAction{
    
    _timeSelectTableView.hidden = YES;
    _consignmentView.hidden = YES;
    _homeView.hidden = NO;
    _salesRecordsView.hidden = YES;
    _booksView.hidden = YES;
    _stockView.hidden = YES;
    //设置标题
    self.navigationItem.title = @"奢侈品店";
    
    //改变导航栏标题的字体颜色和大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏背景.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"导航栏背景.png"]];
    
    [leftBtn setImage:[UIImage imageNamed:@"侧滑按钮（44x30）"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"搜索按钮（44x44）1"] forState:UIControlStateNormal];
    [sectorButton setImage:[UIImage imageNamed:@"更多初始（130x130）.png"] forState:UIControlStateNormal];
    [sectorButton setImage:[UIImage imageNamed:@"更多点击（130x130）.png"] forState:UIControlStateSelected];
    
    
    self.navigationItem.rightBarButtonItems = nil;
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;

    //类型选择

    homePage1 = 1;
    homePage2 = 1;
    homePage3 = 1;
    
    [self homeLoadData];
    
}
//首页列表数据
- (void)homeLoadData{


    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    NSString *url = @"";
    
    if (homeType == 1) {
        url = uninput_sales_listhtml;
        [params setObject:[NSString stringWithFormat:@"%ld",homePage1] forKey:@"page"];
    }else if (homeType == 2){
        url = get_recovery_unpayhtml;
        [params setObject:[NSString stringWithFormat:@"%ld",homePage2] forKey:@"page"];
    }else if (homeType == 3){
        url = get_consihment_unpayhtml;
        [params setObject:[NSString stringWithFormat:@"%ld",homePage3] forKey:@"page"];
    }
    
    //列表数据
    [DataSeviece requestUrl:url params:params success:^(id result) {
        NSLog(@"%@",result);
        NSLog(@"%@",result[@"result"][@"msg"]);
        if (homeType == 1) {
            if (homePage1 == 1) {
                [_homeArr1 removeAllObjects];
            }
        }else if (homeType == 2){
            if (homePage2 == 1) {
                [_homeArr2 removeAllObjects];
            }
        }else{
            if (homePage3 == 1) {
                [_homeArr3 removeAllObjects];
            }
        }
        
        NSArray *arr = result[@"result"][@"data"][@"item"];
        if (arr.count == 0) {
            if (homeType == 1) {
                _homeArr = _homeArr1;
            }else if (homeType == 2){
                _homeArr = _homeArr2;
            }else{
                _homeArr = _homeArr3;
            }
            [_myTableView reloadData];
        }
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            NSDictionary *dic1 = [NULLHandle NUllHandle:dic];
            HomeModel *model = [[HomeModel alloc]initWithContentsOfDic:dic1];
            model.SPID = dic1[@"id"];
            if (homeType == 1) {
                [_homeArr1 addObject:model];
                _homeArr = _homeArr1;
            }else if (homeType == 2){
                [_homeArr2 addObject:model];
                _homeArr = _homeArr2;
            }else{
                [_homeArr3 addObject:model];
                _homeArr = _homeArr3;
            }
            [_myTableView reloadData];
        }
        
        [_myTableView.header endRefreshing];
        [_myTableView.footer endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [_myTableView.header endRefreshing];
        [_myTableView.footer endRefreshing];
    }];


}

//库存
- (void)StockAction{
    
    _timeSelectTableView.hidden = YES;
    _consignmentView.hidden = YES;
    _homeView.hidden = YES;
    _salesRecordsView.hidden = YES;
    _booksView.hidden = YES;
    _stockView.hidden = NO;
    //设置标题
    self.navigationItem.title = @"奢侈品店(库存)";
    
    //改变导航栏标题的字体颜色和大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"434b9b"]}];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"白色背景.png"]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"白色背景.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [leftBtn setImage:[UIImage imageNamed:@"侧栏按钮1（44x30）"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"搜索按钮1（44x44）.png"] forState:UIControlStateNormal];
    
    [sectorButton setImage:[UIImage imageNamed:@"更多点击（130x130）.png"] forState:UIControlStateNormal];
    [sectorButton setImage:[UIImage imageNamed:@"更多初始（130x130）.png"] forState:UIControlStateSelected];
    self.navigationItem.rightBarButtonItems = nil;

    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    

    //类型选择
    
    [self selectTypeLoadData];
    stockPage1 = 1;
    stockPage2 = 1;
    stockPage3 = 1;

    [_storkDataArr1 removeAllObjects];
    [_storkDataArr2 removeAllObjects];
    [_storkDataArr3 removeAllObjects];

    [self stockLoadData];
}
//库存数据加载
- (void)stockLoadData{


    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    [params setObject:stockType forKey:@"type"];
    [params setObject:SYGData[@"id"] forKey:@"uid"];

    
    if ([stockType isEqualToString:@"HS"]) {
        [params setObject:[NSString stringWithFormat:@"%ld",stockPage2] forKey:@"page"];
       
    }else if ([stockType isEqualToString:@"JM"]){
        [params setObject:[NSString stringWithFormat:@"%ld",stockPage3] forKey:@"page"];
    }else{
        
        [params setObject:[NSString stringWithFormat:@"%ld",stockPage1] forKey:@"page"];
    }

    //列表数据
    [DataSeviece requestUrl:get_goods_listhtml params:params success:^(id result) {
        NSLog(@"%@",result);
        
        if ([stockType isEqualToString:@"HS"]) {
            if (stockPage2 == 1) {
                [_storkDataArr2 removeAllObjects];
            }
        }else if ([stockType isEqualToString:@"JM"]){
            if (stockPage3 == 1) {
                [_storkDataArr3 removeAllObjects];
            }
        }else{
            if (stockPage1 == 1) {
                [_storkDataArr1 removeAllObjects];
            }
        }
        
        NSArray *arr = result[@"result"][@"data"][@"item"];
        if (arr.count == 0) {
            if ([stockType isEqualToString:@"HS"]) {
                _storkDataArr = _storkDataArr2;
            }else if ([stockType isEqualToString:@"JM"]){
                _storkDataArr = _storkDataArr3;
            }else{
                _storkDataArr = _storkDataArr1;
            }
            [_stockTableView reloadData];
        }
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            NSDictionary *dic1 = [NULLHandle NUllHandle:dic];
            StockModel *model = [[StockModel alloc]initWithContentsOfDic:dic1];
            model.SPID = dic1[@"id"];
            if ([stockType isEqualToString:@"HS"]) {
                [_storkDataArr2 addObject:model];
                _storkDataArr = _storkDataArr2;
            }else if ([stockType isEqualToString:@"JM"]){
                [_storkDataArr3 addObject:model];
                _storkDataArr = _storkDataArr3;
            }else{
                [_storkDataArr1 addObject:model];
                _storkDataArr = _storkDataArr1;
            }
            [_stockTableView reloadData];
        }
        NSLog(@"%ld",_storkDataArr.count);
        
        [_stockTableView.header endRefreshing];
        [_stockTableView.footer endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [_stockTableView.header endRefreshing];
        [_stockTableView.footer endRefreshing];
    }];
    
    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];

    [params1 setObject:SYGData[@"id"] forKey:@"uid"];

    //总数据
    [DataSeviece requestUrl:get_goods_input_outhtml params:params1 success:^(id result) {
        
        NSLog(@"%@",result);
     
        float input = [result[@"result"][@"data"][@"day_goods_input"] floatValue] - [result[@"result"][@"data"][@"preday_goods_input"] floatValue];
        
        NSInteger _out = [result[@"result"][@"data"][@"day_goods_out"] floatValue] - [result[@"result"][@"data"][@"preday_goods_out"] floatValue];
        
        
        UIImageView *image1 = [self.view viewWithTag:6007];
        UIImageView *image2 = [self.view viewWithTag:6008];
        
        if (input > 0) {
            image1.image = [UIImage imageNamed:@"上涨（30x42）.png"];
        }else{
            image1.image = [UIImage imageNamed:@"下跌（30x42）.png"];
        }
        
        if (_out > 0) {
            image2.image = [UIImage imageNamed:@"上涨（30x42）.png"];
        }else{
            image2.image = [UIImage imageNamed:@"下跌（30x42）.png"];
        }

        
        for (int i = 1; i<7; i++) {
            
            UILabel *label = [self.view viewWithTag:6000+i];
            
            if (i == 1) {
                label.text = [NSString stringWithFormat:@"%@件",result[@"result"][@"data"][@"day_goods_input"]];
            }else if (i == 2){
                label.text = [NSString stringWithFormat:@"%@件",result[@"result"][@"data"][@"day_goods_out"]];
            }else if (i == 3){
                if (input == 0) {
                    label.text = @"0%";
                }else if ([result[@"result"][@"data"][@"preday_goods_input"] floatValue] == 0||[result[@"result"][@"data"][@"day_goods_input"] floatValue] == 0){
                    label.text = @"100%";
                }else if (input > 0){
                    label.textColor = [RGBColor colorWithHexString:@"#ffc000"];
                    label.text = [NSString stringWithFormat:@"%.0lf%%",([result[@"result"][@"data"][@"day_goods_input"] floatValue] - [result[@"result"][@"data"][@"preday_goods_input"] floatValue])/[result[@"result"][@"data"][@"preday_goods_input"] floatValue]*100];
                }else if (input < 0){
                    label.textColor = [RGBColor colorWithHexString:@"#0071b8"];

                    label.text = [NSString stringWithFormat:@"%.0lf%%",([result[@"result"][@"data"][@"preday_goods_input"] floatValue] - [result[@"result"][@"data"][@"day_goods_input"] floatValue])/[result[@"result"][@"data"][@"preday_goods_input"] floatValue]*100];
                }


            }else if (i == 4){
                if (_out == 0) {
                    label.text = @"0%";
                }else if ([result[@"result"][@"data"][@"preday_goods_out"] floatValue] == 0||[result[@"result"][@"data"][@"day_goods_out"] floatValue] == 0){
                    label.text = @"100%";
                }else if (_out > 0){
                    label.textColor = [RGBColor colorWithHexString:@"#ffc000"];
                    label.text = [NSString stringWithFormat:@"%.0lf%%",([result[@"result"][@"data"][@"day_goods_out"] floatValue] - [result[@"result"][@"data"][@"preday_goods_out"] floatValue])/[result[@"result"][@"data"][@"preday_goods_out"] floatValue]*100];
                }else if (_out < 0){
                    label.textColor = [RGBColor colorWithHexString:@"#0071b8"];
                    label.text = [NSString stringWithFormat:@"%.0lf%%",([result[@"result"][@"data"][@"preday_goods_out"] floatValue] - [result[@"result"][@"data"][@"day_goods_out"] floatValue])/[result[@"result"][@"data"][@"preday_goods_out"] floatValue]*100];
                }

            }else if (i == 5){
                label.text = [NSString stringWithFormat:@"%@件",result[@"result"][@"data"][@"goods_total"]];
                

            }else if (i == 6){
                label.text = [NSString stringWithFormat:@"%ld",[result[@"result"][@"data"][@"goods_total_amount"] integerValue]];
            }
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    NSMutableDictionary *params2 = [NSMutableDictionary dictionary];
    
    NSLog(@"%@",SYGData);
    
    [params2 setObject:stockType forKey:@"type"];
    [params2 setObject:SYGData[@"id"] forKey:@"uid"];
    [params2 setObject:SYGData[@"shop_id"] forKey:@"shop_id"];

    NSLog(@"%@",params2);
    //列表数据
    [DataSeviece requestUrl:goods_counthtml params:params2 success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        if ([stockType isEqualToString:@"HS"]) {
            
            UIButton *button = [self.view viewWithTag:601];
            
            [button setTitle:[NSString stringWithFormat:@"回收(%@)",result[@"result"][@"data"]] forState:UIControlStateNormal];
            
            
        }else if ([stockType isEqualToString:@"JM"]){
            UIButton *button = [self.view viewWithTag:602];
            
            [button setTitle:[NSString stringWithFormat:@"寄卖(%@)",result[@"result"][@"data"]] forState:UIControlStateNormal];
            
        }else{
            
            UIButton *button = [self.view viewWithTag:600];
            
            [button setTitle:[NSString stringWithFormat:@"全部(%@)",result[@"result"][@"data"]] forState:UIControlStateNormal];
            
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

    
    
}


//销售记录
- (void)salesRecordsAction{
    
    _consignmentView.hidden = YES;
    _homeView.hidden = YES;
    _stockView.hidden = YES;
    _booksView.hidden = YES;
    _salesRecordsView.hidden = NO;
    //设置标题
    self.navigationItem.title = @"奢侈品店(销售记录)";
    
    //改变导航栏标题的字体颜色和大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"434b9b"]}];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"白色背景.png"]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"白色背景.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [leftBtn setImage:[UIImage imageNamed:@"侧栏按钮1（44x30）"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"搜索按钮1（44x44）.png"] forState:UIControlStateNormal];
    
    [sectorButton setImage:[UIImage imageNamed:@"更多点击（130x130）.png"] forState:UIControlStateNormal];
    [sectorButton setImage:[UIImage imageNamed:@"更多初始（130x130）.png"] forState:UIControlStateSelected];
    self.navigationItem.rightBarButtonItems = nil;

    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    

    //类型选择
    
    [self selectTypeLoadData];

    [_salesRecordsArr removeAllObjects];
    salesRecordsPage = 1;
    [self salesRecordsLoadData];

    [self salesRecordsLoadData1];
    
}
//销售记录数据加载
- (void)salesRecordsLoadData{

    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    UIButton *bt = [self.view viewWithTag:700];
    UIButton *bt1 = [self.view viewWithTag:701];

    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    NSString *dateString1 = [dateFormatter stringFromDate:currentDate];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"YYYY年"];
    NSString *dateString2 = [dateFormatter1 stringFromDate:currentDate];
    
    NSString *month = [NSString stringWithFormat:@"%ld月",(long)[dateString1 integerValue]];

    NSString *yearStr = [bt.titleLabel.text substringWithRange:NSMakeRange(0, [bt.titleLabel.text length] - 1)];
    NSString *datStr = [bt1.titleLabel.text substringWithRange:NSMakeRange(0, [bt1.titleLabel.text length] - 1)];
    [params setObject:[NSString stringWithFormat:@"%ld",salesRecordsPage] forKey:@"page"];
    
    if ([month isEqualToString:bt1.titleLabel.text]&&[dateString2 isEqualToString:bt.titleLabel.text]) {
        
    }else{
        [params setObject:[NSString stringWithFormat:@"%@-%@",yearStr,datStr] forKey:@"date"];
    }
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [DataSeviece requestUrl:get_sales_list_by_timehtml params:params success:^(id result) {
        NSLog(@"%@",result);
        

        for (int i = 0; i < 10; i++) {
            
            UILabel *label = [self.view viewWithTag:7000+i];
           if (i == 4){
                label.text = [NSString stringWithFormat:@"¥%@",result[@"result"][@"data"][@"month_sales_total_price"]];
            }else if (i == 5){
//                if ([result[@"result"][@"data"][@"month_sales_total_price"] floatValue] == 0) {
//                    label.text = @"￥0";
//                }else{
//                    label.text =
//                    label.text = [NSString stringWithFormat:@"¥%.2lf%%",[result[@"result"][@"data"][@"month_sales_total_profit"] floatValue] / [result[@"result"][@"data"][@"month_sales_total_price"] floatValue]*100];
//                }
                
                label.text = [NSString stringWithFormat:@"¥%@",result[@"result"][@"data"][@"month_sales_total_profit"]];

            }else if (i == 8){
            
                label.text = [NSString stringWithFormat:@"%@月销售额",datStr];
                
            }else if (i == 9){
            
                label.text = [NSString stringWithFormat:@"%@月利润",datStr];
            }
        }
        
        if (salesRecordsPage == 1) {
            [_salesRecordsArr removeAllObjects];
        }
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            NSDictionary *dic1 = [NULLHandle NUllHandle:dic];
            SalesRecordsModel *model = [[SalesRecordsModel alloc]initWithContentsOfDic:dic1];
            [_salesRecordsArr addObject:model];
        }
        [_salesRecordsTableView reloadData];
        [_salesRecordsTableView.header endRefreshing];
        [_salesRecordsTableView.footer endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [_salesRecordsTableView.header endRefreshing];
        [_salesRecordsTableView.footer endRefreshing];
    }];

}
//销售利润统计
- (void)salesRecordsLoadData1{

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
    
    [params1 setObject:SYGData[@"id"] forKey:@"uid"];
    
    
    [DataSeviece requestUrl:get_sales_statisticshtml params:params1 success:^(id result) {
        NSLog(@"%@",result);
        
        float input = [result[@"result"][@"data"][@"day_sales_total_profit"] floatValue] - [result[@"result"][@"data"][@"preday_sales_total_profit"] floatValue];
        
        NSInteger _out = [result[@"result"][@"data"][@"day_sales_total_price"] floatValue] - [result[@"result"][@"data"][@"preday_sales_total_price"] floatValue];
        
        UIImageView *image1 = [self.view viewWithTag:7006];
        UIImageView *image2 = [self.view viewWithTag:7007];
        
        if (input > 0) {
            image1.image = [UIImage imageNamed:@"上涨（30x42）.png"];
        }else{
            image1.image = [UIImage imageNamed:@"下跌（30x42）.png"];
        }
        
        if (_out > 0) {
            image2.image = [UIImage imageNamed:@"上涨（30x42）.png"];
        }else{
            image2.image = [UIImage imageNamed:@"下跌（30x42）.png"];
        }
        
        for (int i = 0; i<6; i++) {
            
            UILabel *label = [self.view viewWithTag:7000+i];
            
            if (i == 0) {
                label.text = [NSString stringWithFormat:@"¥%@",result[@"result"][@"data"][@"day_sales_total_profit"]];
            }else if (i == 1){
                label.text = [NSString stringWithFormat:@"¥%@",result[@"result"][@"data"][@"day_sales_total_price"]];
            }else if (i == 2){
                if (input == 0) {
                    label.text = @"0%";
                }else if ([result[@"result"][@"data"][@"preday_sales_total_profit"] floatValue] == 0||[result[@"result"][@"data"][@"day_sales_total_profit"] floatValue] == 0){
                    label.text = @"100%";
                }else if (input > 0){
                    label.textColor = [RGBColor colorWithHexString:@"#ffc000"];
                    int a = ([result[@"result"][@"data"][@"day_sales_total_profit"] floatValue] - [result[@"result"][@"data"][@"preday_sales_total_profit"] floatValue])/[result[@"result"][@"data"][@"preday_sales_total_profit"] floatValue]*100;
                    a = abs(a);
                    
                    label.text = [NSString stringWithFormat:@"%d%%",a];
                }else if (input < 0){
                    label.textColor = [RGBColor colorWithHexString:@"#0071b8"];
                    int a = ([result[@"result"][@"data"][@"preday_sales_total_profit"] floatValue] - [result[@"result"][@"data"][@"day_sales_total_profit"] floatValue])/[result[@"result"][@"data"][@"preday_sales_total_profit"] floatValue]*100;
                    a = abs(a);
                    label.text = [NSString stringWithFormat:@"%d%%",a];

                }

            }else if (i == 3){
                
                if (_out == 0) {
                    label.text = @"0%";
                }else if ([result[@"result"][@"data"][@"day_sales_total_price"] floatValue] == 0||[result[@"result"][@"data"][@"preday_sales_total_price"] floatValue] == 0){
                    label.text = @"100%";
                }else if (_out > 0){
                    label.textColor = [RGBColor colorWithHexString:@"#ffc000"];
                    
                    label.text = [NSString stringWithFormat:@"%.0lf%%",([result[@"result"][@"data"][@"day_sales_total_price"] floatValue] - [result[@"result"][@"data"][@"preday_sales_total_price"] floatValue])/[result[@"result"][@"data"][@"preday_sales_total_price"] floatValue]*100];
                }else if (_out < 0){
                    label.textColor = [RGBColor colorWithHexString:@"#0071b8"];
                    
                    label.text = [NSString stringWithFormat:@"%.0lf%%",([result[@"result"][@"data"][@"preday_sales_total_price"] floatValue] -[result[@"result"][@"data"][@"day_sales_total_price"] floatValue])/[result[@"result"][@"data"][@"preday_sales_total_price"] floatValue]*100];
                }

            }else if (i == 4){
                label.text = [NSString stringWithFormat:@"¥%@",result[@"result"][@"data"][@"month_sales_total_price"]];
            }else if (i == 5){
//                if ([result[@"result"][@"data"][@"month_sales_total_price"] floatValue] == 0) {
//                    label.text = @"0%";
//                }else{
//                
//                label.text = [NSString stringWithFormat:@"¥%.2lf%%",[result[@"result"][@"data"][@"month_sales_total_profit"] floatValue] / [result[@"result"][@"data"][@"month_sales_total_price"] floatValue]*100];
//                }
                label.text = [NSString stringWithFormat:@"¥%@",result[@"result"][@"data"][@"month_sales_total_profit"]];
            }
        }
        
    } failure:^(NSError *error) {

        NSLog(@"%@",error);
        
    }];

}

//账本
- (void)BooksAction{
    
    _timeSelectTableView.hidden = YES;
    _consignmentView.hidden = YES;
    _homeView.hidden = YES;
    _salesRecordsView.hidden = YES;
    _booksView.hidden = NO;
    _stockView.hidden = YES;
    //设置标题
    self.navigationItem.title = @"奢侈品店(账本)";
    
    //改变导航栏标题的字体颜色和大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景框.png"]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"背景框.png"] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景框.png"]];
    [leftBtn setImage:[UIImage imageNamed:@"侧滑按钮（44x30）.png"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"搜索按钮（44x44）.png"] forState:UIControlStateNormal];
    [sectorButton setImage:[UIImage imageNamed:@"更多初始.png"] forState:UIControlStateNormal];
    [sectorButton setImage:[UIImage imageNamed:@"更多点击.png"] forState:UIControlStateSelected];
    
    right2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    right2.frame = CGRectMake(0, 0, 23, 15);
    
    [right2 addTarget:self action:@selector(right2Action:) forControlEvents:UIControlEventTouchUpInside];
    
    [right2 setImage:[UIImage imageNamed:@"zhanshi@2x"] forState:UIControlStateNormal];
    [right2 setImage:[UIImage imageNamed:@"yincang@2x"] forState:UIControlStateSelected];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    

    
    if ([[defaults objectForKey:[NSString stringWithFormat:@"%@switch",SYGData[@"id"]]] isEqualToString:@"1"]) {
        
        right2.selected = YES;
        
    }else{
        
        right2.selected = NO;
        
    }

    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];

    UIBarButtonItem *rightButtonItem1 = [[UIBarButtonItem alloc]initWithCustomView:right2];
    
    self.navigationItem.rightBarButtonItems = @[rightButtonItem,rightButtonItem1];
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = 20;
    self.navigationItem.rightBarButtonItems = @[rightButtonItem,negativeSpacer,rightButtonItem1];
    
    [_booksArr removeAllObjects];
    [_booksTableView reloadData];
    booksPage = 1;
    
    [self booksLoadData];
    
    [self booksLoadData1];
    
}

//密码查看
- (void)right2Action:(UIButton*)bt{



    if (bt.selected == NO) {
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        alertV.alertViewStyle = UIAlertViewStyleSecureTextInput;
        
        [alertV show];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
   
    
    UITextField *tf = [alertView textFieldAtIndex:0];
    
    
    [MD5CommonDigest MD5:tf.text success:^(id result) {
        
        NSLog(@"%@",result);
        
        if ([result isEqualToString:@"1"]) {
            
            [_booksTableView reloadData];
            _booksTableView.hidden = NO;
            
            for (int i = 1; i<4; i++) {
                
                UILabel *label = [self.view viewWithTag:8000+i];
                
                if (i == 1) {
                    label.text = [NSString stringWithFormat:@"¥%ld",[_booksDic[@"total_input"] integerValue]];
                }else if (i == 2){
                    label.text = [NSString stringWithFormat:@"¥%ld",[_booksDic[@"total_out"] integerValue]];
                }else if (i == 3){
                    label.text = [NSString stringWithFormat:@"¥%.0lf",[_booksDic[@"total_input"] floatValue] - [_booksDic[@"total_out"] floatValue]];
                }
            }
            right2.selected = YES;

            
        }else{
            UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alertV show];
            
        }
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];

    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
//    
//    UITextField *tf = [alertView textFieldAtIndex:0];
//    
//    if ([SYGData[@"password"] isEqualToString:tf.text]) {
//        
//        [_booksTableView reloadData];
//        _booksTableView.hidden = NO;
//
//        for (int i = 1; i<4; i++) {
//            
//            UILabel *label = [self.view viewWithTag:8000+i];
//            
//            if (i == 1) {
//                label.text = [NSString stringWithFormat:@"¥%ld",[_booksDic[@"total_input"] integerValue]];
//            }else if (i == 2){
//                label.text = [NSString stringWithFormat:@"¥%ld",[_booksDic[@"total_out"] integerValue]];
//            }else if (i == 3){
//                label.text = [NSString stringWithFormat:@"¥%.0lf",[_booksDic[@"total_input"] floatValue] - [_booksDic[@"total_out"] floatValue]];
//            }
//        }
//        right2.selected = YES;
//    }else{
//        
//        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        
//        [alertV show];
//        
//    }
    
    
}


//账本数据列表
- (void)booksLoadData{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    UIButton *bt = [self.view viewWithTag:800];
    
    UIButton *bt1 = [self.view viewWithTag:801];
    
    NSString *yearStr = [bt.titleLabel.text substringWithRange:NSMakeRange(0, [bt.titleLabel.text length] - 1)];
    NSString *datStr = [bt1.titleLabel.text substringWithRange:NSMakeRange(0, [bt1.titleLabel.text length] - 1)];
    [params setObject:[NSString stringWithFormat:@"%ld",booksPage] forKey:@"page"];
    [params setObject:datStr forKey:@"month"];
    [params setObject:yearStr forKey:@"year"];
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [DataSeviece requestUrl:pay_log_recordhtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        if (booksPage == 1) {
            [_booksArr removeAllObjects];
        }
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            NSDictionary *dic1 = [NULLHandle NUllHandle:dic];
            BooksModel *model = [[BooksModel alloc]initWithContentsOfDic:dic1];
            model.out1 = dic1[@"out"];
            [_booksArr addObject:model];
        }
        
        [_booksTableView.header endRefreshing];
        [_booksTableView.footer endRefreshing];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
        
        if (booksPage == 1) {
            
            if ([[defaults objectForKey:[NSString stringWithFormat:@"%@switch",SYGData[@"id"]]] isEqualToString:@"1"]) {
                
                [_booksTableView reloadData];
                _booksTableView.hidden = NO;
                
            }else{
                
                UILabel *label = [self.view viewWithTag:8001];

                if ([label.text isEqualToString: [NSString stringWithFormat:@"¥%ld",[_booksDic[@"total_input"] integerValue]]]) {
                    _booksTableView.hidden = NO;
                    [_booksTableView reloadData];

                }else{
                    _booksTableView.hidden = YES;
                }
            }
        }else{
        
            [_booksTableView reloadData];
            _booksTableView.hidden = NO;
        }

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [_booksTableView.header endRefreshing];
        [_booksTableView.footer endRefreshing];
    }];
    
}
//账本统计数据
- (void)booksLoadData1{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
    
    [params1 setObject:SYGData[@"id"] forKey:@"uid"];
    
    
    [DataSeviece requestUrl:get_input_payhtml params:params1 success:^(id result) {
        NSLog(@"%@",result);
        
        
        if ([[defaults objectForKey:[NSString stringWithFormat:@"%@switch",SYGData[@"id"]]] isEqualToString:@"1"]) {
            
            for (int i = 1; i<4; i++) {
                
                UILabel *label = [self.view viewWithTag:8000+i];
                
                if (i == 1) {
                    label.text = [NSString stringWithFormat:@"¥%ld",[result[@"result"][@"data"][@"total_input"] integerValue]];
                }else if (i == 2){
                    label.text = [NSString stringWithFormat:@"¥%ld",[result[@"result"][@"data"][@"total_out"] integerValue]];
                }else if (i == 3){
                    label.text = [NSString stringWithFormat:@"¥%.0lf",[result[@"result"][@"data"][@"total_input"] floatValue] - [result[@"result"][@"data"][@"total_out"] floatValue]];
                }
            }

        }else{
            _booksDic = [NULLHandle NUllHandle:result[@"result"][@"data"]] ;
            for (int i = 1; i<4; i++) {
                
                UILabel *label = [self.view viewWithTag:8000+i];
                
                if (i == 1) {
                    label.text = @"*****";
                }else if (i == 2){
                    label.text = @"*****";
                }else if (i == 3){
                    label.text = @"*****";
                }
            }

            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];


}

//寄卖管理
- (void)ConsignmentAction{
    _timeSelectTableView.hidden = YES;
    _homeView.hidden = YES;
    _salesRecordsView.hidden = YES;
    _booksView.hidden = YES;
    _stockView.hidden = YES;
    _consignmentView.hidden = NO;
    //设置标题
    self.navigationItem.title = @"奢侈品店(寄卖情况)";
    
    //改变导航栏标题的字体颜色和大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"026fbb"]}];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"白色背景.png"]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"白色背景.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [leftBtn setImage:[UIImage imageNamed:@"侧栏按钮2"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"搜索2"] forState:UIControlStateNormal];
    [sectorButton setImage:[UIImage imageNamed:@"更多点击（130x130）.png"] forState:UIControlStateNormal];
    [sectorButton setImage:[UIImage imageNamed:@"更多初始（130x130）.png"] forState:UIControlStateSelected];
    self.navigationItem.rightBarButtonItems = nil;

    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    

    //类型选择
    
    [self selectTypeLoadData];

    
    [self consignmentLoadData];
    [_consignmentArr1 removeAllObjects];
    [_consignmentArr2 removeAllObjects];
    [_consignmentArr3 removeAllObjects];
    [_consignmentArr4 removeAllObjects];
    [_consignmentArr5 removeAllObjects];
    [_consignmentArr6 removeAllObjects];
    [_consignmentArr7 removeAllObjects];
    [_consignmentArr8 removeAllObjects];

    consignmentPage1 = 1;
    consignmentPage2 = 1;
    consignmentPage3 = 1;
    consignmentPage4 = 1;
    consignmentPage5 = 1;
    consignmentPage6 = 1;
    consignmentPage7 = 1;
    consignmentPage8 = 1;
    
    group  = @"time";
    status = @"1";
    
    for (int i = 0; i < 4; i++) {
        
        UIButton *bt = [self.view viewWithTag:900+i];
        if (i == 0) {
            bt.selected = YES;
            _selectButton2 = bt;
            _selectImageV2.center = _selectButton2.center;
            
        }else{
            bt.selected = NO;
        }
        
    }
    
    for (int i = 0; i < 2; i++) {
        
        UIButton *bt = [self.view viewWithTag:1000+i];
        if (i == 0) {
            bt.selected = YES;
            _selectButton3 = bt;
            _selectImageV3.center = _selectButton3.center;
            
        }else{
            bt.selected = NO;
        }
        
    }

    
    [self consignmentLoadData1];

}
//寄卖管理列表数据
- (void)consignmentLoadData1{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    [params setObject:status forKey:@"status"];
    [params setObject:group forKey:@"group"];

    if ([group isEqualToString:@"time"]) {
        if ([status isEqualToString:@"1"]) {
            [params setObject:[NSString stringWithFormat:@"%ld",consignmentPage1] forKey:@"page"];
        }else if ([status isEqualToString:@"4"]){
            [params setObject:[NSString stringWithFormat:@"%ld",consignmentPage3] forKey:@"page"];
        }else if ([status isEqualToString:@"2"]){
            [params setObject:[NSString stringWithFormat:@"%ld",consignmentPage5] forKey:@"page"];
        }else if ([status isEqualToString:@"3"]){
            [params setObject:[NSString stringWithFormat:@"%ld",consignmentPage7] forKey:@"page"];
        }

    }else if ([group isEqualToString:@"customer"]){
        if ([status isEqualToString:@"1"]) {
            [params setObject:[NSString stringWithFormat:@"%ld",consignmentPage2] forKey:@"page"];
        }else if ([status isEqualToString:@"4"]){
            [params setObject:[NSString stringWithFormat:@"%ld",consignmentPage4] forKey:@"page"];
        }else if ([status isEqualToString:@"2"]){
            [params setObject:[NSString stringWithFormat:@"%ld",consignmentPage6] forKey:@"page"];
        }else if ([status isEqualToString:@"3"]){
            [params setObject:[NSString stringWithFormat:@"%ld",consignmentPage8] forKey:@"page"];
        }
    }
    [DataSeviece requestUrl:get_consighment_listhtml params:params success:^(id result) {
        NSLog(@"%@",result);
        
        if ([group isEqualToString:@"time"]) {
            if ([status isEqualToString:@"1"]) {
                if (consignmentPage1 == 1) {
                    [_consignmentArr1 removeAllObjects];
                }
            }else if ([status isEqualToString:@"4"]){
                if (consignmentPage3 == 1) {
                    [_consignmentArr3 removeAllObjects];
                }
            }else if ([status isEqualToString:@"2"]){
                if (consignmentPage5 == 1) {
                    [_consignmentArr5 removeAllObjects];
                }
            }else if ([status isEqualToString:@"3"]){
                if (consignmentPage7 == 1) {
                    [_consignmentArr7 removeAllObjects];
                }
            }
            
        }else if ([group isEqualToString:@"customer"]){
            if ([status isEqualToString:@"1"]) {
                if (consignmentPage2 == 1) {
                    [_consignmentArr2 removeAllObjects];
                }
            }else if ([status isEqualToString:@"4"]){
                if (consignmentPage4 == 1) {
                    [_consignmentArr4 removeAllObjects];
                }
            }else if ([status isEqualToString:@"2"]){
                if (consignmentPage6 == 1) {
                    [_consignmentArr6 removeAllObjects];
                }
            }else if ([status isEqualToString:@"3"]){
                if (consignmentPage8 == 1) {
                    [_consignmentArr8 removeAllObjects];
                }
            }
        }
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            
            consignmentModel *model = [[consignmentModel alloc]initWithContentsOfDic:dic];
            

            
            if ([group isEqualToString:@"time"]) {
                if ([status isEqualToString:@"1"]) {
                    [_consignmentArr1 addObject:model];
                }else if ([status isEqualToString:@"4"]){
                    [_consignmentArr3 addObject:model];
                }else if ([status isEqualToString:@"2"]){
                    [_consignmentArr5 addObject:model];
                }else if ([status isEqualToString:@"3"]){
                    [_consignmentArr7 addObject:model];
                }
                
            }else if ([group isEqualToString:@"customer"]){
                if ([status isEqualToString:@"1"]) {
                    [_consignmentArr2 addObject:model];
                }else if ([status isEqualToString:@"4"]){
                    [_consignmentArr4 addObject:model];
                }else if ([status isEqualToString:@"2"]){
                    [_consignmentArr6 addObject:model];
                }else if ([status isEqualToString:@"3"]){
                    [_consignmentArr8 addObject:model];
                }
            }
        }
        if ([group isEqualToString:@"time"]) {
            if ([status isEqualToString:@"1"]) {
                _consignmentArr = _consignmentArr1;
            }else if ([status isEqualToString:@"4"]){
                _consignmentArr = _consignmentArr3;
            }else if ([status isEqualToString:@"2"]){
                _consignmentArr = _consignmentArr5;
            }else if ([status isEqualToString:@"3"]){
                _consignmentArr = _consignmentArr7;
            }
            
        }else if ([group isEqualToString:@"customer"]){
            if ([status isEqualToString:@"1"]) {
                _consignmentArr = _consignmentArr2;
            }else if ([status isEqualToString:@"4"]){
                _consignmentArr = _consignmentArr4;
            }else if ([status isEqualToString:@"2"]){
                _consignmentArr = _consignmentArr6;
            }else if ([status isEqualToString:@"3"]){
                _consignmentArr = _consignmentArr8;
            }
        }
        [_consignmentTableView reloadData];
        [_consignmentTableView.header endRefreshing];
        [_consignmentTableView.footer endRefreshing];

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [_consignmentTableView.header endRefreshing];
        [_consignmentTableView.footer endRefreshing];

    }];
    
    
    
}

//寄卖管理统计数据
- (void)consignmentLoadData{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
    
    [params1 setObject:SYGData[@"id"] forKey:@"uid"];
    
    
    
    [DataSeviece requestUrl:get_consighment_statisticshtml params:params1 success:^(id result) {
        NSLog(@"%@",result);
        
        for (int i = 1; i<5; i++) {
            
            UILabel *label = [self.view viewWithTag:9000+i];
            
            if (i == 1) {
                label.text = [NSString stringWithFormat:@"¥%@",result[@"result"][@"data"][@"consighment_total_paying"]];
            }else if (i == 2){
                label.text = [NSString stringWithFormat:@"%@件",result[@"result"][@"data"][@"consighment_goods_total"]];
            }else if (i == 3){
                label.text = [NSString stringWithFormat:@"%@单",result[@"result"][@"data"][@"consighment_nums"]];
            }else if (i == 4){
                label.text = [NSString stringWithFormat:@"%ld",[result[@"result"][@"data"][@"consighment_total_commission"] integerValue]];
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}


- (void)BackNotificationAction{
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModePanningCenterView];

    if (!_homeView.hidden) {
        
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:18],
           NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏背景.png"] forBarMetrics:UIBarMetricsDefault];
    
    }else if (!_salesRecordsView.hidden){

        //改变导航栏标题的字体颜色和大小
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:18],
           NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"434b9b"]}];
        
        self.navigationController.navigationBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"白色背景.png"]];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"白色背景.png"] forBarMetrics:UIBarMetricsDefault];
        
    }else if (!_booksView.hidden){
        //改变导航栏标题的字体颜色和大小
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:18],
           NSForegroundColorAttributeName:[UIColor whiteColor]}];
        self.navigationController.navigationBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景框.png"]];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"背景框.png"] forBarMetrics:UIBarMetricsDefault];
        
    }else if (!_stockView.hidden){
        //改变导航栏标题的字体颜色和大小
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:18],
           NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"434b9b"]}];
        
        self.navigationController.navigationBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"白色背景.png"]];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"白色背景.png"] forBarMetrics:UIBarMetricsDefault];
    }else if (!_consignmentView.hidden){
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:18],
           NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"026fbb"]}];
        
        self.navigationController.navigationBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"白色背景.png"]];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"白色背景.png"] forBarMetrics:UIBarMetricsDefault];

    }

}

//跳转账号管理
- (void)PresentAction{

    //账号管理
    
    
    ManagementViewController *managementVC = [[UIStoryboard storyboardWithName:@"Share" bundle:nil] instantiateViewControllerWithIdentifier:@"ManagementViewController"];
    
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:managementVC];
    
    [self presentViewController:navi animated:YES completion:^{
        
      
    }];

    

}

//移除通知
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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

            selectArr = result[@"result"][@"data"][@"item"];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
    UITextField *textF = [_homeView viewWithTag:888];
    
    [textF resignFirstResponder];

}


- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        
        if ([view isKindOfClass:[StorageView class]]) {
            
            [view removeFromSuperview];
        }
        
    }
    
}

@end
