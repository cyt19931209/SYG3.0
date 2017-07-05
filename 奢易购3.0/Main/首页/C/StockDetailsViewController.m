//
//  StockDetailsViewController.m
//  奢易购3.0
//
//  Created by guest on 16/7/21.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "StockDetailsViewController.h"
#import "AppDelegate.h"
#import "StockCellectionCell.h"
#import "StockPriceViewController.h"
#import "StorageViewController.h"
#import "SFJLView.h"
#import "JMJLView.h"
#import "HSJLView.h"
#import "BooksDetailsViewController.h"
#import "ScanViewController.h"
#import "EditRemarkViewController.h"
#import "MBProgressHUD.h"
#import "EditSNViewController.h"
#import "PaymentTwoViewController.h"
#import "CustomerInformationViewController.h"
#import "SticksViewController.h"
#import "OneButtonPublishingViewController.h"


@interface StockDetailsViewController ()<UICollectionViewDataSource,UIAlertViewDelegate>{

    NSDictionary *dataDic;
    NSInteger index;

    UIView *bgView;

    NSString *KHId;

    NSDictionary *KHDic;
    
    //收付记录
    SFJLView *sfjlV;

    //寄卖记录
    JMJLView *jmjlV;
    
    //回收记录
    
    HSJLView *hsjlV;
    
    
    UIAlertView *alertV1;
    UIAlertView *alertV2;
    UIAlertView *alertV3;
    
    UIView *XSXXView;
    
    UILabel *KHXZLabel;
    
    UILabel *XSJSRLabel;
    
    BOOL isEdit;
    
    NSInteger BQCellHeight;
    
    NSArray *colorArr;
    
    NSMutableDictionary *colorDic;
    
    NSInteger NumberCellHeight;
    
    NSInteger TextCellHeight;

}

@property (nonatomic,strong) NSMutableArray *BQArr;

@property (weak, nonatomic) IBOutlet UITableViewCell *BQCell;


@property (weak, nonatomic) IBOutlet UITableViewCell *NumberCell;


@property (weak, nonatomic) IBOutlet UITableViewCell *TextCell;


@property (weak, nonatomic) IBOutlet UITextField *RKJSRLabel;
@property (weak, nonatomic) IBOutlet UIButton *XSJSRButton;
@property (nonatomic,strong) NSDictionary *XSJSRDic;
@property (weak, nonatomic) IBOutlet UIButton *SFJLButton;
@property (weak, nonatomic) IBOutlet UIButton *JMJLBUtton;
@property (weak, nonatomic) IBOutlet UIButton *HSJLButton;


@property (weak, nonatomic) IBOutlet UICollectionView *stockCollectionView;

@property (nonatomic,strong) NSMutableArray *dataArr;


@property (weak, nonatomic) IBOutlet UILabel *SPBHLabel;
@property (weak, nonatomic) IBOutlet UITextField *SPMCTextField;
@property (weak, nonatomic) IBOutlet UITextField *SPLXTextField;
@property (weak, nonatomic) IBOutlet UITextField *QXESTextField;
@property (weak, nonatomic) IBOutlet UITextField *SPSLTextField;

@property (weak, nonatomic) IBOutlet UITextField *SPLYTextField;
@property (weak, nonatomic) IBOutlet UITextField *JJTextField;
@property (weak, nonatomic) IBOutlet UITextField *BZTextField;
@property (weak, nonatomic) IBOutlet UITextField *SJTextField;
@property (weak, nonatomic) IBOutlet UITextField *RKSJTextField;
@property (weak, nonatomic) IBOutlet UITextField *XSSLTextField;


@end

