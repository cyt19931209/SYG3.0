//
//  MerchandiseViewController.m
//  奢易购3.0
//
//  Created by guest on 16/7/25.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "MerchandiseViewController.h"
#import "SFJLView.h"
#import "StockCellectionCell.h"
//#import "StorageView.h"
#import "StockPriceViewController.h"
//#import "SupplierView.h"
#import "StorageViewController.h"
#import "ConsignmentViewController.h"
#import "JMJLView.h"
#import "BooksDetailsViewController.h"
#import "ScanViewController.h"
#import "EditRemarkViewController.h"
#import "MBProgressHUD.h"
#import "EditSNViewController.h"
#import "PaymentTwoViewController.h"
#import "CustomerInformationViewController.h"
#import "SticksViewController.h"
#import "OneButtonPublishingViewController.h"


@interface MerchandiseViewController (){

    UIView *bgView;
    SFJLView *sfjlV;
    JMJLView *jmjlV;
    NSString *idStr;
    NSString *idString;
    NSInteger index;
    
    NSDictionary *dataDic;

    NSString *goods_id;
//    StorageView *storageV;
    NSDictionary *ZFDic;
    
    NSString *KHId;
    NSMutableDictionary *KHDic;
    
    UIView *XSXXView;
    
    UILabel *KHXZLabel;
    
    UILabel *XSJSRLabel;
    
    BOOL isEdit;
    NSInteger BQCellHeight;
    
    NSInteger JSRCellHeight;
    
    NSInteger TextCellHeight;
    
    NSArray *colorArr;
    
    NSMutableDictionary *colorDic;
    
    

    
}

@property (nonatomic,strong) NSMutableArray *BQArr;

@property (weak, nonatomic) IBOutlet UITableViewCell *BQCell;


@property (weak, nonatomic) IBOutlet UITableViewCell *TextCell;


@property (nonatomic,strong) NSDictionary *XSJSRDic;


@property (weak, nonatomic) IBOutlet UICollectionView *merchandiseCollectionView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (weak, nonatomic) IBOutlet UITableViewCell *JSRCell;



@end

@implementation MerchandiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BQCellHeight = 39;
    JSRCellHeight = 170;
    TextCellHeight = 51;
    
    _BQArr = [NSMutableArray array];
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

    _dataArr = [NSMutableArray array];
    index = 0;
    KHDic = [NSMutableDictionary dictionary];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HideViewAction) name:@"HideViewAction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PushHideViewAction) name:@"PushHideViewAction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(canacelAction) name:@"SupplierCancelNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tureAtion:) name:@"SupplierTureNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SupplierBackAction) name:@"SupplierBackNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotificationSFJLPush:) name:@"NSNotificationSFJLPush" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AddSticksNotification:) name:@"AddSticksNotification" object:nil];

    
    //改变导航栏标题的字体颜色和大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"寄卖背景"] forBarMetrics:UIBarMetricsDefault];
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"返回（20x38）.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //右边Item
    
    if ([_status isEqualToString:@"1"]) { 
       
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(0, 0, 35, 30);
        [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [rightBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
        self.navigationItem.rightBarButtonItem = rightButtonItem;
        
    }
    
    [_merchandiseCollectionView registerNib:[UINib nibWithNibName:@"StockCellectionCell" bundle:nil]forCellWithReuseIdentifier:@"StockCellectionCell"];
    
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
    
      

    _SPMCTextField.userInteractionEnabled = NO;
    _SPLXTextField.userInteractionEnabled = NO;
    _QXESTextField.userInteractionEnabled = NO;
    _SPSLTextField.userInteractionEnabled = NO;
    _SPXXTextField.userInteractionEnabled = NO;
    _KHDHTextField.userInteractionEnabled = NO;
    _KHDSJTextField.userInteractionEnabled = NO;
    _JMJGTextField.userInteractionEnabled = NO;
    _BZTextView.userInteractionEnabled = NO;
    _JMSJTextField.userInteractionEnabled = NO;
    
    _XSSLTextField.text = @"1";
    
    [_GMYHButton setTitle:@"选择客户" forState:UIControlStateNormal];
    
    KHId = @"1";
    
    [KHDic setValue:@"1" forKey:@"id"];
    [KHDic setValue:@"客户1" forKey:@"name"];
    [KHDic setValue:@"" forKey:@"phone"];
    
    //隐藏键盘
    UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleAction)];;
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    singleRecognizer.cancelsTouchesInView = NO;
    
    //给self.view添加一个手势监测；
    
    [self.tableView addGestureRecognizer:singleRecognizer];
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    
    
}
//隐藏键盘
- (void)singleAction{

    [_XSSLTextField resignFirstResponder];

    [_DJTextField resignFirstResponder];
}

