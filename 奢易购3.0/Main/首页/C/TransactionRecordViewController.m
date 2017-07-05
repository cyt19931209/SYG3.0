//
//  TransactionRecordViewController.m
//  奢易购3.0
//
//  Created by guest on 16/7/21.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "TransactionRecordViewController.h"
#import "AppDelegate.h"
#import "SFJLView.h"
#import "BooksDetailsViewController.h"
#import "StockCellectionCell.h"
#import "ScanViewController.h"
#import "MBProgressHUD.h"

@interface TransactionRecordViewController ()<UICollectionViewDataSource,UIAlertViewDelegate>{

    //收付记录
    SFJLView *sfjlV;
    UIView *bgView;
    
    NSDictionary *dataDic;
    
    UIAlertView *alertV1;

}
@property (weak, nonatomic) IBOutlet UICollectionView *stockCollectionView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@property (weak, nonatomic) IBOutlet UILabel *XSJSRLabel;

@property (weak, nonatomic) IBOutlet UILabel *JSJSRLabel;
@property (weak, nonatomic) IBOutlet UIButton *JJButton;
@end

@implementation TransactionRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"交易记录";
    
    _dataArr = [NSMutableArray array];

    _THButton.hidden = YES;
    _JJButton.userInteractionEnabled = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotificationSFJLPush:) name:@"NSNotificationSFJLPush" object:nil];

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
    
    [_stockCollectionView registerNib:[UINib nibWithNibName:@"StockCellectionCell" bundle:nil] forCellWithReuseIdentifier:@"StockCellectionCell"];

    
    //右边Item
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 35, 30);
    [rightBtn setTitle:@"删除" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    
    //加载数据
    [self loadData];
    
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
    
}
//删除销售记录
- (void)editAction{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:dataDic[@"data"][@"id"] forKey:@"sales_id"];
    
    [DataSeviece requestUrl:delete_saleshtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
            hud.labelText = @"删除成功";
            hud.mode = MBProgressHUDModeCustomView;
            hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"done@2x"]];
            [[UIApplication sharedApplication].keyWindow addSubview:hud];
            
            [hud showAnimated:YES whileExecutingBlock:^{
                sleep(1);
                
            } completionBlock:^{
                [hud removeFromSuperview];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"StockNotification" object:nil];
                
                [self.navigationController popViewControllerAnimated:YES];

            }];

        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)bgButtonAction{
    bgView.hidden = YES;
    sfjlV.hidden = YES;

}