@implementation StockDetailsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _BQArr = [NSMutableArray array];
    BQCellHeight = 39;
    NumberCellHeight = 273;
    TextCellHeight = 50;
    colorArr = @[@"#404CCF",@"#2B2D46",@"#595E93",@"#8087D6",@"#5665FF",@"#B8BDF0",@"#1A26A2",@"#989DCB",@"#0918B2",@"#A2AAFF"];
    colorDic = [NSMutableDictionary dictionary];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SupplierTureAction:) name:@"SupplierTureNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SupplierBackAction) name:@"SupplierBackNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HideViewAction) name:@"HideViewAction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PushHideViewAction) name:@"PushHideViewAction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotificationSFJLPush:) name:@"NSNotificationSFJLPush" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(remarkEditAction:) name:@"RemarkEditAction" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SNEditAction:) name:@"SNEditAction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AddSticksNotification:) name:@"AddSticksNotification" object:nil];
    
    KHId = @"";
    self.navigationItem.title = @"库存详情";
    _dataArr = [NSMutableArray array];
    
    _SPLXTextField.userInteractionEnabled = NO;
    _SPMCTextField.userInteractionEnabled = NO;
    _SPSLTextField.userInteractionEnabled = NO;
    _QXESTextField.userInteractionEnabled = NO;
    _SPLYTextField.userInteractionEnabled = NO;
    _JJTextField.userInteractionEnabled = NO;
    _BZTextField.userInteractionEnabled = NO;
    _SJTextField.userInteractionEnabled = NO;
    _RKSJTextField.userInteractionEnabled = NO;
    _SJJJTextField.userInteractionEnabled = NO;
    _RKJSRLabel.userInteractionEnabled = NO;
    _KHDHTextField.userInteractionEnabled = NO;
    
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
    
    //右边Item
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 35, 30);
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    [_stockCollectionView registerNib:[UINib nibWithNibName:@"StockCellectionCell" bundle:nil] forCellWithReuseIdentifier:@"StockCellectionCell"];
    _gmButton.layer.borderColor = [UIColor whiteColor].CGColor;
    _gmButton.layer.borderWidth = 1;
    _csButton.layer.borderColor = [UIColor whiteColor].CGColor;
    _csButton.layer.borderWidth = 1;

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
    
    _XSSLTextField.text = @"1";
    
    [_GMYHButton setTitle:@"选择客户" forState:UIControlStateNormal];
    
    KHId = @"1";
    KHDic =  @{@"id":@"1",@"name":@"客户1",@"phone":@""};
    
    //隐藏键盘
    UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleAction)];;
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    singleRecognizer.cancelsTouchesInView = NO;
    
    //给self.view添加一个手势监测；
    [self.tableView addGestureRecognizer:singleRecognizer];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];

    [_XSJSRButton setTitle:[NSString stringWithFormat:@"销售经手人:%@",SYGData[@"user_name"]] forState:UIControlStateNormal];

}


//隐藏键盘
- (void)singleAction{
   
    [_XSSLTextField resignFirstResponder];

    [_DJTextField resignFirstResponder];
    
    [_number1Label resignFirstResponder];
}

//收付记录
- (IBAction)SFJLAction:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    
    if ([[defaults objectForKey:[NSString stringWithFormat:@"%@switch",SYGData[@"id"]]] isEqualToString:@"1"]) {
        

        bgView.hidden = NO;
        sfjlV.hidden = NO;
        
    }else{
        alertV1 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        alertV1.alertViewStyle = UIAlertViewStyleSecureTextInput;
        
        [alertV1 show];

    }

}

//寄卖记录
- (IBAction)JMJLAction:(id)sender {
    
    bgView.hidden = NO;
    jmjlV.hidden = NO;
}

//回收记录
- (IBAction)HSJLAction:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    if ([[defaults objectForKey:[NSString stringWithFormat:@"%@switch",SYGData[@"id"]]] isEqualToString:@"1"]) {
        
        bgView.hidden = NO;
        hsjlV.hidden = NO;
        
    }else{
        
        alertV3 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        alertV3.alertViewStyle = UIAlertViewStyleSecureTextInput;
        
        [alertV3 show];

    }
}

//置换确定
- (IBAction)tureButtonAction:(id)sender {
    
    if ([_number1Label.text integerValue] > [dataDic[@"number"] integerValue] ) {
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"数量太大" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        return;
    }else if ([_number1Label.text isEqualToString:@""]||[_number1Label.text isEqualToString:@"0"]){
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"数量不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        return;
    }else if ([_DJTextField.text isEqualToString:@""]){
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"抵价不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        return;
    }

    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:dataDic];
    
    [dic setValue:_DJTextField.text forKey:@"DJ"];
    [dic setObject:_number1Label.text forKey:@"SL"];

    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowNotification" object:dic];
    
    NSArray *arr = self.navigationController.viewControllers;
    
    [self.navigationController popToViewController:arr[2] animated:YES];
    
}

