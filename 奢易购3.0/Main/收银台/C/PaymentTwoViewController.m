//
//  PaymentTwoViewController.m
//  奢易购3.0
//
//  Created by Andy on 16/9/27.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "PaymentTwoViewController.h"
#import "PaymentCell.h"
#import "StorageViewController.h"
#import "StockPriceViewController.h"
#import "FinanceViewController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"

@interface PaymentTwoViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{

    UITableView *paymentTableView;
    
    UIView *bgView;
    
    UIView *zffsView;
    
    UITableView *zffsTableView;
    
    //判断第几个
    NSInteger index;
    
    UITextView *remarkTextView;
    
    UITextField *moneyTextField;
    
    
    CGFloat contoffY;
    
    
    UIButton *SKButton;
    
    UIButton *FKButton;
    
    UIButton *qrfkButton;
    UIButton *xjybButton;
    UILabel *FKFSLabel;
    
    UILabel *oldMoneyLabel;
    
    
    NSString *imageUrl;
    
    UIButton *imageButton;
    
    UIActionSheet *_sheet4;
    UIImagePickerController *_pick4;
    UIImagePickerController *_pick8;

}


@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) NSMutableArray *zffsDataArr;
@end

@implementation PaymentTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(delegePayment:) name:@"delegePayment" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zffsPayment:) name:@"zffsPayment" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShowAction:) name:@"ShowNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EndEditingTextField) name:@"EndEditingTextField" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BeginEditingTextField) name:@"BeginEditingTextField" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EndEditingTextFieldOne) name:@"EndEditingTextFieldOne" object:nil];
    
    self.navigationItem.title = @"收银台";
    
    imageUrl = @"";
    _dataArr = [NSMutableArray array];
    _zffsDataArr = [NSMutableArray array];
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"返回（20x38）.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    //视图加载
    
    [self createUI];
    
    
    //隐藏键盘
    UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleAction1)];;
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    singleRecognizer.cancelsTouchesInView = NO;
    
    //给self.view添加一个手势监测；
    
    [self.view addGestureRecognizer:singleRecognizer];

}
//隐藏键盘
- (void)singleAction1{

    [moneyTextField resignFirstResponder];
    
    [remarkTextView resignFirstResponder];
    for (int i = 0; i < _dataArr.count; i++) {
        
        UITextField *textField = [paymentTableView viewWithTag:1000+i];

        [textField resignFirstResponder];
        
    }

}