//加载数据
- (void)loadData{
 
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:_sales_id forKey:@"id"];
    
    [DataSeviece requestUrl:Salesget_saleshtml params:params success:^(id result) {
        
        NSLog(@"%@",result[@"result"][@"msg"]);
        NSDictionary *dic = [NULLHandle NUllHandle:result[@"result"]];
        NSLog(@"%@",dic);
        dataDic = dic;
        _nameLabel.text = [NSString stringWithFormat:@"%@ x%@",dic[@"data"][@"goods_list"][0][@"goods_name"],dic[@"data"][@"goods_list"][0][@"quantity"]];
        _XMLabel.text = [NSString stringWithFormat:@"购买客户:%@",dic[@"data"][@"customer_name"]];
        
        _GHFLabel.text = [NSString stringWithFormat:@"供货方:%@",dic[@"data"][@"goods_list"][0][@"customer_name"]];
        
//        _HHLabel.text = [NSString stringWithFormat:@"货号:%@",dic[@"data"][@"goods_list"][0][@"goods_sn"]];
        if ([result[@"result"][@"data"][@"goods_list"][0][@"is_new"] isEqualToString:@"1"]) {
            _QXESLabel.text = @"全新";
        }else{
            _QXESLabel.text = @"二手";
        }
        
        _MJLabel.text = [NSString stringWithFormat:@"卖价:¥%ld",[result[@"result"][@"data"][@"goods_list"][0][@"total_price"] integerValue]];
        if ([result[@"result"][@"data"][@"goods_list"][0][@"type"] isEqualToString:@"HS"]) {
            
            if ([[defaults objectForKey:[NSString stringWithFormat:@"%@switch",SYGData[@"id"]]] isEqualToString:@"1"]) {
                _JJButton.userInteractionEnabled = YES;
                _JJLabel.text = [NSString stringWithFormat:@"进价:¥%ld",[dataDic[@"data"][@"goods_list"][0][@"total_cost"] integerValue]];
                
                _LRLabel.text = [NSString stringWithFormat:@"利润:¥%ld",[dataDic[@"data"][@"goods_list"][0][@"total_profit"] integerValue]];
            }else{
            
            _JJButton.userInteractionEnabled = YES;
            _JJLabel.text = @"进价:*****";
            _LRLabel.text = @"利润:*****";
            }
        }else{
            
            _JJLabel.text = [NSString stringWithFormat:@"客户到手价:¥%ld",[result[@"result"][@"data"][@"goods_list"][0][@"customer_price"] integerValue]];
            _LRLabel.text = [NSString stringWithFormat:@"利润:¥%ld",[result[@"result"][@"data"][@"goods_list"][0][@"total_profit"] integerValue]];

        }
        
        if ([result[@"result"][@"data"][@"status"] isEqualToString:@"1"]) {
            
            NSLog(@"%@",result[@"result"][@"data"][@"goods_list"][0][@"on_the_way"]);
            
            if ([result[@"result"][@"data"][@"goods_list"][0][@"on_the_way"] isEqualToString:@"0"]) {
                _ZTLabel.text = @"状态:已完成";
            }else{
                _ZTLabel.text = @"状态:进行中";
            }
        }else if ([result[@"result"][@"data"][@"status"] isEqualToString:@"2"]){
            _ZTLabel.text = @"状态:退款";
        }else if ([result[@"result"][@"data"][@"status"] isEqualToString:@"3"]){
            _ZTLabel.text = @"状态:进行中";
        }else if ([result[@"result"][@"data"][@"status"] isEqualToString:@"4"]){
            _ZTLabel.text = @"状态:待结算";
        }
        
        if (result[@"result"][@"data"][@"goods_list"][0][@"consighment_add_user_name"]) {
            
            if (![result[@"result"][@"data"][@"goods_list"][0][@"consighment_add_user_name"] isEqualToString:@""]) {
                _JSJSRLabel.text = [NSString stringWithFormat:@"结算经手人:%@",result[@"result"][@"data"][@"goods_list"][0][@"consighment_add_user_name"]];
 
            }
        }

        _JSRLabel.text = [NSString stringWithFormat:@"入库经手人:%@",result[@"result"][@"data"][@"goods_list"][0][@"add_user_name"]];
        _XSJSRLabel.text = [NSString stringWithFormat:@"销售经手人:%@",result[@"result"][@"data"][@"add_user_name"]];
        NSTimeInterval time=[result[@"result"][@"data"][@"add_time"] doubleValue];//因为时差问题要加8小时 == 28800 sec
        NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];

        NSTimeInterval time1=[result[@"result"][@"data"][@"goods_list"][0][@"add_time"] doubleValue];//因为时差问题要加8小时 == 28800 sec
        
        NSDate *detaildate1=[NSDate dateWithTimeIntervalSince1970:time1];
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
        
        NSString *currentDateStr1 = [dateFormatter1 stringFromDate: detaildate1];
        
        _JHSJLabel.text = [NSString stringWithFormat:@"进货时间:%@",currentDateStr1];

        _MCSJLabel.text = [NSString stringWithFormat:@"卖出时间:%@",currentDateStr];

        for (NSDictionary *dic1 in _arr) {
            if ([dic1[@"id"] isEqualToString:dic[@"data"][@"goods_list"][0][@"category_id"]]) {
                _LXImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",dic1[@"category_name"]]];
            }
        }
        if (!_LXImageV.image) {
            _LXImageV.image = [UIImage imageNamed:@"其他"];
        }
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"goods_list"][0][@"photo"]) {
            NSDictionary *dic1 = [NULLHandle NUllHandle:dic];
            [_dataArr addObject:dic1];
        }
        
        
        NSLog(@"%@",_dataArr);
        
        sfjlV = [[[NSBundle mainBundle]loadNibNamed:@"SFJLView" owner:self options:nil]lastObject];
        sfjlV.frame = CGRectMake(10, 64, kScreenWidth-20, 450);
        sfjlV.layer.cornerRadius = 5;
        sfjlV.layer.masksToBounds = YES;
        sfjlV.isXS = YES;
        sfjlV.dataArr = dataDic[@"data"][@"goods_list"][0][@"paylog"];
        sfjlV.SFJLLabel.text = [NSString stringWithFormat:@"%@收付记录",dataDic[@"data"][@"goods_list"][0][@"goods_sn"]];
        sfjlV.hidden = YES;
        [[UIApplication sharedApplication].keyWindow addSubview:sfjlV];
        
        __weak UIView *weakbgV = bgView;
        __weak UIView *wadksfjlV = sfjlV;
        sfjlV.backBlock =^(){
            wadksfjlV.hidden = YES;
            weakbgV.hidden = YES;
        };

        [_stockCollectionView reloadData];

        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

//左边返回按钮
- (void)leftBtnAction{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackNotification" object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//收付记录
- (IBAction)sfjlAction:(id)sender {
    
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

- (void)NSNotificationSFJLPush:(NSNotification*)noti{
    
    sfjlV.hidden = YES;
    bgView.hidden = YES;
    
    BooksDetailsViewController *booksDetailsVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"BooksDetailsViewController"];
    
    
    booksDetailsVC.booksId = [noti object];
    
    [self.navigationController pushViewController:booksDetailsVC animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    //改变导航栏标题的字体颜色和大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏背景.png"] forBarMetrics:UIBarMetricsDefault];
    


}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (IBAction)JJShowAction:(id)sender {
    
    if (![_JJLabel.text isEqualToString:[NSString stringWithFormat:@"进价:¥%ld",[dataDic[@"data"][@"goods_list"][0][@"total_cost"] integerValue]]]) {
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        alertV.alertViewStyle = UIAlertViewStyleSecureTextInput;
        
        [alertV show];
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
//    
    UITextField *tf = [alertView textFieldAtIndex:0];
    
    [MD5CommonDigest MD5:tf.text success:^(id result) {
        
        NSLog(@"%@",result);
        
        if ([result isEqualToString:@"1"]) {
            if (alertV1 == alertView) {
                sfjlV.hidden = NO;
                bgView.hidden = NO;
                
            }else{
                _JJLabel.text = [NSString stringWithFormat:@"进价:¥%ld",[dataDic[@"data"][@"goods_list"][0][@"total_cost"] integerValue]];
                
                _LRLabel.text = [NSString stringWithFormat:@"利润:¥%ld",[dataDic[@"data"][@"goods_list"][0][@"total_profit"] integerValue]];
            }

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
//        if (alertV1 == alertView) {
//            sfjlV.hidden = NO;
//            bgView.hidden = NO;
//            
//        }else{
//            _JJLabel.text = [NSString stringWithFormat:@"进价:¥%ld",[dataDic[@"data"][@"goods_list"][0][@"total_cost"] integerValue]];
//
//            _LRLabel.text = [NSString stringWithFormat:@"利润:¥%ld",[dataDic[@"data"][@"goods_list"][0][@"total_profit"] integerValue]];
//        }
//        
//    }else{
//        
//        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        
//        [alertV show];
//        
//    }
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




@end