- (IBAction)saleAction:(id)sender {
    
    isEdit = NO;
    
    if ([dataDic[@"number"] integerValue] < [_XSSLTextField.text integerValue]) {
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"销售数量太大" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        return;
    }else if ([_XSSLTextField.text isEqualToString:@""]){
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"销售数量不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        return;

    }else if ([KHId isEqualToString:@""]){
    
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择客户" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        return;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    
    bgView.hidden = NO;
    
    XSXXView = [[UIView alloc]initWithFrame:CGRectMake(10, (kScreenHeight - 250)/2, kScreenWidth - 20, 250)];
    
    XSXXView.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    XSXXView.layer.cornerRadius = 5;
    XSXXView.layer.masksToBounds = YES;
    
    [[UIApplication sharedApplication].keyWindow addSubview:XSXXView];
    
    UILabel *xsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth - 20, 30)];
    xsLabel.font = [UIFont systemFontOfSize:20];
    xsLabel.textColor = [RGBColor colorWithHexString:@"#787fc6"];
    xsLabel.text = @"销售信息";
    xsLabel.textAlignment = NSTextAlignmentCenter;
    [XSXXView addSubview:xsLabel];
    
    UIView *bgV = [[UIView alloc]initWithFrame:CGRectMake(0, 70, kScreenWidth - 20, 88)];
    
    bgV.backgroundColor = [UIColor whiteColor];
    
    [XSXXView addSubview:bgV];
    
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 20, 1)];
    
    lineV.backgroundColor = [RGBColor colorWithHexString:@"#d9d9d9"];
    
    [bgV addSubview:lineV];
    
    
    UIView *lineV1 = [[UIView alloc]initWithFrame:CGRectMake(0, 43, kScreenWidth - 20, 1)];
    
    lineV1.backgroundColor = [RGBColor colorWithHexString:@"#d9d9d9"];
    
    [bgV addSubview:lineV1];
    
    UIView *lineV2 = [[UIView alloc]initWithFrame:CGRectMake(0, 87, kScreenWidth - 20, 1)];
    
    lineV2.backgroundColor = [RGBColor colorWithHexString:@"#d9d9d9"];
    
    [bgV addSubview:lineV2];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button1.frame = CGRectMake(0, 0, kScreenWidth - 20, 44);
    
    [button1 addTarget:self action:@selector(KHXZAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [bgV addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button2.frame = CGRectMake(0, 44, kScreenWidth - 20, 44);
    
    [button2 addTarget:self action:@selector(XSJSRAction) forControlEvents:UIControlEventTouchUpInside];
    [bgV addSubview:button2];
    
    
    UIImageView *imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 20 - 15 - 14, 11, 14, 22)];
    
    imageV1.image = [UIImage imageNamed:@"youjt@2x"];
    
    [button1 addSubview:imageV1];
    
    UIImageView *imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 20 - 15 - 14, 11, 14, 22)];
    
    imageV2.image = [UIImage imageNamed:@"youjt@2x"];
    
    [button2 addSubview:imageV2];
    
    
    
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 44)];
    label1.textColor = [RGBColor colorWithHexString:@"#999999"];
    label1.font = [UIFont systemFontOfSize:15];
    label1.text = @"客户选择:";
    [button1 addSubview:label1];
    
    KHXZLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 0, 200, 44)];
    KHXZLabel.textColor = [RGBColor colorWithHexString:@"#333333"];
    KHXZLabel.font = [UIFont systemFontOfSize:15];
    KHXZLabel.text = @"客户1";
    [button1 addSubview:KHXZLabel];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 44)];
    label2.textColor = [RGBColor colorWithHexString:@"#999999"];
    label2.font = [UIFont systemFontOfSize:15];
    label2.text = @"销售经手人:";
    [button2 addSubview:label2];
    
    XSJSRLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 0, 200, 44)];
    XSJSRLabel.textColor = [RGBColor colorWithHexString:@"#333333"];
    XSJSRLabel.font = [UIFont systemFontOfSize:15];
    XSJSRLabel.text = SYGData[@"user_name"];
    [button2 addSubview:XSJSRLabel];
    
    
    UIButton *XSXXButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    XSXXButton.frame = CGRectMake(10, 70+88+30, kScreenWidth - 40, 44);
    
    XSXXButton.backgroundColor = [RGBColor colorWithHexString:@"#787fc6"];
    
    [XSXXButton setTitle:@"确定" forState:UIControlStateNormal];
    
    XSXXButton.layer.cornerRadius = 5;
    XSXXButton.layer.masksToBounds = YES;
    [XSXXButton addTarget:self action:@selector(XSXXButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [XSXXView addSubview:XSXXButton];
    
}


//客户选择
- (void)KHXZAction{
    
    bgView.hidden = YES;
    XSXXView.hidden = YES;
    
    CustomerInformationViewController *customerInformationVC = [[CustomerInformationViewController alloc]init];
    customerInformationVC.KHId = dataDic[@"customer_id"];
    [self.navigationController pushViewController:customerInformationVC animated:YES];
    
}
//销售经手人
- (void)XSJSRAction{
    
    bgView.hidden = YES;
    XSXXView.hidden = YES;
    SticksViewController *sticksVC = [[SticksViewController alloc]init];
    
    [self.navigationController pushViewController:sticksVC animated:YES];
    
    
}


//销售信息确定
- (void)XSXXButtonAction{
    
    isEdit = YES;
    
    bgView.hidden = YES;
    XSXXView.hidden = YES;
    
    PaymentTwoViewController *paymentCollectionVC = [[PaymentTwoViewController alloc]init];
    
    paymentCollectionVC.numbel = _XSSLTextField.text;
    paymentCollectionVC.HSDic = dataDic;
    paymentCollectionVC.KHId = KHId;
    paymentCollectionVC.KHDic = KHDic;
    paymentCollectionVC.JSRDic = _XSJSRDic;
    [self.navigationController pushViewController:paymentCollectionVC animated:YES];
    
    _XSJSRDic = nil;
    KHId = @"1";
    KHDic =  @{@"id":@"1",@"name":@"客户1",@"phone":@""};
    
}




- (void)bgButtonAction{

    XSXXView.hidden = YES;
    bgView.hidden = YES;
    sfjlV.hidden = YES;
    jmjlV.hidden = YES;
    hsjlV.hidden = YES;

    
}

- (void)loadData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];

    [params setObject:SYGData[@"id"] forKey:@"uid"];
    [params setObject:_SPID forKey:@"id"];
    
    
    [DataSeviece requestUrl:get_goodshtml params:params success:^(id result) {
        NSLog(@"%@",result);
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            dataDic = result[@"result"][@"data"];
            
            
            NSMutableArray *numArr = [NSMutableArray array];
            NSMutableArray *textArr = [NSMutableArray array];
            
            
            for (NSDictionary *dic1 in dataDic[@"attribute"]) {
                
                if ([dic1[@"type"] isEqualToString:@"number"]) {
                    [numArr addObject:dic1];
                }
                
                if ([dic1[@"type"] isEqualToString:@"text"]) {
                    [textArr addObject:dic1];
                }
            }
            
            for (int i = 0; i < numArr.count; i++) {
                
                UIView *View = [[UIView alloc]initWithFrame:CGRectMake(10, NumberCellHeight + 39*i, kScreenWidth - 20, 1)];
                View.backgroundColor = [RGBColor colorWithHexString:@"#d9d9d9"];
                
                [_NumberCell.contentView addSubview:View];
                
                UILabel *label  = [_NumberCell.contentView viewWithTag:500+i];
                
                if (!label) {
                    label = [[UILabel alloc]initWithFrame:CGRectMake(10, NumberCellHeight + 10 +39*i, kScreenWidth -20, 20)];
                    [_NumberCell.contentView addSubview:label];
                    
                }
                label.font = [UIFont systemFontOfSize:16];
                label.tag = 500+i;
                label.text = [NSString stringWithFormat:@"%@:  %@",numArr[i][@"attribute_name"],numArr[i][@"attribute_value"]];
                
            }
            
            for (int i = 0; i < textArr.count; i++) {
                
                UIView *View = [[UIView alloc]initWithFrame:CGRectMake(10, TextCellHeight + 39*i, kScreenWidth - 20, 1)];
                View.backgroundColor = [RGBColor colorWithHexString:@"#d9d9d9"];
                
                [_TextCell.contentView addSubview:View];
                
                UILabel *label  = [_TextCell.contentView viewWithTag:600+i];
                
                if (!label) {
                    label = [[UILabel alloc]initWithFrame:CGRectMake(10, TextCellHeight + 10 +39*i, kScreenWidth -20, 20)];
                    [_TextCell.contentView addSubview:label];
                    
                }
                label.font = [UIFont systemFontOfSize:16];
                label.tag = 600+i;
                label.text = [NSString stringWithFormat:@"%@:  %@",textArr[i][@"attribute_name"],textArr[i][@"attribute_value"]];
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                
                button.frame = CGRectMake(10,TextCellHeight+39*i, kScreenWidth -20, 39);
                button.tag = 100+i;
                [button addTarget:self action:@selector(editBZActon:) forControlEvents:UIControlEventTouchUpInside];
                [_TextCell.contentView addSubview:button];
                
                UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
                
                button1.frame = CGRectMake(kScreenWidth - 38 ,TextCellHeight+39*i + 5, 30, 30);
                button1.tag = 150+i;
                [button1 setImage:[UIImage imageNamed:@"BZbtn@2x"] forState:UIControlStateNormal];
                [button1 addTarget:self action:@selector(copyBZActon:) forControlEvents:UIControlEventTouchUpInside];
                [_TextCell.contentView addSubview:button1];
                


            }
            
            NumberCellHeight = NumberCellHeight + 39*numArr.count;
            
            TextCellHeight = TextCellHeight + 39*textArr.count;
            
            
            
            for (NSDictionary *dic in dataDic[@"attribute"]) {
                
                if ([dic[@"type"] isEqualToString:@"select"]) {
    
                    [_BQArr addObject:dic];
                }
            }
            
            [self BQUpData];

            _SPBHLabel.text = [NSString stringWithFormat:@"商品编号:%@",result[@"result"][@"data"][@"goods_sn"]];
            _SPMCTextField.text = result[@"result"][@"data"][@"goods_name"];
            _SPSLTextField.text = result[@"result"][@"data"][@"number"];
            _SPLXTextField.text = result[@"result"][@"data"][@"category_name"];
            if ([result[@"result"][@"data"][@"is_new"] isEqualToString:@"1"]) {
                _QXESTextField.text = @"全新";
            }else{
                _QXESTextField.text = @"二手";
            }
            _SPLYTextField.text = result[@"result"][@"data"][@"customer_name"];
            if (result[@"result"][@"data"][@"customer_mobile"]&&![result[@"result"][@"data"][@"customer_mobile"] isKindOfClass:[NSNull class]]) {
                _KHDHTextField.text = result[@"result"][@"data"][@"customer_mobile"];
            }
            
            if ([[defaults objectForKey:[NSString stringWithFormat:@"%@switch",SYGData[@"id"]]] isEqualToString:@"1"]) {
                
                _JJTextField.text = [NSString stringWithFormat:@"%ld",[dataDic[@"cost"] integerValue]];
                _SJJJTextField.text = [NSString stringWithFormat:@"%ld",[dataDic[@"haspay"] integerValue]];
                
            }else{
            _JJTextField.text = @"*****";
            _SJJJTextField.text = @"*****";
             
        }
            _BZTextField.text = result[@"result"][@"data"][@"remark"];
            _SJTextField.text = [NSString stringWithFormat:@"%ld",[result[@"result"][@"data"][@"price"] integerValue]];
            _RKJSRLabel.text = result[@"result"][@"data"][@"add_user_name"];
            NSTimeInterval time=[result[@"result"][@"data"][@"add_time"] doubleValue];//因为时差问题要加8小时 == 28800 sec
            NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
            //实例化一个NSDateFormatter对象
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //设定时间格式,这里可以设置成自己需要的格式
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            
            NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
            _RKSJTextField.text = currentDateStr;
            
            for (NSDictionary *dic in result[@"result"][@"data"][@"photo_list"]) {
                NSDictionary *dic1 = [NULLHandle NUllHandle:dic];
                [_dataArr addObject:dic1];
            }

            NSLog(@"%@",_dataArr);
            
            [_stockCollectionView reloadData];
        }
    
        if (dataDic[@"consighment_log"][@"category_id"]) {
            
            if (![dataDic[@"recovery_log"][@"add_time"] isKindOfClass:[NSNull class]]) {
                
            }else{
            
                _HSJLButton.hidden = YES;
                
                _JMJLBUtton.left = kScreenWidth - 86 - 12;
            }
            
        }else{
        
            _JMJLBUtton.hidden = YES;

            if (![dataDic[@"recovery_log"][@"add_time"] isKindOfClass:[NSNull class]]) {
                
                
                _HSJLButton.left = kScreenWidth - 86 - 12;
            }else{
            
                _SFJLButton.left = kScreenWidth/2 - 43;
            
            }
        
        }
        
        sfjlV = [[[NSBundle mainBundle]loadNibNamed:@"SFJLView" owner:self options:nil]lastObject];
        sfjlV.hidden = YES;
        sfjlV.frame = CGRectMake(10, 64, kScreenWidth-20, 450);
        sfjlV.layer.cornerRadius = 5;
        sfjlV.layer.masksToBounds = YES;
        sfjlV.dataArr = dataDic[@"paylog"];
        sfjlV.SFJLLabel.text = [NSString stringWithFormat:@"%@收付记录",dataDic[@"goods_sn"]];
        [[UIApplication sharedApplication].keyWindow addSubview:sfjlV];
        
        __weak UIView *weakbgV = bgView;
        __weak UIView *wadksfjlV = sfjlV;
        sfjlV.backBlock =^(){
            wadksfjlV.hidden = YES;
            weakbgV.hidden = YES;
        };
        
        hsjlV = [[HSJLView alloc]initWithFrame:CGRectMake(10, 64, kScreenWidth-20, 450)];
        hsjlV.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
        hsjlV.layer.cornerRadius = 5;
        hsjlV.layer.masksToBounds = YES;
        hsjlV.remark = dataDic[@"remark"];
        hsjlV.dic = dataDic[@"recovery_log"];
        hsjlV.title.text = [NSString stringWithFormat:@"%@回收记录",dataDic[@"goods_sn"]];
        hsjlV.hidden = YES;
        [[UIApplication sharedApplication].keyWindow addSubview:hsjlV];
        
        __weak UIView *wadkhsjlV = hsjlV;
        hsjlV.backBlock =^(){
            weakbgV.hidden = YES;
            wadkhsjlV.hidden = YES;
        };
        
        jmjlV = [[JMJLView alloc]initWithFrame:CGRectMake(10, 64, kScreenWidth-20, 450)];
        jmjlV.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
        jmjlV.layer.cornerRadius = 5;
        jmjlV.layer.masksToBounds = YES;
        jmjlV.HSDic = dataDic[@"consighment_log"];
        jmjlV.title.text = [NSString stringWithFormat:@"%@寄卖记录",dataDic[@"goods_sn"]];
        jmjlV.hidden = YES;
        [[UIApplication sharedApplication].keyWindow addSubview:jmjlV];
        
        __weak UIView *wadkjmjlV = jmjlV;
        jmjlV.backBlock =^(){
            weakbgV.hidden = YES;
            wadkjmjlV.hidden = YES;
        };

        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

//左边返回按钮
- (void)leftBtnAction{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackNotification" object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];


}

//保存图片
- (IBAction)SaveImageAction:(UIButton *)sender {
    
    sender.userInteractionEnabled = NO;
    for (int i = 0; i<_dataArr.count; i++) {
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_dataArr[i][@"image_url"]]]];

        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }

 
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    index++;

    
    if (index == _dataArr.count) {
        
        if (error == nil) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已存入手机相册" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil, nil];
            [alert show];
            
        }else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil ,nil];
            [alert show];
        }
        
    }
    _upDataButton.userInteractionEnabled = YES;

}