//加载视图
- (void)createUI{
    
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
    
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 240+14+34)];
    
    
    UIView *topbgView = [[UIView alloc]initWithFrame:CGRectMake(0, 14, kScreenWidth, 240)];
    
    topbgView.backgroundColor = [UIColor whiteColor];
    
    topbgView.layer.cornerRadius = 5;
    
    topbgView.layer.masksToBounds = YES;
    
    [headerView addSubview:topbgView];
    
    //计算器
    UIButton *jsqButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [jsqButton setImage:[UIImage imageNamed:@"计算器（收银台）"] forState:UIControlStateNormal];
    
    jsqButton.frame = CGRectMake(10, 10, 22, 22);
    
    [jsqButton addTarget:self action:@selector(jsqAction) forControlEvents:UIControlEventTouchUpInside];
    
    [topbgView addSubview:jsqButton];
    //问号
    UIButton *whButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [whButton setImage:[UIImage imageNamed:@"？"] forState:UIControlStateNormal];
    
    whButton.frame = CGRectMake(kScreenWidth - 32, 10, 22, 22);
    
    [whButton addTarget:self action:@selector(whAction) forControlEvents:UIControlEventTouchUpInside];
    
    [topbgView addSubview:whButton];
    //金额
    moneyTextField = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 75, 54, 150, 40)];
    moneyTextField.font = [UIFont systemFontOfSize:30];
    moneyTextField.textColor = [RGBColor colorWithHexString:@"#666666"];
    moneyTextField.textAlignment = NSTextAlignmentCenter;
    moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
    moneyTextField.delegate = self;
    [topbgView addSubview:moneyTextField];
    
    //
    
    UIImageView *moneyImageV = [[UIImageView alloc]initWithFrame:CGRectMake(80, 63, 17, 22)];
    
    moneyImageV.image = [UIImage imageNamed:@"¥@2x"];
    
    [topbgView addSubview:moneyImageV];
    
    
    UIButton *moneyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [moneyButton setImage:[UIImage imageNamed:@"xiugai@2x"] forState:UIControlStateNormal];
    
    moneyButton.frame = CGRectMake(moneyTextField.right, moneyTextField.bottom - 32, 35, 32);
    
    [moneyButton addTarget:self action:@selector(moneyAction) forControlEvents:UIControlEventTouchUpInside];
    
    [topbgView addSubview:moneyButton];
    
    UILabel *FKLabel;
    
    SKButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [SKButton setImage:[UIImage imageNamed:@"skbtn@2x"] forState:UIControlStateNormal];
    [SKButton setImage:[UIImage imageNamed:@"skanbtn@2x"] forState:UIControlStateSelected];
    SKButton.frame = CGRectMake(kScreenWidth/2 - 100, moneyTextField.bottom , 87, 48);
    SKButton.hidden = YES;
    [SKButton addTarget:self action:@selector(SKAction) forControlEvents:UIControlEventTouchUpInside];
    [topbgView addSubview:SKButton];
    
    FKButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [FKButton setImage:[UIImage imageNamed:@"fuk@2x"] forState:UIControlStateNormal];
    [FKButton setImage:[UIImage imageNamed:@"fkan@2x"] forState:UIControlStateSelected];
    FKButton.frame = CGRectMake(kScreenWidth/2 +13, moneyTextField.bottom , 87, 48);
    FKButton.hidden = YES;
    [FKButton addTarget:self action:@selector(FKAction) forControlEvents:UIControlEventTouchUpInside];
    [topbgView addSubview:FKButton];
    
    
    if ([_isSF isEqualToString:@"FK"]) {
        
        SKButton.hidden = NO;
        FKButton.hidden = NO;
        SKButton.selected = YES;
        
    }else if ([_isSF isEqualToString:@"SK"]){
        SKButton.hidden = NO;
        FKButton.hidden = NO;
        FKButton.selected = YES;

    }else{
    
    FKLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 75, moneyTextField.bottom +10, 150, 20)];
    FKLabel.textColor = [RGBColor colorWithHexString:@"#999999"];
    FKLabel.font = [UIFont systemFontOfSize:15];
    FKLabel.text = @"付款给:王天霸";
    FKLabel.textAlignment = NSTextAlignmentCenter;
    [topbgView addSubview:FKLabel];
    
    }
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 145, kScreenWidth, 1)];
    
    lineV.backgroundColor = [RGBColor colorWithHexString:@"#999999"];
    
    [topbgView addSubview:lineV];
    
    
    
    UILabel *bzLabel = [[UILabel alloc]init];

    
    if (_isSF) {
        
        bzLabel.frame = CGRectMake(64, lineV.bottom+15, 40, 20);
        
        imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        imageButton.frame = CGRectMake(10, lineV.bottom + 15, 44, 44);
        
        [imageButton setImage:[UIImage imageNamed:@"添加图片.png"] forState:UIControlStateNormal];
    
        [imageButton addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [topbgView addSubview:imageButton];
        
    }else{
        
        bzLabel.frame = CGRectMake(10, lineV.bottom+15, 40, 20);

    }
    
    bzLabel.text = @"备注:";
    
    bzLabel.textColor = [RGBColor colorWithHexString:@"#999999"];
    
    bzLabel.font = [UIFont systemFontOfSize:15];
    
    [topbgView addSubview:bzLabel];
    
    remarkTextView = [[UITextView alloc]initWithFrame:CGRectMake(bzLabel.right, lineV.bottom+8, kScreenWidth - bzLabel.right - 10, 65)];
    
    remarkTextView.textColor = [RGBColor colorWithHexString:@"#666666"];
    
    remarkTextView.font = [UIFont systemFontOfSize:15];
    
    [topbgView addSubview:remarkTextView];
    
    UIButton *remarkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [remarkButton setImage:[UIImage imageNamed:@"xiugai@2x"] forState:UIControlStateNormal];
    
    remarkButton.frame = CGRectMake(remarkTextView.right - 20, remarkTextView.bottom - 10, 35, 32);
    
    [remarkButton addTarget:self action:@selector(remarkAction) forControlEvents:UIControlEventTouchUpInside];
    
    [topbgView addSubview:remarkButton];

    
    
    FKFSLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, topbgView.bottom, 70, 44)];
    FKFSLabel.textColor = [RGBColor colorWithHexString:@"#999999"];
    
    FKFSLabel.font = [UIFont systemFontOfSize:14];
    FKFSLabel.text = @"收款方式";
    [headerView addSubview:FKFSLabel];
    
    UIButton *xzcwzhButton = [UIButton buttonWithType:UIButtonTypeCustom];
    xzcwzhButton.frame = CGRectMake(kScreenWidth - 100, topbgView.bottom, 100, 44);
    xzcwzhButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [xzcwzhButton setTitleColor:[RGBColor colorWithHexString:@"#787fc6"] forState:UIControlStateNormal];
    [xzcwzhButton setTitle:@"新增财务账号" forState:UIControlStateNormal];
    [xzcwzhButton addTarget:self action:@selector(xzcwzhAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:xzcwzhButton];
    
    paymentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 50 - 64) style:UITableViewStyleGrouped];
    paymentTableView.delegate = self;
    paymentTableView.dataSource = self;
    paymentTableView.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    [self.view addSubview:paymentTableView];
    
    [paymentTableView registerNib:[UINib nibWithNibName:@"PaymentCell" bundle:nil] forCellReuseIdentifier:@"PaymentCell"];
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];

    UIButton *footButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [footButton setImage:[UIImage imageNamed:@"add@2x"] forState:UIControlStateNormal];
    
    footButton.frame = CGRectMake(kScreenWidth/2 - 25, 10, 50, 50);
    
    [footButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:footButton];
    
    oldMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, 20)];
    
    oldMoneyLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
    
    oldMoneyLabel.font = [UIFont systemFontOfSize:15];
    oldMoneyLabel.text = @"还需支付:0";
    oldMoneyLabel.textAlignment = NSTextAlignmentCenter;
    [footView addSubview:oldMoneyLabel];
    
    paymentTableView.tableFooterView = footView;
    
    paymentTableView.tableHeaderView = headerView;
    
    if (!_isSF) {
        
    xjybButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    xjybButton.frame = CGRectMake(0, kScreenHeight - 50 - 64, kScreenWidth/2, 50);
    xjybButton.backgroundColor = [UIColor whiteColor];
    [xjybButton setTitle:@"先记一笔" forState:UIControlStateNormal];
    
    xjybButton.titleLabel.font = [UIFont systemFontOfSize:20];
    
    [xjybButton setTitleColor:[RGBColor colorWithHexString:@"#787fc6"] forState:UIControlStateNormal];
    xjybButton.layer.borderWidth = 1;
    xjybButton.layer.borderColor = [RGBColor colorWithHexString:@"#787fc6"].CGColor;
    
    [xjybButton addTarget:self action:@selector(xjybAction) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:xjybButton];
    
    qrfkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    qrfkButton.frame = CGRectMake(kScreenWidth/2, kScreenHeight - 50 - 64, kScreenWidth/2, 50);
    qrfkButton.backgroundColor = [RGBColor colorWithHexString:@"#787fc6"];
    [qrfkButton setTitle:@"确认收款" forState:UIControlStateNormal];
    qrfkButton.titleLabel.font = [UIFont systemFontOfSize:20];
    
    [qrfkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    qrfkButton.layer.borderWidth = 1;
    qrfkButton.layer.borderColor = [RGBColor colorWithHexString:@"#787fc6"].CGColor;
    
    [qrfkButton addTarget:self action:@selector(qrfkAction) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:qrfkButton];
    
    }else{
        oldMoneyLabel.hidden = YES;
        qrfkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        qrfkButton.frame = CGRectMake(0, kScreenHeight - 50 - 64, kScreenWidth, 50);
        qrfkButton.backgroundColor = [RGBColor colorWithHexString:@"#787fc6"];
        [qrfkButton setTitle:@"确认付款" forState:UIControlStateNormal];
        qrfkButton.titleLabel.font = [UIFont systemFontOfSize:20];
        
        [qrfkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        qrfkButton.layer.borderWidth = 1;
        qrfkButton.layer.borderColor = [RGBColor colorWithHexString:@"#787fc6"].CGColor;
        
        [qrfkButton addTarget:self action:@selector(qrfkAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:qrfkButton];
        
    }
    
    if ([isType isEqualToString:@"JM"]) {
        
        moneyTextField.text = [NSString stringWithFormat:@"%ld",[_dic[@"price"] integerValue] * [_numbel integerValue]];
        remarkTextView.text = [NSString stringWithFormat:@"%@售出收款",_dic[@"goods"][@"goods_sn"]];
        FKFSLabel.text = @"收款方式";
        FKLabel.text = [NSString stringWithFormat:@"向%@收款",_KHDic[@"name"]];
        [qrfkButton setTitle:@"确认收款" forState:UIControlStateNormal];
    }else if ([isType isEqualToString:@"HS"]){
        moneyTextField.text = [NSString stringWithFormat:@"%ld",[_HSDic[@"price"] integerValue]* [_numbel integerValue]];
        remarkTextView.text = [NSString stringWithFormat:@"%@售出收款",_HSDic[@"goods_sn"]];
        
        FKFSLabel.text = @"收款方式";
        FKLabel.text = [NSString stringWithFormat:@"向%@收款",_KHDic[@"name"]];
        [qrfkButton setTitle:@"确认收款" forState:UIControlStateNormal];

    }else if ([isType isEqualToString:@"HSRK"]){
        NSLog(@"%@",_HSRKDic);
        
        moneyTextField.text = [NSString stringWithFormat:@"%ld",[_HSRKDic[@"cost"] integerValue] *[_HSRKDic[@"number"] integerValue]];
        remarkTextView.text = [NSString stringWithFormat:@"%@回收进货款",_HSRKDic[@"goods_sn"]];
        FKFSLabel.text = @"付款方式";
        FKLabel.text = [NSString stringWithFormat:@"向%@付款",_KHDic[@"name"]];
        [qrfkButton setTitle:@"确认付款" forState:UIControlStateNormal];

    }else if ([isType isEqualToString:@"Home1"]){
        float money = [_HomeDic1[@"total_amount"] floatValue] - [_HomeDic1[@"total_price"]floatValue];
        moneyTextField.text = [NSString stringWithFormat:@"%.2lf",money];
        remarkTextView.text = [NSString stringWithFormat:@"%@待收款",_HomeDic1[@"goods_list"][0][@"goods_sn"]];
        FKFSLabel.text = @"收款方式";
        FKLabel.text = [NSString stringWithFormat:@"向%@收款",_HomeDic1[@"customer_name"]];
        [qrfkButton setTitle:@"确认收款" forState:UIControlStateNormal];

        
    }else if ([isType isEqualToString:@"Home3"]){
        
        moneyTextField.text = [NSString stringWithFormat:@"%.2lf",[_HomeDic3[@"goods_list"][0][@"customer_price"] floatValue] - [_HomeDic3[@"goods_list"][0][@"customer_price_has_pay"] floatValue]];
        
        remarkTextView.text = [NSString stringWithFormat:@"%@寄卖结算",_HomeDic3[@"goods_list"][0][@"goods_sn"]];
        
        FKFSLabel.text = @"付款方式";
        FKLabel.text = [NSString stringWithFormat:@"向%@付款",_HomeDic3[@"goods_list"][0][@"customer_name"]];
        [qrfkButton setTitle:@"确认付款" forState:UIControlStateNormal];

    }else if ([isType isEqualToString:@"Home2"]){
        
        moneyTextField.text = [NSString stringWithFormat:@"%ld",[_HomeDic2[@"unpay"] integerValue]];
        remarkTextView.text = [NSString stringWithFormat:@"%@回收款",_HomeDic2[@"goods_sn"]];

        FKFSLabel.text = @"付款方式";
        FKLabel.text = [NSString stringWithFormat:@"向%@付款",_HomeDic2[@"customer_name"]];
        [qrfkButton setTitle:@"确认付款" forState:UIControlStateNormal];

    }else if ([isType isEqualToString:@"JMJS"]){
        
        float money = [_JMJSDic[@"commission_total"] floatValue];
        
        for (NSDictionary *dic in _JMJSDic[@"paylog"]) {
            
            float money1 = [dic[@"amount"] floatValue];
            
            money  = money - money1;
        }
        moneyTextField.text = [NSString stringWithFormat:@"%.2lf",money];
        remarkTextView.text = [NSString stringWithFormat:@"%@结算款",_JMJSDic[@"goods"][@"goods_sn"]];
        FKFSLabel.text = @"付款方式";
        FKLabel.text = [NSString stringWithFormat:@"向%@付款",_JMJSDic[@"customer_name"]];
        [qrfkButton setTitle:@"确认付款" forState:UIControlStateNormal];

    }
    
    if ([moneyTextField.text isEqualToString:@""]) {
        moneyTextField.text = @"0";
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *dic;
    
    if ([defaults objectForKey:[NSString stringWithFormat:@"%@-",SYGData[@"id"]]]) {
        dic = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:[NSString stringWithFormat:@"%@-",SYGData[@"id"]]]];
        
    }else{
    dic = [NSMutableDictionary dictionary];
    
    [dic setObject:@"1" forKey:@"account_id"];
    
    [dic setObject:@"0" forKey:@"type"];
    
    [dic setObject:@"现金支付" forKey:@"account"];
    }
    
    [dic setObject:moneyTextField.text forKey:@"amount"];

    [_dataArr addObject:dic];
    
}

//添加图片
- (void)imageButtonAction:(UIButton*)bt{

    _sheet4 = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    
    [_sheet4 showInView:self.view];


}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        //跳转系统相册
        
        _pick4 = [[UIImagePickerController alloc] init];
        
        _pick4.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        _pick4.delegate = self;
        
        //跳转到系统相册
        
        [self presentViewController:_pick4 animated:YES completion:nil];
        
    }else if (buttonIndex == 0){
        
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        
        if (!isCamera) {
            
            UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:@"没有可用的摄像头" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            
            [alerView show];
            
            
        }else{
            
            _pick8 = [[UIImagePickerController alloc]init];
            
            _pick8.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            _pick8.delegate = self;
            
            [self presentViewController:_pick8 animated:YES completion:NULL];
        }
        
        
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    //    获取图片
    
    UIImage *img = info[@"UIImagePickerControllerOriginalImage"];
    
    
    if (_pick4 == picker){
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        [imageButton setImage:img forState:UIControlStateNormal];
        imageButton.layer.cornerRadius = 5;
        imageButton.layer.masksToBounds = YES;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
        
        NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
        
        [params1 setObject:SYGData[@"id"] forKey:@"uid"];
        
        
        [DataSeviece requestUrl:get_qiniu_tokenhtml params:params1 success:^(id result) {
            
            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            
            [params setObject:@{@"uid":SYGData[@"id"]} forKey:@"data"];
            
            [manager POST:@"http://up-z2.qiniu.com" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                
                NSData *imgData = UIImageJPEGRepresentation(img, .5);
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // 设置时间格式
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
                [formData appendPartWithFileData:imgData name:@"file" fileName:fileName mimeType:@"image/png"];
                
            } success:^(NSURLSessionDataTask *task, id responseObject) {
                
                NSLog(@"%@",responseObject);
                imageUrl = responseObject[@"result"][@"data"][@"file_name"];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@",error);
            }];

            
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
            
        }];
        

        
        

        

    }else if (_pick8 == picker){
        
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            //保存图片到相册
            UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        }
        
        [imageButton setImage:img forState:UIControlStateNormal];
        imageButton.layer.cornerRadius = 5;
        imageButton.layer.masksToBounds = YES;
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
        
        NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
        
        [params1 setObject:SYGData[@"id"] forKey:@"uid"];
        
        
        [DataSeviece requestUrl:get_qiniu_tokenhtml params:params1 success:^(id result) {
            
            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);

            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            
            [params setObject:@{@"uid":SYGData[@"id"]} forKey:@"data"];
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

            
            [manager POST:@"http://up-z2.qiniu.com" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                
                NSData *imgData = UIImageJPEGRepresentation(img, .5);
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // 设置时间格式
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
                [formData appendPartWithFileData:imgData name:@"file" fileName:fileName mimeType:@"image/png"];
                
            } success:^(NSURLSessionDataTask *task, id responseObject) {
                
                NSLog(@"%@",responseObject);
                imageUrl = responseObject[@"result"][@"data"][@"file_name"];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@",error);
            }];

            
            
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
            
        }];

        
    }
    
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error
  contextInfo: (void *) contextInfo
{
    NSLog(@"保存成功");
}