//隐藏视图
- (void)bgButtonAction{
    
    bgView.hidden = YES;
    XSXXView.hidden = YES;
    sfjlV.hidden = YES;
    jmjlV.hidden = YES;
}


- (void)loadData{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];

    [params setObject:idString forKey:idStr];

    [params setObject:_status forKey:@"status"];
    
    [DataSeviece requestUrl:get_consighmenthtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        NSLog(@"%@",result[@"result"][@"msg"]);
        ZFDic = result[@"result"][@"data"];
        NSDictionary *dic = [NULLHandle NUllHandle:result[@"result"][@"data"]];
        dataDic = dic;
        
        for (NSDictionary *dic in dataDic[@"goods"][@"attribute"]) {
            
            if ([dic[@"type"] isEqualToString:@"select"]) {
                
                [_BQArr addObject:dic];
                
            }
            
        }
        
        [self BQUpData];
        _SPMCTextField.text = dic[@"goods"][@"goods_name"];
        NSInteger JSRSL = 0;
        
        if ([dic[@"status"] isEqualToString:@"1"]) {
            
            self.navigationItem.title = @"寄卖品(入库寄卖中)";
            JSRSL = 1;
            
        }else if ([dic[@"status"] isEqualToString:@"2"]){
            
            [_KHJSButton setTitle:[NSString stringWithFormat:@"给%@结算货款",dic[@"customer_name"]] forState:UIControlStateNormal];
            self.navigationItem.title = @"寄卖品(待结算)";
            JSRSL = 2;

        }else if ([dic[@"status"] isEqualToString:@"3"]){
            self.navigationItem.title = @"寄卖品(已结算)";
            JSRSL = 3;

        }else if ([dic[@"status"] isEqualToString:@"4"]){
            self.navigationItem.title = @"寄卖品(已赎回)";
            JSRSL = 1;

        }
        
        for (int i = 0; i < JSRSL; i++) {
            
            UIView *View = [[UIView alloc]initWithFrame:CGRectMake(10, 238 + i*34 - 68, kScreenWidth - 20, 1)];
            View.backgroundColor = [RGBColor colorWithHexString:@"#d9d9d9"];
            
            [_JSRCell.contentView addSubview:View];
            
            UILabel *label  = [_JSRCell.contentView viewWithTag:50+i];
            
            if (!label) {
               label = [[UILabel alloc]initWithFrame:CGRectMake(10, 245 + i*34 - 68, kScreenWidth -20, 20)];
                [_JSRCell.contentView addSubview:label];

            }

            label.font = [UIFont systemFontOfSize:16];
            label.tag = 50+i;
            
            if ([dic[@"status"] isEqualToString:@"1"]) {
                label.text = [NSString stringWithFormat:@"入库经手人:  %@",dic[@"goods"][@"input_add_user_name"]];
            }else if ([dic[@"status"] isEqualToString:@"4"]){
                label.text = [NSString stringWithFormat:@"入库经手人:  %@",dic[@"goods"][@"input_add_user_name"]];

            }else if ([dic[@"status"] isEqualToString:@"2"]){
                if (i == 0) {
                    label.text = [NSString stringWithFormat:@"入库经手人:  %@",dic[@"goods"][@"input_add_user_name"]];
   
                }else if (i == 1){
                    label.text = [NSString stringWithFormat:@"销售经手人:  %@",dic[@"goods"][@"sales_add_user_name"]];
                
                }
            }else if ([dic[@"status"] isEqualToString:@"3"]){
                if (i == 0) {
                    label.text = [NSString stringWithFormat:@"入库经手人:  %@",dic[@"goods"][@"input_add_user_name"]];
                    
                }else if (i == 1){
                    label.text = [NSString stringWithFormat:@"销售经手人:  %@",dic[@"goods"][@"sales_add_user_name"]];
                    
                }else if (i == 2){
                    label.text = [NSString stringWithFormat:@"结算经手人:  %@",dic[@"goods"][@"consighment_add_user_name"]];
                }
            }
        }
        
        JSRCellHeight = JSRCellHeight + 34*JSRSL;
        
        NSMutableArray *numArr = [NSMutableArray array];
        NSMutableArray *textArr = [NSMutableArray array];

        
        for (NSDictionary *dic1 in dic[@"goods"][@"attribute"]) {
            
            if ([dic1[@"type"] isEqualToString:@"number"]) {
                [numArr addObject:dic1];
            }
            
            if ([dic1[@"type"] isEqualToString:@"text"]) {
                [textArr addObject:dic1];
            }
        }
        
        for (int i = 0; i < numArr.count; i++) {
            
            UIView *View = [[UIView alloc]initWithFrame:CGRectMake(10, JSRCellHeight + 34*i, kScreenWidth - 20, 1)];
            View.backgroundColor = [RGBColor colorWithHexString:@"#d9d9d9"];
            
            [_JSRCell.contentView addSubview:View];
            
            UILabel *label  = [_JSRCell.contentView viewWithTag:500+i];
            
            if (!label) {
                label = [[UILabel alloc]initWithFrame:CGRectMake(10, JSRCellHeight + 7 +34*i, kScreenWidth -20, 20)];
                [_JSRCell.contentView addSubview:label];
                
            }
            label.font = [UIFont systemFontOfSize:16];
            label.tag = 500+i;
            label.text = [NSString stringWithFormat:@"%@:  %@",numArr[i][@"attribute_name"],numArr[i][@"attribute_value"]];

        }
        
        for (int i = 0; i < textArr.count; i++) {
            
            UIView *View = [[UIView alloc]initWithFrame:CGRectMake(10, TextCellHeight + 34*i, kScreenWidth - 20, 1)];
            View.backgroundColor = [RGBColor colorWithHexString:@"#d9d9d9"];
            
            [_TextCell.contentView addSubview:View];
            
            UILabel *label  = [_TextCell.contentView viewWithTag:600+i];
            
            if (!label) {
                label = [[UILabel alloc]initWithFrame:CGRectMake(10, TextCellHeight + 7 +34*i, kScreenWidth -20, 20)];
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

        JSRCellHeight = JSRCellHeight + 34*numArr.count;
        
        TextCellHeight = TextCellHeight + 34*textArr.count;

        
        _SPLXTextField.text = dic[@"goods"][@"category_name"];
        if ([dic[@"goods"][@"is_new"] isEqualToString:@"1"]) {
            _QXESTextField.text = @"全新";
        }else{
            _QXESTextField.text = @"二手";
        }
        
        if ([_isType isEqualToString:@"6"]) {
            
        }else{
            _isType  = dic[@"status"];
        }
        _SPSLTextField.text = dic[@"goods"][@"number"];
        _SPXXTextField.text = dic[@"customer_name"];
        _KHDHTextField.text = dic[@"customer_mobile"];
        _KHDSJTextField.text = [NSString stringWithFormat:@"%ld",[dic[@"customer_price"] integerValue]];
        _JMJGTextField.text = [NSString stringWithFormat:@"%ld",[dic[@"price"] integerValue]];
        _BZTextView.text = dic[@"remark"];
        _JMSJTextField.text = dic[@"add_time"];
        _SPBHLabel.text = [NSString stringWithFormat:@"寄卖单号:%@",dic[@"goods"][@"goods_sn"]];
        
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"goods"][@"pic"][@"href"]) {
            [_dataArr addObject:dic];
        }
        NSLog(@"%@",_dataArr);
        [_merchandiseCollectionView reloadData];
        
        goods_id = result[@"result"][@"data"][@"goods"][@"goods_id"];
        
        NSArray *pay_inputArr = dataDic[@"pay_input"];
        
        if (pay_inputArr.count == 0) {
            
            _SFJLButton.selected = NO;
            _SFJLButton.userInteractionEnabled = NO;
        }else{
            _SFJLButton.selected = YES;
            _SFJLButton.userInteractionEnabled = YES;
        }
        if (![_BZTextView.text isEqualToString:@""]) {
            _BZLabel.hidden = YES;
        }
        
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

- (IBAction)QHAction:(id)sender {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    [params setObject:goods_id forKey:@"goods_id"];
    
    [DataSeviece requestUrl:redemptionhtml params:params success:^(id result) {
        NSLog(@"%@",result);
        NSLog(@"%@",result[@"result"][@"msg"]);
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"BackNotification" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ConsignmentNotification" object:nil];

            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (IBAction)XSAction:(id)sender {
 
    _isType = @"5";

    [self.tableView reloadData];
}

- (void)setMerchandiseId:(NSString *)merchandiseId{

    _merchandiseId = merchandiseId;
    idStr = @"id";
    idString = _merchandiseId;

}

- (void)setGoodId:(NSString *)goodId{
    _goodId = goodId;
    idStr = @"goods_id";
    idString = _goodId;
}

//左边返回按钮
- (void)leftBtnAction{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackNotification" object:nil];
    [self.navigationController popViewControllerAnimated:YES];

}

//右边编辑按钮
-(void)editAction:(UIButton*)bt{
    
    isEdit = YES;
    
    ConsignmentViewController *consignmentVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"ConsignmentViewController"];
    consignmentVC.editDic = dataDic;
    consignmentVC.isEdit = YES;
    
    [self.navigationController pushViewController:consignmentVC animated:YES];
    
}


//收付记录
- (IBAction)paymentAction:(id)sender {
    bgView.hidden = NO;
    
    sfjlV = [[[NSBundle mainBundle]loadNibNamed:@"SFJLView" owner:self options:nil]lastObject];
    sfjlV.frame = CGRectMake(10, 64, kScreenWidth-20, 450);
    sfjlV.layer.cornerRadius = 5;
    sfjlV.layer.masksToBounds = YES;
    sfjlV.dataArr = dataDic[@"pay_input"];
    sfjlV.SFJLLabel.text = [NSString stringWithFormat:@"%@收付记录",dataDic[@"goods"][@"goods_sn"]];

    [[UIApplication sharedApplication].keyWindow addSubview:sfjlV];
    
    __weak UIView *weakbgV = bgView;
    __weak UIView *wadksfjlV = sfjlV;
    sfjlV.backBlock =^(){
        wadksfjlV.hidden = YES;
        weakbgV.hidden = YES;
    };

}

//寄卖记录
- (IBAction)consignmentAction:(id)sender {
    
    
    bgView.hidden = NO;
    
    
    jmjlV = [[JMJLView alloc]initWithFrame:CGRectMake(10, 64, kScreenWidth-20, 450)];
    jmjlV.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    jmjlV.layer.cornerRadius = 5;
    jmjlV.layer.masksToBounds = YES;
    jmjlV.dic = dataDic;
    jmjlV.title.text = [NSString stringWithFormat:@"%@寄卖记录",dataDic[@"goods"][@"goods_sn"]];

    [[UIApplication sharedApplication].keyWindow addSubview:jmjlV];
    
    __weak UIView *weakbgV = bgView;
    __weak UIView *wadkjmjlV = jmjlV;
    jmjlV.backBlock =^(){
        weakbgV.hidden = YES;
        wadkjmjlV.hidden = YES;
    };

    
}
//保存图片
- (IBAction)SaveImageAction:(UIButton *)sender {
    
    sender.userInteractionEnabled = NO;
    
    for (int i = 0; i<_dataArr.count; i++) {
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_dataArr[i]]]];
        
        
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    index++;

    if (index == _dataArr.count) {
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil ,nil];
        if (error == nil) {
            
            alert.message = @"已存入手机相册";
            [alert show];
            
        }else{
            
            alert.message = @"保存失败";
            [alert show];
        }
        
    }
    _upDataButton.userInteractionEnabled = YES;

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
    scanVC.imageURLArr = _dataArr;
    scanVC.currentIndexPath = indexPath;
    [self.navigationController pushViewController:scanVC animated:YES];
    
}