//右边编辑按钮
-(void)editAction:(UIButton*)bt{
    
    
    isEdit = YES;
    
    StorageViewController *storageVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"StorageViewController"];
    storageVC.isEdit = YES;
    storageVC.editDic = dataDic;
    
    [self.navigationController pushViewController:storageVC animated:YES];
    
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArr.count;

}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StockCellectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StockCellectionCell" forIndexPath:indexPath];
    cell.url = _dataArr[indexPath.row][@"image_url"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ScanViewController *scanVC = [[ScanViewController alloc]init];
    NSMutableArray *imageArr = [NSMutableArray array];
    for (NSDictionary *dic in _dataArr) {
        
        [imageArr addObject:dic[@"image_url"]];
    }
    scanVC.imageURLArr = imageArr;
    scanVC.currentIndexPath = indexPath;
    [self.navigationController pushViewController:scanVC animated:YES];
    
}



- (void)SupplierTureAction:(NSNotification*)noti{
    
    if (isEdit) {
        
    }else{
    
    bgView.hidden = NO;
    XSXXView.hidden = NO;
        
    NSDictionary *dic = [noti object];
    
    KHId = dic[@"id"];
    KHDic = dic;
    
    KHXZLabel.text = dic[@"name"];
    }
}


- (void)SupplierBackAction{

    bgView.hidden = YES;

    bgView = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BooksNotification" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackNotification" object:nil];

    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)HideViewAction{
    
    bgView.hidden = YES;
    
    bgView = nil;

    [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeNotification" object:nil];
    
    [self.navigationController popToRootViewControllerAnimated:YES];

}

- (void)PushHideViewAction{

    bgView.hidden = YES;
    
//    storageV.hidden = YES;
    
    StorageViewController *storageVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"StorageViewController"];
    storageVC.isJM = YES;
    storageVC.isType = @"1";
    storageVC.KHDic = KHDic;
    storageVC.goods_id = dataDic[@"id"];
    [self.navigationController pushViewController:storageVC animated:YES];
    

}


- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillDisappear:(BOOL)animated{

    [ super viewWillDisappear:animated];
    
    bgView.hidden = YES;

}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    //改变导航栏标题的字体颜色和大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏背景.png"] forBarMetrics:UIBarMetricsDefault];
    
    [_BQArr removeAllObjects];
    [_dataArr removeAllObjects];
    NumberCellHeight = 273;
    TextCellHeight = 50;

    //加载数据
    [self loadData];
    
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        return 51;
    }else if (indexPath.row ==1){
        return 129;
    }else if (indexPath.row ==2){
        return 119;
    }else if (indexPath.row ==3){
        return 10;
    }else if (indexPath.row == 4){
        return BQCellHeight;
//        return 0;
    }else if (indexPath.row == 5){
        return 10;
    }else if (indexPath.row ==6){
        return NumberCellHeight;
    }else if (indexPath.row == 7){
        return 10;
    }else if (indexPath.row == 8){
        return TextCellHeight;
    }else if (indexPath.row ==9){
        return 84;
    }else if (indexPath.row ==10){
        
        if ([_isType isEqualToString:@"1"]) {
            return 50;
        }else{
            return 0;
        }
    }else if (indexPath.row ==11){
        if ([_isType isEqualToString:@"1"]) {
            return 0;
        }else{
            return 50;
        }
    }
    return 0;
}