//收款
- (void)SKAction{
    
    SKButton.selected = NO;
    FKButton.selected = YES;
    _isSF = @"SK";
    FKFSLabel.text = @"收款方式";
    
    [qrfkButton setTitle:@"确认收款" forState:UIControlStateNormal];
}
//付款
- (void)FKAction{
    
    SKButton.selected = YES;
    FKButton.selected = NO;
    _isSF = @"FK";
    FKFSLabel.text = @"付款方式";
    [qrfkButton setTitle:@"确认付款" forState:UIControlStateNormal];


}

//新增财务账号
- (void)xzcwzhAction{
    FinanceViewController *financeVC = [[FinanceViewController alloc]init];
    financeVC.isPersonnel = NO;
    
    [self.navigationController pushViewController:financeVC animated:YES];
    
}

//隐藏视图
- (void)bgButtonAction{

    bgView.hidden = YES;
    
    zffsView.hidden = YES;
    
    showView.hidden = YES;
    key.hidden = YES;

}

- (void)setDic:(NSDictionary *)dic{
    
    _dic = dic;
    isType = @"JM";
    
}

- (void)setHSDic:(NSDictionary *)HSDic{
    _HSDic = HSDic;
    isType = @"HS";
    isJM = YES;
}

- (void)setHSRKDic:(NSDictionary *)HSRKDic{
    _HSRKDic = HSRKDic;
    isType = @"HSRK";

}

- (void)setHomeDic1:(NSDictionary *)HomeDic1{
    _HomeDic1 = HomeDic1;
    isType = @"Home1";
    isJM = YES;
    
}

- (void)setHomeDic3:(NSDictionary *)HomeDic3{
    
    _HomeDic3 = HomeDic3;
    
    isType = @"Home3";
    

    
}

- (void)setHomeDic2:(NSDictionary *)HomeDic2{
    _HomeDic2 = HomeDic2;
    isType = @"Home2";
}

- (void)setJMJSDic:(NSDictionary *)JMJSDic{
    
    _JMJSDic = JMJSDic;
    isType = @"JMJS";
    
}

- (void)setIsSF:(NSString *)isSF{
    
    _isSF = isSF;

    
}