- (void)HideViewAction{

    bgView.hidden = YES;
    
    bgView = nil;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeNotification" object:nil];
    
    [self.navigationController popToRootViewControllerAnimated:YES];

}
- (void)PushHideViewAction{
    
    bgView.hidden = YES;
    
    
    if ([_status isEqualToString:@"2"]) {
        
        StockPriceViewController *stockPrice = [[StockPriceViewController alloc]init];
        stockPrice.type = @"1";
        stockPrice.goods_id = dataDic[@"goods"][@"goods_id"];
        [self.navigationController pushViewController:stockPrice animated:YES];

    }else{
    
    StorageViewController *storageVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"StorageViewController"];
    storageVC.isJM = YES;
    storageVC.isType = @"1";
    storageVC.KHDic = KHDic;
    storageVC.goods_id = dataDic[@"goods"][@"goods_id"];
    [self.navigationController pushViewController:storageVC animated:YES];
    
    }
    
}

- (void)canacelAction{
    
    bgView.hidden = YES;
    
}

- (void)SupplierBackAction{
    
    bgView.hidden = YES;

    [[NSNotificationCenter defaultCenter] postNotificationName:@"ConsignmentAction" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackNotification" object:nil];

    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

//接收通知
- (void)tureAtion:(NSNotification*)noti{
    if (isEdit) {
        
    }else{
    
    bgView.hidden = NO;
    XSXXView.hidden = NO;
    
    NSDictionary *dic = [noti object];

    KHId = dic[@"id"];
    [KHDic setValue:dic[@"id"] forKey:@"id"];
    [KHDic setValue:dic[@"name"] forKey:@"name"];
    [KHDic setValue:dic[@"mobile"] forKey:@"mobile"];
    
    KHXZLabel.text = dic[@"name"];
    }
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
    }else if (indexPath.row == 5){
        return 10;
    }else if (indexPath.row ==6){
        
        return JSRCellHeight;
        
    }else if (indexPath.row ==7){
        return 17;
    }else if (indexPath.row ==8){
        return TextCellHeight;
    }else if (indexPath.row ==9){
        return 100;
    }else if (indexPath.row == 10){
        if ([_isType isEqualToString:@"1"]) {
            return 50;
        }
        return 0;
    }else if (indexPath.row == 11){
        if ([_isType isEqualToString:@"4"]) {
            return 50;
        }
        return 0;
    }else if (indexPath.row == 12){
        if ([_isType isEqualToString:@"3"]) {
            return 50;
        }
        return 0;
    }else if (indexPath.row == 13){
        if ([_isType isEqualToString:@"2"]) {
            return 50;
        }
        return 0;
    }else if (indexPath.row == 14){
        if ([_isType isEqualToString:@"5"]) {
            return 50;
        }
        return 0;
    }else if (indexPath.row == 15){
        if ([_isType isEqualToString:@"6"]) {
            return 50;
        }
        return 0;
    }
    
    return 0;
}
//重新寄卖
- (IBAction)CXJMAction:(id)sender {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSLog(@"%@",dataDic);
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    [params setObject:dataDic[@"goods"][@"goods_id"] forKey:@"goods_id"];
    [DataSeviece requestUrl:re_consighmenthtml params:params success:^(id result) {
        
        NSLog(@"%@ %@",result[@"result"][@"msg"] ,result[@"result"]);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
           
            _status = @"1";
            idStr = @"id";
            idString = dataDic[@"id"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ConsignmentNotification" object:nil];
            //改变导航栏标题的字体颜色和大小
            [self.navigationController.navigationBar setTitleTextAttributes:
             @{NSFontAttributeName:[UIFont systemFontOfSize:18],
               NSForegroundColorAttributeName:[UIColor whiteColor]}];
            
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"寄卖背景"] forBarMetrics:UIBarMetricsDefault];
            [_dataArr removeAllObjects];
            [_BQArr removeAllObjects];
            JSRCellHeight = 170;
            TextCellHeight = 51;
            

            [self loadData];
            
            UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            rightBtn.frame = CGRectMake(0, 0, 35, 30);
            [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
            rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            [rightBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
            
            self.navigationItem.rightBarButtonItem = rightButtonItem;
            
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


//已结算
- (IBAction)已结算:(id)sender {
    

    
}
//给客户结款
- (IBAction)KHJKAction:(id)sender {
//    bgView.hidden = NO;
//    
//    PaymentTwoViewController *paymentCollectionVC = [[PaymentTwoViewController alloc]init];
//    
//    paymentCollectionVC.JMJSDic = dataDic;
//    paymentCollectionVC.JSRDic = _XSJSRDic;
//    [self.navigationController pushViewController:paymentCollectionVC animated:YES];
//
    
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
    button1.userInteractionEnabled = NO;
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
//确定
- (IBAction)tureAction:(id)sender {
    
    isEdit = NO;
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    
    if ([_XSSLTextField.text isEqualToString:@""]) {
        alertV.message = @"请输入商品数量";
        [alertV show];
        return;
    }
    
    if (KHId == nil ||[KHId isEqualToString:@""]) {
        alertV.message = @"请选择客户";
        [alertV show];
        return;
    }
    if ([KHId isEqualToString:dataDic[@"customer_id"]]) {
        if ([KHId isEqualToString:@"1"]) {
            
        }else{
            alertV.message = @"购买客户和寄卖客户相同";
            [alertV show];
            return;
        }
    }
    
    if ([_SPSLTextField.text integerValue] < [_XSSLTextField.text integerValue]) {
        
        alertV.message = @"销售数量太大";
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
    
    if ([dataDic[@"status"] isEqualToString:@"2"]) {
        paymentCollectionVC.JMJSDic = dataDic;
        paymentCollectionVC.JSRDic = _XSJSRDic;
    }else{
        
        paymentCollectionVC.numbel = _XSSLTextField.text;
        paymentCollectionVC.HSDic = dataDic;
        paymentCollectionVC.KHId = KHId;
        paymentCollectionVC.dic = ZFDic;
        paymentCollectionVC.KHDic = [KHDic copy];
        paymentCollectionVC.JSRDic = _XSJSRDic;
        
    }
    

    [self.navigationController pushViewController:paymentCollectionVC animated:YES];
    
    
    
    _XSJSRDic = nil;
    KHId = @"1";
    [KHDic setValue:@"1" forKey:@"id"];
    [KHDic setValue:@"客户1" forKey:@"name"];
    [KHDic setValue:@"" forKey:@"phone"];

}



//购买用户
- (IBAction)GMYHAction:(id)sender {
    
    
//    CustomerInformationViewController *customerInformationVC = [[CustomerInformationViewController alloc]init];
//    customerInformationVC.KHId = dataDic[@"customer_id"];
//    [self.navigationController pushViewController:customerInformationVC animated:YES];
//    

    
}
//抵款确定
- (IBAction)DKQDAction:(id)sender {
    
    if ([_DKSLTextField.text integerValue] > [_SPSLTextField.text integerValue] ) {
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"数量太大" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        return;
    }else if ([_DKSLTextField.text isEqualToString:@""]||[_DKSLTextField.text isEqualToString:@"0"]){
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"数量不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        return;
    }else if ([_DJTextField.text isEqualToString:@""]){
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"抵价不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        return;
        
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:dataDic[@"goods"]];
    
    [dic setObject:_DJTextField.text forKey:@"DJ"];
    [dic setObject:_DKSLTextField.text forKey:@"SL"];
    [dic setObject:@"JM" forKey:@"noti"];
    [dic setObject:dataDic[@"goods"][@"goods_id"] forKey:@"id"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowNotification" object:dic];
    
    NSArray *arr = self.navigationController.viewControllers;
    
    [self.navigationController popToViewController:arr[2] animated:YES];

}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    bgView.hidden = YES;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"寄卖背景"] forBarMetrics:UIBarMetricsDefault];
    
    [_BQArr removeAllObjects];
    [_dataArr removeAllObjects];
    
    JSRCellHeight = 170;
    TextCellHeight = 51;

    
    [self loadData];

    
}



- (void)NSNotificationSFJLPush:(NSNotification*)noti{

    sfjlV.hidden = YES;
    bgView.hidden = YES;
    
    BooksDetailsViewController *booksDetailsVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"BooksDetailsViewController"];
    
    
    booksDetailsVC.booksId = [noti object];
    
    [self.navigationController pushViewController:booksDetailsVC animated:YES];


}

//跳转编辑备注
- (IBAction)EditRemarkAction:(id)sender {
    
    EditRemarkViewController *editRemark  = [[EditRemarkViewController alloc]init];
    
    editRemark.remarktext = dataDic[@"remark"];
    editRemark.goods_id = dataDic[@"goods"][@"goods_id"];
    [self.navigationController pushViewController:editRemark animated:YES];
}
//一键复制
- (IBAction)remarkAction:(id)sender {
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _BZTextView.text;
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

//通知改变备注
//- (void)remarkEditAction:(NSNotification*)noti{
//    
//    _BZTextView.text = [noti object];
//    
//    if (![_BZTextView.text isEqualToString:@""]) {
//        _BZLabel.hidden = YES;
//    }
//    
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:dataDic];
//    
//    [dic setObject:_BZTextView.text forKey:@"remark"];
//    
//    dataDic = [dic copy];
//    
//}

- (IBAction)editSNAction:(id)sender {
    
    EditSNViewController *editSNVC = [[EditSNViewController alloc]init];
    editSNVC.goods_id = dataDic[@"goods"][@"goods_id"];

    editSNVC.dic = dataDic;
    [self.navigationController pushViewController:editSNVC animated:YES];
    
}

//- (void)SNEditAction:(NSNotification*)noti{
//    
//    _SPBHLabel.text = [NSString stringWithFormat:@"寄卖单号:%@",[noti object]];
//    
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:dataDic];
//    
//    NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:dataDic[@"goods"]];
//    [dic1 setObject:[noti object] forKey:@"goods_sn"];
//    [dic setObject:dic1 forKey:@"goods"];
//    
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
    
//    [_XSJSRButton setTitle:[NSString stringWithFormat:@"经手人:%@",_XSJSRDic[@"user_name"]] forState:UIControlStateNormal];
    
    }
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
    
    
    for (NSDictionary *dic1 in dataDic[@"goods"][@"attribute"]) {
        
        if ([dic1[@"type"] isEqualToString:@"text"]) {
            [textArr addObject:dic1];
        }
    }
    
    EditRemarkViewController *editRemark  = [[EditRemarkViewController alloc]init];
    editRemark.text_title = textArr[bt.tag - 100][@"attribute_name"];
    editRemark.remarktext = textArr[bt.tag - 100][@"attribute_value"];
    editRemark.goods_id = dataDic[@"goods"][@"goods_id"];
    editRemark.text_id = textArr[bt.tag - 100][@"id"];
    [self.navigationController pushViewController:editRemark animated:YES];
    
    
}
//自定义复制

- (void)copyBZActon:(UIButton*)bt{
    
    NSMutableArray *textArr = [NSMutableArray array];
    
    
    for (NSDictionary *dic1 in dataDic[@"goods"][@"attribute"]) {
        
        
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

- (IBAction)OnePushAction:(id)sender {
    
    OneButtonPublishingViewController *OneButtonPublishingVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"OneButtonPublishingViewController"];
    
    NSDictionary *dic = @{@"title":dataDic[@"goods"][@"goods_name"],@"price":[NSString stringWithFormat:@"%ld",[dataDic[@"price"] integerValue]],@"img":dataDic[@"goods"][@"pic"][@"href"]};
    OneButtonPublishingVC.oldDic = dic;

    
    [self.navigationController pushViewController:OneButtonPublishingVC animated:YES];
    

}


@end