- (IBAction)JJShowAction:(id)sender {
    
    if (![_JJTextField.text isEqualToString:[NSString stringWithFormat:@"%ld",[dataDic[@"cost"] integerValue]]]) {
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
            if (alertV1 == alertView) {
                
                bgView.hidden = NO;
                
                sfjlV.hidden = NO;
                
            }else if (alertView == alertV2){
                
                bgView.hidden = NO;
                
                jmjlV.hidden = NO;
                
            }else if (alertView == alertV3) {
                
                bgView.hidden = NO;
                hsjlV.hidden = NO;
                
            }else{
                
                _JJTextField.text = [NSString stringWithFormat:@"%ld",[dataDic[@"cost"] integerValue]];
                _SJJJTextField.text = [NSString stringWithFormat:@"%ld",[dataDic[@"haspay"] integerValue]];
                
            }            }else{
            
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
//    if (alertV1 == alertView) {
//        
//        bgView.hidden = NO;
//        
//        sfjlV.hidden = NO;
//   
//    }else if (alertView == alertV2){
//    
//        bgView.hidden = NO;
//        
//        jmjlV.hidden = NO;
//        
//    }else if (alertView == alertV3) {
//    
//        bgView.hidden = NO;
//        hsjlV.hidden = NO;
//        
//    }else{
//        
//        _JJTextField.text = [NSString stringWithFormat:@"%ld",[dataDic[@"cost"] integerValue]];
//        _SJJJTextField.text = [NSString stringWithFormat:@"%ld",[dataDic[@"haspay"] integerValue]];
//                
//    }    }else{
//        
//        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        
//        [alertV show];
//        
//    }

}

- (void)NSNotificationSFJLPush:(NSNotification*)noti{
    
    sfjlV.hidden = YES;
    bgView.hidden = YES;
    
    BooksDetailsViewController *booksDetailsVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"BooksDetailsViewController"];
    
    
    booksDetailsVC.booksId = [noti object];
    
    [self.navigationController pushViewController:booksDetailsVC animated:YES];
    
}
//跳转编辑备注
- (IBAction)EditRemarkActon:(id)sender {
    
    EditRemarkViewController *editRemark  = [[EditRemarkViewController alloc]init];
    
    editRemark.remarktext = dataDic[@"remark"];
    editRemark.goods_id = dataDic[@"id"];
    [self.navigationController pushViewController:editRemark animated:YES];
    
}
////通知改变备注
//- (void)remarkEditAction:(NSNotification*)noti{
//
//    _BZTextField.text = [noti object];
//    
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:dataDic];
//    
//    [dic setObject:_BZTextField.text forKey:@"remark"];
//    
//    dataDic = [dic copy];
//}
//一键复制
- (IBAction)remarkAction:(id)sender {
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _BZTextField.text;
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    hud.labelText = @"复制成功";
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"done@2x"]];

    [self.view addSubview:hud];
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [hud removeFromSuperview];
    }];
    
}
- (IBAction)editSNAction:(id)sender {
    
    EditSNViewController *editSNVC = [[EditSNViewController alloc]init];
    editSNVC.goods_id = dataDic[@"id"];
    editSNVC.dic = dataDic;
    [self.navigationController pushViewController:editSNVC animated:YES];
    
}