//确认付款
- (void)qrfkAction{
    
    
    for (int i = 0; i < _dataArr.count; i++) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[i]];
        
        UITextField *textfield = [paymentTableView viewWithTag:1000+i];
        if (textfield) {
            [dic setObject:textfield.text forKey:@"amount"];
            
        }
        [_dataArr replaceObjectAtIndex:i withObject:dic];
    }

    NSLog(@"%@",_dataArr);
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    int money = 0;
    
    for (int i = 0; i<_dataArr.count; i++) {
        
        money = money + [_dataArr[i][@"amount"] intValue];
    }
    if (money != [moneyTextField.text intValue]) {
        
        alertV.message = @"输入的金额不对";
        [alertV show];
        return;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    if ([isType isEqualToString:@"JM"]) {
        
        [   params setObject:_KHId forKey:@"customer_id"];
        
        NSDictionary *goods_list = @{@"1":@{@"goods_id":_dic[@"goods"][@"goods_id"],@"number":_numbel,@"price":_dic[@"price"]}};
        
        [params setObject:goods_list forKey:@"goods_list"];
        
        [params setObject:moneyTextField.text forKey:@"total_price"];
        if (_JSRDic[@"id"]) {
            [params setObject:_JSRDic[@"id"] forKey:@"add_user"];
        }

        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        for (int i = 0 ; i< _dataArr.count; i++) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            [dic setObject:_dataArr[i][@"account_id"] forKey:@"account_id"];
            [dic setObject:_dataArr[i][@"amount"] forKey:@"amount"];
            
            if ([_dataArr[i][@"type"] isEqualToString:@"5"]) {
                
                if (_dataArr[i][@"goodsDic"][@"id"]) {
                    [dic setObject:_dataArr[i][@"goodsDic"][@"id"] forKey:@"goods_id"];
                    [dic setObject:_dataArr[i][@"goodsDic"][@"SL"] forKey:@"number"];
                }else{
                    [dic setObject:_dataArr[i][@"goodsDic"] forKey:@"goods"];
                }
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        [params setObject:payment forKey:@"payment"];
        [params setObject:remarkTextView.text forKey:@"remark"];
        
        [DataSeviece requestUrl:add_saleshtml params:params success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"msg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ConsignmentNotification" object:nil];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }else{
                alertV.message = result[@"result"][@"msg"];
                [alertV show];
                
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }else if ([isType isEqualToString:@"HS"]){
        
        [params setObject:_KHId forKey:@"customer_id"];
        
        NSDictionary *goods_list = @{@"1":@{@"goods_id":_HSDic[@"id"],@"number":_numbel,@"price":moneyTextField.text}};
        
        [params setObject:goods_list forKey:@"goods_list"];
        
        [params setObject:moneyTextField.text forKey:@"total_price"];
        
        if (_JSRDic[@"id"]) {
            [params setObject:_JSRDic[@"id"] forKey:@"add_user"];
        }
        
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        for (int i = 0 ; i< _dataArr.count; i++) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            [dic setObject:_dataArr[i][@"account_id"] forKey:@"account_id"];
            [dic setObject:_dataArr[i][@"amount"] forKey:@"amount"];
            
            if ([_dataArr[i][@"type"] isEqualToString:@"5"]) {
                
                if (_dataArr[i][@"goodsDic"][@"id"]) {
                    [dic setObject:_dataArr[i][@"goodsDic"][@"id"] forKey:@"goods_id"];
                    [dic setObject:_dataArr[i][@"goodsDic"][@"SL"] forKey:@"number"];
                }else{
                    [dic setObject:_dataArr[i][@"goodsDic"] forKey:@"goods"];
                }
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        [params setObject:remarkTextView.text forKey:@"remark"];
        
        [params setObject:payment forKey:@"payment"];
        [DataSeviece requestUrl:add_saleshtml params:params success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"msg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SalesRecordsNotification" object:nil];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }else{
                alertV.message = result[@"result"][@"msg"];
                [alertV show];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }else if ([isType isEqualToString:@"HSRK"]){
        
        NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithDictionary:_HSRKDic];
        [params1 setObject:SYGData[@"id"] forKey:@"uid"];
        [params1 setObject:moneyTextField.text forKey:@"total_price"];
        
        [params1 setObject:@"2" forKey:@"is_pause"];
        
        if (_JSRDic[@"id"]) {
            [params1 setObject:_JSRDic[@"id"] forKey:@"add_user"];
        }

        
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        for (int i = 0 ; i< _dataArr.count; i++) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            [dic setObject:_dataArr[i][@"account_id"] forKey:@"account_id"];
            [dic setObject:_dataArr[i][@"amount"] forKey:@"amount"];
            
            if ([_dataArr[i][@"type"] isEqualToString:@"5"]) {
                
                if (_dataArr[i][@"goodsDic"][@"id"]) {
                    [dic setObject:_dataArr[i][@"goodsDic"][@"id"] forKey:@"goods_id"];
                    [dic setObject:_dataArr[i][@"goodsDic"][@"SL"] forKey:@"number"];
                }else{
                    [dic setObject:_dataArr[i][@"goodsDic"] forKey:@"goods"];
                }
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        

        [params1 setObject:payment forKey:@"payment"];
        [params1 setObject:remarkTextView.text forKey:@"pay_remark"];
        
        [DataSeviece requestUrl:add_goodshtml params:params1 success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"msg"]);
            
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"StockNotification" object:nil];
                
                [self.navigationController popToRootViewControllerAnimated:YES];

            }else{
                alertV.message = result[@"result"][@"msg"];
                [alertV show];
                
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
        
    }else if ([isType isEqualToString:@"Home1"]){
        
        
        [params setObject:@"2" forKey:@"is_pause"];
        [params setObject:moneyTextField.text forKey:@"total_price"];
        
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        for (int i = 0 ; i< _dataArr.count; i++) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            [dic setObject:_dataArr[i][@"account_id"] forKey:@"account_id"];
            [dic setObject:_dataArr[i][@"amount"] forKey:@"amount"];
            
            if ([_dataArr[i][@"type"] isEqualToString:@"5"]) {
                
                if (_dataArr[i][@"goodsDic"][@"id"]) {
                    [dic setObject:_dataArr[i][@"goodsDic"][@"id"] forKey:@"goods_id"];
                    [dic setObject:_dataArr[i][@"goodsDic"][@"SL"] forKey:@"number"];
                }else{
                    [dic setObject:_dataArr[i][@"goodsDic"] forKey:@"goods"];
                }
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        
        [params setObject:payment forKey:@"payment"];
        
        [params setObject:_HomeDic1[@"goods_list"][0][@"sales_id"] forKey:@"sales_id"];
        
        [params setObject:remarkTextView.text forKey:@"remark"];
        
        NSArray *photo_listArr = _HomeDic1[@"photo_list"];
        
        if (photo_listArr.count != 0) {
            NSString *imageStr = @"";
            
            for (NSDictionary *dic in photo_listArr) {
                
                imageStr = [NSString stringWithFormat:@"%@,%@",imageStr,dic[@"url"]];
            }
            
            imageStr = [imageStr substringFromIndex:1];
            
            NSLog(@"%@",imageStr);
            [params setObject:imageStr forKey:@"photo"];
        }else{
            
            [params setObject:@"" forKey:@"photo"];
        }
        
        NSMutableArray *_BQArr = [NSMutableArray array];
        
        NSMutableArray *_numberArr = [NSMutableArray array];
        
        NSMutableArray *_textArr = [NSMutableArray array];
        
        
        for (NSDictionary *dic in _HomeDic1[@"goods_list"][0][@"attribute"]) {
            
            if ([dic[@"type"] isEqualToString:@"select"]) {
                [_BQArr addObject:dic];
            }
            if ([dic[@"type"] isEqualToString:@"text"]) {
                [_textArr addObject:dic];
            }
            if ([dic[@"type"] isEqualToString:@"number"]) {
                [_numberArr addObject:dic];
            }
            
        }
        
        NSMutableDictionary *idDic = [NSMutableDictionary dictionary];
        
        for (NSDictionary *dic in _BQArr) {
            
            [idDic setObject:dic[@"attribute_name"] forKey:dic[@"id"]];
        }
        
        NSMutableDictionary *textDic = [NSMutableDictionary dictionary];
        
        for (int i = 0; i < _numberArr.count; i++) {
            
            
            [textDic setObject:_numberArr[i][@"attribute_value"] forKey:_numberArr[i][@"id"]];
            
        }
        
        for (int i = 0; i < _textArr.count; i++) {
            
            [textDic setObject:_textArr[i][@"attribute_value"] forKey:_textArr[i][@"id"]];
            
        }
        
        [params setObject:@{@"select":idDic,@"text":textDic} forKey:@"attribute"];
        

        
        [DataSeviece requestUrl:continutehtml params:params success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"errmsg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SalesRecordsNotification" object:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];

            }else{
                alertV.message = result[@"result"][@"msg"];
                [alertV show];
                
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
        
    }else if ([isType isEqualToString:@"Home3"]){
        
        
        [params setObject:@"2" forKey:@"is_pause"];
        [params setObject:moneyTextField.text forKey:@"customer_price"];
        if (_JSRDic[@"id"]) {
            [params setObject:_JSRDic[@"id"] forKey:@"add_user"];
        }

        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        for (int i = 0 ; i< _dataArr.count; i++) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            [dic setObject:_dataArr[i][@"account_id"] forKey:@"account_id"];
            [dic setObject:_dataArr[i][@"amount"] forKey:@"amount"];
            
            if ([_dataArr[i][@"type"] isEqualToString:@"5"]) {
                
                if (_dataArr[i][@"goodsDic"][@"id"]) {
                    [dic setObject:_dataArr[i][@"goodsDic"][@"id"] forKey:@"goods_id"];
                    [dic setObject:_dataArr[i][@"goodsDic"][@"SL"] forKey:@"number"];
                }else{
                    [dic setObject:_dataArr[i][@"goodsDic"] forKey:@"goods"];
                }
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        
        [params setObject:payment forKey:@"payment"];
        [params setObject:_HomeDic3[@"goods_list"][0][@"id"] forKey:@"sales_goods_id"];
        [params setObject:remarkTextView.text forKey:@"remark"];
        
        
        NSArray *photo_listArr = _HomeDic3[@"photo_list"];
        
        if (photo_listArr.count != 0) {
            NSString *imageStr = @"";
            
            for (NSDictionary *dic in photo_listArr) {
                
                imageStr = [NSString stringWithFormat:@"%@,%@",imageStr,dic[@"url"]];
            }
            
            imageStr = [imageStr substringFromIndex:1];
            
            NSLog(@"%@",imageStr);
            
            [params setObject:imageStr forKey:@"photo"];
            
        }else{
            
            [params setObject:@"" forKey:@"photo"];
            
        }
        
        NSMutableArray *_BQArr = [NSMutableArray array];
        
        NSMutableArray *_numberArr = [NSMutableArray array];
        
        NSMutableArray *_textArr = [NSMutableArray array];

        
        for (NSDictionary *dic in _HomeDic3[@"goods_list"][0][@"attribute"]) {
            
            if ([dic[@"type"] isEqualToString:@"select"]) {
                [_BQArr addObject:dic];
            }
            if ([dic[@"type"] isEqualToString:@"text"]) {
                [_textArr addObject:dic];
            }
            if ([dic[@"type"] isEqualToString:@"number"]) {
                [_numberArr addObject:dic];
            }
            
        }
        
        NSMutableDictionary *idDic = [NSMutableDictionary dictionary];
        
        for (NSDictionary *dic in _BQArr) {
            
            [idDic setObject:dic[@"attribute_name"] forKey:dic[@"id"]];
        }
        
        NSMutableDictionary *textDic = [NSMutableDictionary dictionary];
        
        for (int i = 0; i < _numberArr.count; i++) {
            
            
            [textDic setObject:_numberArr[i][@"attribute_value"] forKey:_numberArr[i][@"id"]];
            
        }

        for (int i = 0; i < _textArr.count; i++) {
            
            [textDic setObject:_textArr[i][@"attribute_value"] forKey:_textArr[i][@"id"]];
            
        }
        
        [params setObject:@{@"select":idDic,@"text":textDic} forKey:@"attribute"];

        
        
        [DataSeviece requestUrl:consighmenthtml params:params success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"errmsg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SalesRecordsNotification" object:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];

            }else{
                alertV.message = result[@"result"][@"msg"];
                [alertV show];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
        
    }else if ([isType isEqualToString:@"Home2"]){
        
        NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithDictionary:_HomeDic2];
        [params1 setObject:moneyTextField.text forKey:@"total_price"];
        
        [params1 setObject:@"2" forKey:@"is_pause"];
        
        [params1 setObject:SYGData[@"id"] forKey:@"uid"];
        
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        for (int i = 0 ; i< _dataArr.count; i++) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            [dic setObject:_dataArr[i][@"account_id"] forKey:@"account_id"];
            [dic setObject:_dataArr[i][@"amount"] forKey:@"amount"];
            
            if ([_dataArr[i][@"type"] isEqualToString:@"5"]) {
                
                if (_dataArr[i][@"goodsDic"][@"id"]) {
                    [dic setObject:_dataArr[i][@"goodsDic"][@"id"] forKey:@"goods_id"];
                    [dic setObject:_dataArr[i][@"goodsDic"][@"SL"] forKey:@"number"];
                }else{
                    [dic setObject:_dataArr[i][@"goodsDic"] forKey:@"goods"];
                }
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        [params1 setObject:payment forKey:@"payment"];
        [params1 setObject:remarkTextView.text forKey:@"remark"];
        [params1 setObject:_HomeDic2[@"id"] forKey:@"id"];
        
        NSArray *photo_listArr = _HomeDic2[@"photo_list"];
        NSLog(@"%@",_HomeDic2);
        if (photo_listArr.count != 0) {
            NSString *imageStr = @"";
            
            for (NSDictionary *dic in photo_listArr) {
                
                imageStr = [NSString stringWithFormat:@"%@,%@",imageStr,dic[@"url"]];
            }
            
            imageStr = [imageStr substringFromIndex:1];
            
            NSLog(@"%@",imageStr);
            [params1 setObject:imageStr forKey:@"photo"];
        }else{
            
            [params1 setObject:@"" forKey:@"photo"];
        }

        
        NSMutableArray *_BQArr = [NSMutableArray array];
        
        NSMutableArray *_numberArr = [NSMutableArray array];
        
        NSMutableArray *_textArr = [NSMutableArray array];
        
        
        for (NSDictionary *dic in _HomeDic2[@"attribute"]) {
            
            if ([dic[@"type"] isEqualToString:@"select"]) {
                [_BQArr addObject:dic];
            }
            if ([dic[@"type"] isEqualToString:@"text"]) {
                [_textArr addObject:dic];
            }
            if ([dic[@"type"] isEqualToString:@"number"]) {
                [_numberArr addObject:dic];
            }
            
        }
        
        NSMutableDictionary *idDic = [NSMutableDictionary dictionary];
        
        for (NSDictionary *dic in _BQArr) {
            
            [idDic setObject:dic[@"attribute_name"] forKey:dic[@"id"]];
        }
        
        NSMutableDictionary *textDic = [NSMutableDictionary dictionary];
        
        for (int i = 0; i < _numberArr.count; i++) {
            
            
            [textDic setObject:_numberArr[i][@"attribute_value"] forKey:_numberArr[i][@"id"]];
            
        }
        
        for (int i = 0; i < _textArr.count; i++) {
            
            [textDic setObject:_textArr[i][@"attribute_value"] forKey:_textArr[i][@"id"]];
            
        }
        
        [params1 setObject:@{@"select":idDic,@"text":textDic} forKey:@"attribute"];
        
        
        [DataSeviece requestUrl:edit_goodshtm params:params1 success:^(id result) {
            
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"msg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"BooksNotification" object:nil];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }else{
                alertV.message = result[@"result"][@"msg"];
                [alertV show];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }else if ([isType isEqualToString:@"JMJS"]){
        
        NSLog(@"%@",_JMJSDic);
        
        NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
        [params1 setObject:moneyTextField.text forKey:@"customer_price"];
        
        [params1 setObject:SYGData[@"id"] forKey:@"uid"];
        
        [params1 setObject:@"2" forKey:@"is_pause"];
        [params1 setObject:_JMJSDic[@"sales_goods_id"] forKey:@"sales_goods_id"];
        
        if (_JSRDic[@"id"]) {
            [params1 setObject:_JSRDic[@"id"] forKey:@"add_user"];
        }
        
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        for (int i = 0 ; i< _dataArr.count; i++) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            [dic setObject:_dataArr[i][@"account_id"] forKey:@"account_id"];
            [dic setObject:_dataArr[i][@"amount"] forKey:@"amount"];
            
            if ([_dataArr[i][@"type"] isEqualToString:@"5"]) {
                
                if (_dataArr[i][@"goodsDic"][@"id"]) {
                    [dic setObject:_dataArr[i][@"goodsDic"][@"id"] forKey:@"goods_id"];
                    [dic setObject:_dataArr[i][@"goodsDic"][@"SL"] forKey:@"number"];
                }else{
                    [dic setObject:_dataArr[i][@"goodsDic"] forKey:@"goods"];
                }
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        [params1 setObject:payment forKey:@"payment"];
        [params1 setObject:remarkTextView.text forKey:@"remark"];
        
        [DataSeviece requestUrl:consighmenthtml params:params1 success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"msg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SalesRecordsNotification" object:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }else{
                alertV.message = result[@"result"][@"errmsg"];
                [alertV show];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }else if ([_isSF isEqualToString:@"SK"]){
    
        [params setObject:@"5" forKey:@"type"];
        
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        for (int i = 0 ; i< _dataArr.count; i++) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            [dic setObject:_dataArr[i][@"account_id"] forKey:@"account_id"];
            [dic setObject:_dataArr[i][@"amount"] forKey:@"amount"];
            
            if ([_dataArr[i][@"type"] isEqualToString:@"5"]) {
                
                if (_dataArr[i][@"goodsDic"][@"id"]) {
                    [dic setObject:_dataArr[i][@"goodsDic"][@"id"] forKey:@"goods_id"];
                    [dic setObject:_dataArr[i][@"goodsDic"][@"SL"] forKey:@"number"];
                }else{
                    [dic setObject:_dataArr[i][@"goodsDic"] forKey:@"goods"];
                }
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        [params setObject:payment forKey:@"item"];
        
        
        [params setObject:moneyTextField.text forKey:@"money"];
        
        [params setObject:remarkTextView.text forKey:@"remark"];

        if (![imageUrl isEqualToString:@""]) {
            
            [params setObject:@{@"1":imageUrl} forKey:@"imgurl"];
        }

        
        [DataSeviece requestUrl:add_pay_loghtml params:params success:^(id result) {
            
            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"BooksNotification" object:nil];

                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }else{
                
                alertV.message = result[@"result"][@"msg"];
                [alertV show];
                
            }
            
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
            
        }];

        
        
    }else if ([_isSF isEqualToString:@"FK"]){
    
        [params setObject:@"4" forKey:@"type"];
        
        
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        for (int i = 0 ; i< _dataArr.count; i++) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            [dic setObject:_dataArr[i][@"account_id"] forKey:@"account_id"];
            [dic setObject:_dataArr[i][@"amount"] forKey:@"amount"];
            
            if ([_dataArr[i][@"type"] isEqualToString:@"5"]) {
                
                if (_dataArr[i][@"goodsDic"][@"id"]) {
                    [dic setObject:_dataArr[i][@"goodsDic"][@"id"] forKey:@"goods_id"];
                    [dic setObject:_dataArr[i][@"goodsDic"][@"SL"] forKey:@"number"];
                }else{
                    [dic setObject:_dataArr[i][@"goodsDic"] forKey:@"goods"];
                }
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        [params setObject:payment forKey:@"item"];
        
        [params setObject:moneyTextField.text forKey:@"money"];
        
        [params setObject:remarkTextView.text forKey:@"remark"];
        
        if (![imageUrl isEqualToString:@""]) {
            
            [params setObject:@{@"1":imageUrl} forKey:@"imgurl"];
        }
        
        [DataSeviece requestUrl:add_pay_loghtml params:params success:^(id result) {
            
            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"BooksNotification" object:nil];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }else{
                
                alertV.message = result[@"result"][@"msg"];
                [alertV show];
                
            }
            
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
            
        }];

        
    }
    
    if (![_dataArr[0][@"type"] isEqualToString:@"5"]) {
        
        [defaults setObject:_dataArr[0] forKey:[NSString stringWithFormat:@"%@-",SYGData[@"id"]]];
        
        [defaults synchronize];
    }

}

//先记一笔
- (void)xjybAction{

    for (int i = 0; i < _dataArr.count; i++) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[i]];
        
        UITextField *textfield = [paymentTableView viewWithTag:1000+i];
        if (textfield) {
            [dic setObject:textfield.text forKey:@"amount"];
            
        }
        [_dataArr replaceObjectAtIndex:i withObject:dic];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    if ([isType isEqualToString:@"JM"]) {
        
        [params setObject:moneyTextField.text forKey:@"total_price"];
        
        [params setObject:SYGData[@"id"] forKey:@"uid"];
        [params setObject:_KHId forKey:@"customer_id"];
        
        if (_JSRDic[@"id"]) {
            [params setObject:_JSRDic[@"id"] forKey:@"add_user"];
        }

        NSDictionary *goods_list = @{@"1":@{@"goods_id":_dic[@"goods"][@"goods_id"],@"number":_numbel,@"price":_dic[@"price"]}};
        
        [params setObject:goods_list forKey:@"goods_list"];
        
        [params setObject:@"1" forKey:@"is_pause"];
        
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        for (int i = 0 ; i< _dataArr.count; i++) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            [dic setObject:_dataArr[i][@"account_id"] forKey:@"account_id"];
            [dic setObject:_dataArr[i][@"amount"] forKey:@"amount"];
            
            if ([_dataArr[i][@"type"] isEqualToString:@"5"]) {
                
                if (_dataArr[i][@"goodsDic"][@"id"]) {
                    [dic setObject:_dataArr[i][@"goodsDic"][@"id"] forKey:@"goods_id"];
                    [dic setObject:_dataArr[i][@"goodsDic"][@"SL"] forKey:@"number"];
                }else{
                    [dic setObject:_dataArr[i][@"goodsDic"] forKey:@"goods"];
                }
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        
        [params setObject:payment forKey:@"payment"];
        [params setObject:remarkTextView.text forKey:@"remark"];
        
        [DataSeviece requestUrl:add_saleshtml params:params success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"msg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeNotification" object:nil];
                
                [self.navigationController popToRootViewControllerAnimated:YES];

            }else{
            
                alertV.message = result[@"result"][@"msg"];
                [alertV show];

            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
            
            
        }];
        
        
        
    }else if ([isType isEqualToString:@"HS"]){
        
        [params setObject:moneyTextField.text forKey:@"total_price"];
        
        [params setObject:_KHId forKey:@"customer_id"];
        
        if (_JSRDic[@"id"]) {
            [params setObject:_JSRDic[@"id"] forKey:@"add_user"];
        }

        NSDictionary *goods_list = @{@"1":@{@"goods_id":_HSDic[@"id"],@"number":_numbel,@"price":moneyTextField.text}};
        
        [params setObject:goods_list forKey:@"goods_list"];
        
        [params setObject:@"1" forKey:@"is_pause"];
        
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        for (int i = 0 ; i< _dataArr.count; i++) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            [dic setObject:_dataArr[i][@"account_id"] forKey:@"account_id"];
            [dic setObject:_dataArr[i][@"amount"] forKey:@"amount"];
            
            if ([_dataArr[i][@"type"] isEqualToString:@"5"]) {
                
                if (_dataArr[i][@"goodsDic"][@"id"]) {
                    [dic setObject:_dataArr[i][@"goodsDic"][@"id"] forKey:@"goods_id"];
                    [dic setObject:_dataArr[i][@"goodsDic"][@"SL"] forKey:@"number"];
                }else{
                    [dic setObject:_dataArr[i][@"goodsDic"] forKey:@"goods"];
                }
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        
        [params setObject:payment forKey:@"payment"];
        
        [params setObject:remarkTextView.text forKey:@"remark"];
        
        
        [DataSeviece requestUrl:add_saleshtml params:params success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"msg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                  [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeNotification" object:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
                
              
            }else{
                alertV.message = result[@"result"][@"msg"];
                [alertV show];

            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }else if ([isType isEqualToString:@"HSRK"]){
        
        
        NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithDictionary:_HSRKDic];
        [params1 setObject:moneyTextField.text forKey:@"total_price"];
        
        [params1 setObject:@"1" forKey:@"is_pause"];
        
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        for (int i = 0 ; i< _dataArr.count; i++) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            [dic setObject:_dataArr[i][@"account_id"] forKey:@"account_id"];
            [dic setObject:_dataArr[i][@"amount"] forKey:@"amount"];
            
            if ([_dataArr[i][@"type"] isEqualToString:@"5"]) {
                
                if (_dataArr[i][@"goodsDic"][@"id"]) {
                    [dic setObject:_dataArr[i][@"goodsDic"][@"id"] forKey:@"goods_id"];
                    [dic setObject:_dataArr[i][@"goodsDic"][@"SL"] forKey:@"number"];
                }else{
                    [dic setObject:_dataArr[i][@"goodsDic"] forKey:@"goods"];
                }
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        if (_JSRDic[@"id"]) {
            [params1 setObject:_JSRDic[@"id"] forKey:@"add_user"];
        }
        [params1 setObject:payment forKey:@"payment"];
        [params1 setObject:remarkTextView.text forKey:@"pay_remark"];
        
        [DataSeviece requestUrl:add_goodshtml params:params1 success:^(id result) {
            NSLog(@"%@",result);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeNotification" object:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
                

                
            }else{
                alertV.message = result[@"result"][@"msg"];
                [alertV show];

            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }else if ([isType isEqualToString:@"Home1"]){
        
        
        [params setObject:@"1" forKey:@"is_pause"];
        [params setObject:moneyTextField.text forKey:@"total_price"];
        
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        for (int i = 0 ; i< _dataArr.count; i++) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            [dic setObject:_dataArr[i][@"account_id"] forKey:@"account_id"];
            [dic setObject:_dataArr[i][@"amount"] forKey:@"amount"];
            
            if ([_dataArr[i][@"type"] isEqualToString:@"5"]) {
                
                if (_dataArr[i][@"goodsDic"][@"id"]) {
                    [dic setObject:_dataArr[i][@"goodsDic"][@"id"] forKey:@"goods_id"];
                    [dic setObject:_dataArr[i][@"goodsDic"][@"SL"] forKey:@"number"];
                }else{
                    [dic setObject:_dataArr[i][@"goodsDic"] forKey:@"goods"];
                }
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        
        [params setObject:payment forKey:@"payment"];
        
        [params setObject:_HomeDic1[@"goods_list"][0][@"sales_id"] forKey:@"sales_id"];
        [params setObject:remarkTextView.text forKey:@"remark"];
        
        NSMutableArray *_BQArr = [NSMutableArray array];
        
        NSMutableArray *_numberArr = [NSMutableArray array];
        
        NSMutableArray *_textArr = [NSMutableArray array];
        
        
        for (NSDictionary *dic in _HomeDic1[@"goods_list"][0][@"attribute"]) {
            
            if ([dic[@"type"] isEqualToString:@"select"]) {
                [_BQArr addObject:dic];
            }
            if ([dic[@"type"] isEqualToString:@"text"]) {
                [_textArr addObject:dic];
            }
            if ([dic[@"type"] isEqualToString:@"number"]) {
                [_numberArr addObject:dic];
            }
            
        }
        
        NSMutableDictionary *idDic = [NSMutableDictionary dictionary];
        
        for (NSDictionary *dic in _BQArr) {
            
            [idDic setObject:dic[@"attribute_name"] forKey:dic[@"id"]];
        }
        
        NSMutableDictionary *textDic = [NSMutableDictionary dictionary];
        
        for (int i = 0; i < _numberArr.count; i++) {
            
            
            [textDic setObject:_numberArr[i][@"attribute_value"] forKey:_numberArr[i][@"id"]];
            
        }
        
        for (int i = 0; i < _textArr.count; i++) {
            
            [textDic setObject:_textArr[i][@"attribute_value"] forKey:_textArr[i][@"id"]];
            
        }
        
        [params setObject:@{@"select":idDic,@"text":textDic} forKey:@"attribute"];
        

        
        
        NSArray *photo_listArr = _HomeDic1[@"photo_list"];
        
        if (photo_listArr.count != 0) {
            NSString *imageStr = @"";
            
            for (NSDictionary *dic in photo_listArr) {
                
                imageStr = [NSString stringWithFormat:@"%@,%@",imageStr,dic[@"url"]];
            }
            
            imageStr = [imageStr substringFromIndex:1];
            
            NSLog(@"%@",imageStr);
            [params setObject:imageStr forKey:@"photo"];
        }else{
            
            [params setObject:@"" forKey:@"photo"];
        }

        [DataSeviece requestUrl:continutehtml params:params success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"errmsg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeNotification" object:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }else{
                alertV.message = result[@"result"][@"msg"];
                [alertV show];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }else if ([isType isEqualToString:@"Home3"]){
        
        [params setObject:@"1" forKey:@"is_pause"];
        [params setObject:moneyTextField.text forKey:@"customer_price"];
        if (_JSRDic[@"id"]) {
            [params setObject:_JSRDic[@"id"] forKey:@"add_user"];
        }

        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        for (int i = 0 ; i< _dataArr.count; i++) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            [dic setObject:_dataArr[i][@"account_id"] forKey:@"account_id"];
            [dic setObject:_dataArr[i][@"amount"] forKey:@"amount"];
            
            if ([_dataArr[i][@"type"] isEqualToString:@"5"]) {
                
                if (_dataArr[i][@"goodsDic"][@"id"]) {
                    [dic setObject:_dataArr[i][@"goodsDic"][@"id"] forKey:@"goods_id"];
                    [dic setObject:_dataArr[i][@"goodsDic"][@"SL"] forKey:@"number"];
                }else{
                    [dic setObject:_dataArr[i][@"goodsDic"] forKey:@"goods"];
                }
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        [params setObject:payment forKey:@"payment"];
        [params setObject:_HomeDic3[@"goods_list"][0][@"id"] forKey:@"sales_goods_id"];
        [params setObject:remarkTextView.text forKey:@"remark"];
        
        NSArray *photo_listArr = _HomeDic3[@"photo_list"];
        
        if (photo_listArr.count != 0) {
            NSString *imageStr = @"";
            
            for (NSDictionary *dic in photo_listArr) {
                
                imageStr = [NSString stringWithFormat:@"%@,%@",imageStr,dic[@"url"]];
            }
            
            imageStr = [imageStr substringFromIndex:1];
            
            NSLog(@"%@",imageStr);
            [params setObject:imageStr forKey:@"photo"];
        }else{
            
            [params setObject:@"" forKey:@"photo"];
        }

        NSMutableArray *_BQArr = [NSMutableArray array];
        
        NSMutableArray *_numberArr = [NSMutableArray array];
        
        NSMutableArray *_textArr = [NSMutableArray array];
        
        
        for (NSDictionary *dic in _HomeDic3[@"goods_list"][0][@"attribute"]) {
            
            if ([dic[@"type"] isEqualToString:@"select"]) {
                [_BQArr addObject:dic];
            }
            if ([dic[@"type"] isEqualToString:@"text"]) {
                [_textArr addObject:dic];
            }
            if ([dic[@"type"] isEqualToString:@"number"]) {
                [_numberArr addObject:dic];
            }
            
        }
        
        NSMutableDictionary *idDic = [NSMutableDictionary dictionary];
        
        for (NSDictionary *dic in _BQArr) {
            
            [idDic setObject:dic[@"attribute_name"] forKey:dic[@"id"]];
        }
        
        NSMutableDictionary *textDic = [NSMutableDictionary dictionary];
        
        for (int i = 0; i < _numberArr.count; i++) {
            
            
            [textDic setObject:_numberArr[i][@"attribute_value"] forKey:_numberArr[i][@"id"]];
            
        }
        
        for (int i = 0; i < _textArr.count; i++) {
            
            [textDic setObject:_textArr[i][@"attribute_value"] forKey:_textArr[i][@"id"]];
            
        }
        
        [params setObject:@{@"select":idDic,@"text":textDic} forKey:@"attribute"];
        

        
        [DataSeviece requestUrl:consighmenthtml params:params success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"errmsg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeNotification" object:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }else{
                alertV.message = result[@"result"][@"msg"];
                [alertV show];
                
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }else if ([isType isEqualToString:@"Home2"]){
        
        
        NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithDictionary:_HomeDic2];
        [params1 setObject:moneyTextField.text forKey:@"total_price"];
        
        [params1 setObject:@"1" forKey:@"is_pause"];
        
        [params1 setObject:SYGData[@"id"] forKey:@"uid"];
        [params1 setObject:_HomeDic2[@"id"] forKey:@"id"];
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        for (int i = 0 ; i< _dataArr.count; i++) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            [dic setObject:_dataArr[i][@"account_id"] forKey:@"account_id"];
            [dic setObject:_dataArr[i][@"amount"] forKey:@"amount"];

            if ([_dataArr[i][@"type"] isEqualToString:@"5"]) {
                
                if (_dataArr[i][@"goodsDic"][@"id"]) {
                    [dic setObject:_dataArr[i][@"goodsDic"][@"id"] forKey:@"goods_id"];
                    [dic setObject:_dataArr[i][@"goodsDic"][@"SL"] forKey:@"number"];
                }else{
                    [dic setObject:_dataArr[i][@"goodsDic"] forKey:@"goods"];
                }
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        
        
        [params1 setObject:payment forKey:@"payment"];
        [params1 setObject:@"1" forKey:@"is_pause"];
        [params1 setObject:remarkTextView.text forKey:@"remark"];
        
        
        NSArray *photo_listArr = _HomeDic2[@"photo_list"];
        
        if (photo_listArr.count != 0) {
            NSString *imageStr = @"";
            
            for (NSDictionary *dic in photo_listArr) {
                
                imageStr = [NSString stringWithFormat:@"%@,%@",imageStr,dic[@"url"]];
            }

            imageStr = [imageStr substringFromIndex:1];
            
            NSLog(@"%@",imageStr);
            [params1 setObject:imageStr forKey:@"photo"];
        }else{
            
            [params1 setObject:@"" forKey:@"photo"];
        }

        
        NSMutableArray *_BQArr = [NSMutableArray array];
        
        NSMutableArray *_numberArr = [NSMutableArray array];
        
        NSMutableArray *_textArr = [NSMutableArray array];
        
        
        for (NSDictionary *dic in _HomeDic2[@"attribute"]) {
            
            if ([dic[@"type"] isEqualToString:@"select"]) {
                [_BQArr addObject:dic];
            }
            if ([dic[@"type"] isEqualToString:@"text"]) {
                [_textArr addObject:dic];
            }
            if ([dic[@"type"] isEqualToString:@"number"]) {
                [_numberArr addObject:dic];
            }
            
        }
        
        NSMutableDictionary *idDic = [NSMutableDictionary dictionary];
        
        for (NSDictionary *dic in _BQArr) {
            
            [idDic setObject:dic[@"attribute_name"] forKey:dic[@"id"]];
        }
        
        NSMutableDictionary *textDic = [NSMutableDictionary dictionary];
        
        for (int i = 0; i < _numberArr.count; i++) {
            
            
            [textDic setObject:_numberArr[i][@"attribute_value"] forKey:_numberArr[i][@"id"]];
            
        }
        
        for (int i = 0; i < _textArr.count; i++) {
            
            [textDic setObject:_textArr[i][@"attribute_value"] forKey:_textArr[i][@"id"]];
            
        }
        
        [params1 setObject:@{@"select":idDic,@"text":textDic} forKey:@"attribute"];
        

        
        
        [DataSeviece requestUrl:edit_goodshtm params:params1 success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"msg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeNotification" object:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }else{
                alertV.message = result[@"result"][@"msg"];
                [alertV show];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }else if ([isType isEqualToString:@"JMJS"]){
        
        NSLog(@"%@",_JMJSDic);
        
        NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
        [params1 setObject:moneyTextField.text forKey:@"customer_price"];
        
        [params1 setObject:SYGData[@"id"] forKey:@"uid"];
        
        [params1 setObject:@"1" forKey:@"is_pause"];
        [params1 setObject:_JMJSDic[@"sales_goods_id"] forKey:@"sales_goods_id"];
        [params1 setObject:moneyTextField.text forKey:@"total_price"];
        if (_JSRDic[@"id"]) {
            [params1 setObject:_JSRDic[@"id"] forKey:@"add_user"];
        }

        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        
        for (int i = 0 ; i< _dataArr.count; i++) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            [dic setObject:_dataArr[i][@"account_id"] forKey:@"account_id"];
            [dic setObject:_dataArr[i][@"amount"] forKey:@"amount"];
            
            if ([_dataArr[i][@"type"] isEqualToString:@"5"]) {
                
                if (_dataArr[i][@"goodsDic"][@"id"]) {
                    [dic setObject:_dataArr[i][@"goodsDic"][@"id"] forKey:@"goods_id"];
                    [dic setObject:_dataArr[i][@"goodsDic"][@"SL"] forKey:@"number"];
                }else{
                    [dic setObject:_dataArr[i][@"goodsDic"] forKey:@"goods"];
                }
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        [params1 setObject:payment forKey:@"payment"];
        [params1 setObject:moneyTextField forKey:@"remark"];
        
        
        [DataSeviece requestUrl:consighmenthtml params:params1 success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"msg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeNotification" object:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }else{
                alertV.message = result[@"result"][@"errmsg"];
                [alertV show];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    
    if (_dataArr.count != 0) {
        if (![_dataArr[0][@"type"] isEqualToString:@"5"]) {
            
            [defaults setObject:_dataArr[0] forKey:[NSString stringWithFormat:@"%@-",SYGData[@"id"]]];
            
            [defaults synchronize];
        }
   
    }
    
}

//货物抵款通知
- (void)ShowAction:(NSNotification*)noti{
    
    bgView.hidden = YES;
    zffsView.hidden = YES;
    _notiDic = [noti object];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[index]];

    [dic setObject:@"5" forKey:@"type"];
    
    [dic setObject:@"2" forKey:@"account_id"];
    
    [dic setObject:_notiDic[@"DJ"] forKey:@"amount"];
    
    [dic setObject:_notiDic forKey:@"goodsDic"];
    
    [dic setObject:_notiDic[@"goods_name"] forKey:@"account"];
    
    [_dataArr replaceObjectAtIndex:index withObject:dic];
    
    [paymentTableView reloadData];
    
    
    
    oldMoneyLabel.text = [NSString stringWithFormat:@"还需支付:%ld",[moneyTextField.text integerValue] - [_notiDic[@"DJ"] integerValue] ];
    


}

//添加按钮
- (void)addAction{

    NSInteger money = 0;
    
    for (int i = 0; i < _dataArr.count; i++) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[i]];
        
        UITextField *textfield = [paymentTableView viewWithTag:1000+i];
        if (textfield) {
            [dic setObject:textfield.text forKey:@"amount"];
            money = money + [textfield.text integerValue];
        }
        [_dataArr replaceObjectAtIndex:i withObject:dic];
    }
    
//    oldMoneyLabel.text = [NSString stringWithFormat:@"还需支付:%ld",[moneyTextField.text integerValue] - money];
    oldMoneyLabel.text = @"还需支付:0";
    
    NSDictionary *dic = @{@"account_id":@"1",@"amount":[NSString stringWithFormat:@"%ld",[moneyTextField.text integerValue] - money],@"type":@"0",@"account":@"现金支付"};
    
    [_dataArr addObject:dic];

    NSLog(@"%@",_dataArr);
    
    [paymentTableView reloadData];
    
}
//删除按钮
- (void)delegePayment:(NSNotification*)noti{
    
    
//    NSInteger money = 0;
    
    for (int i = 0; i < _dataArr.count; i++) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[i]];
        
        UITextField *textfield = [paymentTableView viewWithTag:1000+i];
        if (textfield) {
            [dic setObject:textfield.text forKey:@"amount"];
//            money = money + [textfield.text integerValue];
        }
        [_dataArr replaceObjectAtIndex:i withObject:dic];
        
    }
    

    
    [_dataArr removeObjectAtIndex:[[noti object] integerValue]];

    NSLog(@"%@",_dataArr);
    
    NSInteger money = 0;
    
    for (int i = 0; i < _dataArr.count; i++) {
        
        money = money + [_dataArr[i][@"amount"] integerValue];

    }
    oldMoneyLabel.text = [NSString stringWithFormat:@"还需支付:%ld",[moneyTextField.text integerValue] - money];

    [paymentTableView reloadData];
    
}

//支付方式
- (void)zffsPayment:(NSNotification*)noti{

    index = [[noti object] integerValue];
    
    bgView.hidden = NO;
    
    zffsView = [[UIView alloc]initWithFrame:CGRectMake(10, 43, kScreenWidth -20, kScreenHeight - 143)];
    
    zffsView.backgroundColor = [UIColor whiteColor];
    zffsView.layer.cornerRadius = 5;
    zffsView.layer.borderColor = [RGBColor colorWithHexString:@"#ffffff"].CGColor;
    zffsView.layer.borderWidth = 1;
    zffsView.layer.masksToBounds = YES;
    
    [[UIApplication sharedApplication].keyWindow addSubview:zffsView];

    UILabel *zffsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth -20, 53)];
    
    zffsLabel.text = @"支付方式";
    zffsLabel.textAlignment = NSTextAlignmentCenter;
    zffsLabel.textColor = [RGBColor colorWithHexString:@"#787fc6"];
    
    zffsLabel.font = [UIFont systemFontOfSize:18];
    
    [zffsView addSubview:zffsLabel];
    
    
    if (!_isSF) {
    
    UIButton *KWDKButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    KWDKButton.frame = CGRectMake(30, zffsView.height - 60, kScreenWidth/4, 40);
    
    [KWDKButton setTitle:@"货物抵款" forState:UIControlStateNormal];
    [KWDKButton setTitleColor:[RGBColor colorWithHexString:@"#787fc6"] forState:UIControlStateNormal];
    [KWDKButton addTarget:self action:@selector(KWDKAction) forControlEvents:UIControlEventTouchUpInside];
    KWDKButton.layer.borderWidth = 1;
    KWDKButton.layer.borderColor = [RGBColor colorWithHexString:@"#787fc6"].CGColor;
    KWDKButton.layer.cornerRadius = 5;
    KWDKButton.layer.masksToBounds = YES;
    
    [zffsView addSubview:KWDKButton];
    
    UIButton *QDButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    QDButton.frame = CGRectMake(kScreenWidth/2 + 30, zffsView.height - 60, kScreenWidth/4, 40);
    
    [QDButton setTitle:@"确定" forState:UIControlStateNormal];
    
    [QDButton addTarget:self action:@selector(QDAction) forControlEvents:UIControlEventTouchUpInside];
    QDButton.backgroundColor = [RGBColor colorWithHexString:@"#787fc6"];
    QDButton.layer.cornerRadius = 5;
    QDButton.layer.masksToBounds = YES;
    [zffsView addSubview:QDButton];
    }
    
    zffsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 53, kScreenWidth -20, zffsView.height - 60 - 63) style:UITableViewStylePlain];

    zffsTableView.delegate = self;
    zffsTableView.dataSource = self;
    
    [zffsView addSubview:zffsTableView];
    
    [_zffsDataArr removeAllObjects];
    
    [self zffsLoadData];
    
}
//支付方式数据
- (void)zffsLoadData{

    //网络加载
    
    _zffsDataArr = [NSMutableArray array];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    
    [DataSeviece requestUrl:get_accounthtm_API params:[@{@"uid":SYGData[@"id"]} mutableCopy] success:^(id result) {
        
        NSLog(@"%@",result);
        
  
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            
            [_zffsDataArr addObject:dic];
            
        }
        
        [zffsTableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

- (void)KWDKAction{
    
    bgView.hidden = YES;
    
    zffsView.hidden = YES;
    
    if ([isType isEqualToString:@"JM"]) {
        
        
        StorageViewController *storageVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"StorageViewController"];
        storageVC.isJM = YES;
        storageVC.isType = @"1";
        storageVC.KHDic = _KHDic;
        storageVC.goods_id = _dic[@"goods"][@"goods_id"];
        [self.navigationController pushViewController:storageVC animated:YES];
        
        
    }else if ([isType isEqualToString:@"HS"]){
        
        StorageViewController *storageVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"StorageViewController"];
        storageVC.isJM = YES;
        storageVC.isType = @"1";
        storageVC.KHDic = _KHDic;
        storageVC.goods_id = _HSDic[@"id"];
        [self.navigationController pushViewController:storageVC animated:YES];

    }else if ([isType isEqualToString:@"HSRK"]){
        
        StockPriceViewController *stockPriceVC = [[StockPriceViewController alloc]init];
        stockPriceVC.type = @"1";
        stockPriceVC.goods_id = _HSRKDic[@"id"];
        [self.navigationController pushViewController:stockPriceVC animated:YES];
        

        
    }else if ([isType isEqualToString:@"Home1"]){
        StorageViewController *storageVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"StorageViewController"];
        storageVC.isType = @"1";
        NSDictionary *dic = @{@"phone":@"",@"name":_HomeDic1[@"customer_name"],@"id":_HomeDic1[@"customer_id"]};
        storageVC.KHDic = dic;
        storageVC.isJM = YES;
        storageVC.goods_id = _HomeDic1[@"goods_list"][0][@"id"];
        
        [self.navigationController pushViewController:storageVC animated:YES];

        
    }else if ([isType isEqualToString:@"Home3"]){
        
        StockPriceViewController *stockPrice = [[StockPriceViewController alloc]init];
        stockPrice.type = @"1";
        stockPrice.goods_id = _HomeDic3[@"goods_list"][0][@"id"];
        [self.navigationController pushViewController:stockPrice animated:YES];
        
    }else if ([isType isEqualToString:@"Home2"]){
        
        StockPriceViewController *stockPrice = [[StockPriceViewController alloc]init];
        
        stockPrice.type = @"1";
        stockPrice.goods_id =  _HomeDic2[@"id"];
        [self.navigationController pushViewController:stockPrice animated:YES];

    }else if ([isType isEqualToString:@"JMJS"]){
        
        StockPriceViewController *stockPrice = [[StockPriceViewController alloc]init];
        stockPrice.type = @"1";
        stockPrice.goods_id = _JMJSDic[@"goods"][@"goods_id"];
        [self.navigationController pushViewController:stockPrice animated:YES];
        
    }
}

- (void)QDAction{
    
    bgView.hidden = YES;
    zffsView.hidden = YES;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == paymentTableView) {
        return _dataArr.count;
    }else if (tableView == zffsTableView){
        return 1;
    }
    return 0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (tableView == paymentTableView) {
        return 1;

    }else if (tableView == zffsTableView){
        return _zffsDataArr.count;
    }
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == paymentTableView) {

    PaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PaymentCell" forIndexPath:indexPath];
    
    cell.index = indexPath.section;
    
    cell.dic = _dataArr[indexPath.section];
    
    return cell;
        
    }else if (tableView == zffsTableView){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayMViewCell"];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PayMViewCell"];
            
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 12, 24, 24)];
            imageV.tag = 100;
            [cell.contentView addSubview:imageV];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-20, 49)];
            label.tag = 101;
            label.font = [UIFont systemFontOfSize:15];
            label.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:label];
            
        }
        
        UIImageView *imageV = [cell.contentView viewWithTag:100];
        UILabel *label = [cell.contentView viewWithTag:101];
        
        label.text = [NSString stringWithFormat:@"%@%@",_zffsDataArr[indexPath.row][@"use_name"],_zffsDataArr[indexPath.row][@"account"]];

        if ([_zffsDataArr[indexPath.row][@"type"] isEqualToString:@"0"]) {
            imageV.image = [UIImage imageNamed:@"cashxiao@2x"];
        }else if ([_zffsDataArr[indexPath.row][@"type"] isEqualToString:@"1"]){
            imageV.image = [UIImage imageNamed:@"zhifubaoxiao@2x"];
        }else if ([_zffsDataArr[indexPath.row][@"type"] isEqualToString:@"2"]){
            imageV.image = [UIImage imageNamed:@"wechatxiao@2x"];
        }else if ([_zffsDataArr[indexPath.row][@"type"] isEqualToString:@"3"]){
            imageV.image = [UIImage imageNamed:@"cardxiao@2x"];
        }else if ([_zffsDataArr[indexPath.row][@"type"] isEqualToString:@"4"]){
            imageV.image = [UIImage imageNamed:@"posxiao@2x"];
        }
        
        return cell;
 
        
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == paymentTableView) {
        return 90;
        
    }else if (tableView == zffsTableView){
        return 49;
    }

    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView == paymentTableView) {
        return 10;
    }
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == zffsTableView) {
     
        for (int i = 0; i < _dataArr.count; i++) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[i]];
            
            if (i == index) {
                
                [dic setObject:[NSString  stringWithFormat:@"%@%@",_zffsDataArr[indexPath.row][@"use_name"],_zffsDataArr[indexPath.row][@"account"]] forKey:@"account"];
                
                [dic setObject:_zffsDataArr[indexPath.row][@"id"] forKey:@"account_id"];
                
                [dic setObject:_zffsDataArr[indexPath.row][@"type"] forKey:@"type"];
            }
            
            UITextField *textfield = [paymentTableView viewWithTag:1000+i];
            NSLog(@"%@",textfield.text);
            if (textfield) {
                [dic setObject:textfield.text forKey:@"amount"];

            }
            [_dataArr replaceObjectAtIndex:i withObject:dic];
            
        }
        
        [paymentTableView reloadData];
        
        zffsView.hidden = YES;
        
        bgView.hidden = YES;
        
    }

}

//计算器按钮
- (void)jsqAction{
    [showView removeFromSuperview];
    [key removeFromSuperview];
    bgView.hidden = NO;
    //计算器
    showView=[[UILabel alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth,200)];
    showView.backgroundColor=[UIColor darkGrayColor];
    showView.userInteractionEnabled = YES;
    showView.tag=1;//设置tag，方便后面对他操作
    [showView setTextAlignment:NSTextAlignmentRight];
    [showView setFont:[UIFont systemFontOfSize:40]];
    [[UIApplication sharedApplication].keyWindow addSubview:showView];
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(11, showView.height-40, 50, 30);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [showView addSubview:backButton];
    
    //创建了一个自定义视图，显示键盘，并且按键监控
    key=[[Keyboard alloc]initWithFrame:CGRectMake(0, 264, kScreenWidth, kScreenHeight-200-64)];
    [[UIApplication sharedApplication].keyWindow addSubview:key];
    showView.text = [NSString stringWithFormat:@"%@",key.result];//设置显示的结果

    showView.text = moneyTextField.text;
}

- (void)backButtonAction{
    
    [showView removeFromSuperview];
    [key removeFromSuperview];
    bgView.hidden = YES;
    showView.hidden = YES;
    key.hidden = YES;
    moneyTextField.text = showView.text;
    
}