//- (void)SNEditAction:(NSNotification*)noti{
//
//    _SPBHLabel.text = [NSString stringWithFormat:@"商品编号:%@",[noti object]];
//    
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:dataDic];
//    
//    [dic setObject:[noti object]forKey:@"goods_sn"];
//    dataDic = [dic copy];
//
//}
//选择销售经手人
- (IBAction)XSJSRAction:(id)sender {
    
    
    SticksViewController *sticksVC = [[SticksViewController alloc]init];
    
    [self.navigationController pushViewController:sticksVC animated:YES];
    
}


//经手人返回通知
- (void)AddSticksNotification:(NSNotification*)noti{
    
    
    if (isEdit) {
        
    }else{
    
    bgView.hidden = NO;
    XSXXView.hidden = NO;
    
    _XSJSRDic = [noti object];
    
    
    XSJSRLabel.text = _XSJSRDic[@"user_name"];

    }
//    [_XSJSRButton setTitle:[NSString stringWithFormat:@"销售经手人:%@",_XSJSRDic[@"user_name"]] forState:UIControlStateNormal];

}


- (void)BQUpData{
    
    
    NSArray *labelArr = [_BQArr copy];
    NSLog(@"%@",labelArr);
    CGFloat left = 10;
    BQCellHeight = 35;
    for (int i = 0; i < labelArr.count; i++) {
        
        CGRect rect = [labelArr[i][@"attribute_name"] boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        
        UIButton *button = [_BQCell viewWithTag:10000+i];
        if (!button) {
            button = [UIButton buttonWithType:UIButtonTypeCustom];
        }
        
        
        if (left + rect.size.width > kScreenWidth - 20) {
            BQCellHeight = BQCellHeight +30;
            left = 10;
        }
        
        button.frame = CGRectMake(left, BQCellHeight, rect.size.width+10, 20);
        [button setTitle:labelArr[i][@"attribute_name"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        NSString *color = colorDic[labelArr[i][@"parent_id"]];
        
        if (!color) {
            NSInteger index1 = colorDic.count%10;

            color = colorArr[index1];
            
            NSLog(@"%@",labelArr[i][@"parent_id"]);
            
            [colorDic setObject:colorArr[index1] forKey:labelArr[i][@"parent_id"]];
            
        }
        
        button.backgroundColor = [RGBColor colorWithHexString:color];
        button.layer.cornerRadius = 3;
        button.layer.masksToBounds = YES;
        button.tag = 10000 + i;
//        [button addTarget:self action:@selector(BQbuttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.selected = YES;
        [_BQCell.contentView addSubview:button];
        left = left + rect.size.width + 20;
        
    }
    
    for (NSInteger i = labelArr.count; i < labelArr.count +10; i++) {
        
        UIView *view = [_BQCell viewWithTag:10000 + i];
        
        if (view) {
            [view removeFromSuperview];
        }
        
    }
    
    BQCellHeight = BQCellHeight +30;
    
    [self.tableView reloadData];
    
}

//自定义编辑
- (void)editBZActon:(UIButton*)bt{

    NSMutableArray *textArr = [NSMutableArray array];
    
    for (NSDictionary *dic1 in dataDic[@"attribute"]) {
        
        if ([dic1[@"type"] isEqualToString:@"text"]) {
            [textArr addObject:dic1];
        }
    }
    
    EditRemarkViewController *editRemark  = [[EditRemarkViewController alloc]init];
    editRemark.text_title = textArr[bt.tag - 100][@"attribute_name"];
    editRemark.remarktext = textArr[bt.tag - 100][@"attribute_value"];
    editRemark.goods_id = dataDic[@"id"];
    editRemark.text_id = textArr[bt.tag - 100][@"id"];
    [self.navigationController pushViewController:editRemark animated:YES];
    

}
//自定义复制

- (void)copyBZActon:(UIButton*)bt{

    NSMutableArray *textArr = [NSMutableArray array];
    
    for (NSDictionary *dic1 in dataDic[@"attribute"]) {
        
        
        if ([dic1[@"type"] isEqualToString:@"text"]) {
            [textArr addObject:dic1];
        }
    }
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = textArr[bt.tag - 150][@"attribute_value"];
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    hud.labelText = @"复制成功";
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"done@2x"]];
    
    [self.view addSubview:hud];
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [hud removeFromSuperview];
    }];

}

//一键发布
- (IBAction)onePushAction:(id)sender {
    
    OneButtonPublishingViewController *OneButtonPublishingVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"OneButtonPublishingViewController"];
 
    NSMutableArray *arr = [NSMutableArray array];
    
    for (NSDictionary *dic in dataDic[@"photo_list"]) {
        [arr addObject:dic[@"image_url"]];
    }
    
    NSDictionary *dic = @{@"title":dataDic[@"goods_name"],@"price":[NSString stringWithFormat:@"%ld",[dataDic[@"price"] integerValue]],@"img":[arr copy]};
    OneButtonPublishingVC.oldDic = dic;
    
    [self.navigationController pushViewController:OneButtonPublishingVC animated:YES];
    
}


@end