//问号按钮
- (void)whAction{
    
    
}

//返回
- (void)leftBtnAction{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackNotification" object:nil];

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    bgView.hidden = YES;
    //改变导航栏标题的字体颜色和大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏背景.png"] forBarMetrics:UIBarMetricsDefault];
    

}
//修改金额
- (void)moneyAction{

    [moneyTextField becomeFirstResponder];
    
}
//修改备注
- (void)remarkAction{

    
    [remarkTextView becomeFirstResponder];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    
    
    if (scrollView == paymentTableView) {
        CGFloat contentOffsetY = scrollView.contentOffset.y;
        

        if (fabs(contentOffsetY - contoffY) > 90) {
        
            NSInteger money = 0;
            
            for (int i = 0; i < _dataArr.count; i++) {
                
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[i]];
                
                UITextField *textfield = [paymentTableView viewWithTag:1000+i];
                if (textfield) {
                    [dic setObject:textfield.text forKey:@"amount"];
                    money = money + [textfield.text integerValue];
                }
                [_dataArr replaceObjectAtIndex:i withObject:dic];
                
            }
            
            oldMoneyLabel.text = [NSString stringWithFormat:@"还需支付:%ld",[moneyTextField.text integerValue] - money];
            contoffY = contentOffsetY;
        }
    }
}
//结束编辑
- (void)EndEditingTextField{


    //设置动画的名字
    [UIView beginAnimations:@"Animation" context:nil];
    //设置动画的间隔时间
    [UIView setAnimationDuration:0.20];
    //??使用当前正在运行的状态开始下一段动画
    [UIView setAnimationBeginsFromCurrentState: YES];
    //设置视图移动的位移
    paymentTableView.frame = CGRectMake(paymentTableView.frame.origin.x, paymentTableView.frame.origin.y + 160, paymentTableView.frame.size.width, paymentTableView.frame.size.height);
    //设置动画结束
    [UIView commitAnimations];

}

- (void)EndEditingTextFieldOne{

    NSInteger money = 0;
    
    for (int i = 0; i < _dataArr.count; i++) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[i]];
        
        UITextField *textfield = [paymentTableView viewWithTag:1000+i];
        if (textfield) {
            [dic setObject:textfield.text forKey:@"amount"];
            money = money + [textfield.text integerValue];
        }
        [_dataArr replaceObjectAtIndex:i withObject:dic];
        
    }
    
    oldMoneyLabel.text = [NSString stringWithFormat:@"还需支付:%ld",[moneyTextField.text integerValue] - money];
    
}

//开始编辑
- (void)BeginEditingTextField{

    
    //设置动画的名字
    [UIView beginAnimations:@"Animation" context:nil];
    //设置动画的间隔时间
    [UIView setAnimationDuration:0.20];
    //??使用当前正在运行的状态开始下一段动画
    [UIView setAnimationBeginsFromCurrentState: YES];
    //设置视图移动的位移
    paymentTableView.frame = CGRectMake(paymentTableView.frame.origin.x, paymentTableView.frame.origin.y - 160, paymentTableView.frame.size.width, paymentTableView.frame.size.height);
    //设置动画结束
    [UIView commitAnimations];

}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSInteger money = 0;
    
    for (int i = 0; i < _dataArr.count; i++) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[i]];
        
        UITextField *textfield = [paymentTableView viewWithTag:1000+i];
        if (textfield) {
            [dic setObject:textfield.text forKey:@"amount"];
            money = money + [textfield.text integerValue];
        }
        [_dataArr replaceObjectAtIndex:i withObject:dic];
        
    }
    oldMoneyLabel.text = [NSString stringWithFormat:@"还需支付:%ld",[moneyTextField.text integerValue] - money];

    
    if (_dataArr.count == 1) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[0]];
        
        [dic setObject:moneyTextField.text forKey:@"amount"];

        [_dataArr replaceObjectAtIndex:0 withObject:dic];
        
        [paymentTableView reloadData];

        oldMoneyLabel.text = @"还需支付:0";

    }
    
}


@end
