//
//  ConsignmentViewController.m
//  奢易购3.0
//
//  Created by guest on 16/7/25.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "ConsignmentViewController.h"
#import "TypeSelectionView.h"
#import "ZLPhoto.h"
#import "StorageTureView.h"
#import "StorageView.h"
#import "AFNetworking.h"
#import "ConsignmentContractView.h"
#import "MerchandiseViewController.h"
#import "ScanViewController.h"
#import "EditSNViewController.h"
#import "CustomerInformationViewController.h"
#import "SticksViewController.h"
#import "LabelClassificationViewController.h"
#import "MBProgressHUD.h"
#import "BrandChoiceViewController.h"


@interface ConsignmentViewController ()<ZLPhotoPickerViewControllerDelegate,UITextViewDelegate,UITextFieldDelegate,UICollectionViewDelegate>{

    UIView *_birthView;
    UIDatePicker *_datePicker;
    NSDate *_birthDate;
    
    UIView *bgView;
    StorageView *storageV;
    TypeSelectionView *typeSelectionV;
    
    UIView *QXESView;
    
    ConsignmentContractView *consignmentContractV;
    NSString *idStr;
    NSString *nameStr;
    
    NSString *good_id;
    NSString *goods_sn;
    
    NSInteger BQCellHeight;
    
    NSInteger NumberCellHeight;
    
    NSInteger TextCellHeight;
    
    NSArray *colorArr;
    
    NSMutableDictionary *colorDic;
    
    
}

@property (weak, nonatomic) IBOutlet UITextField *brandTextField;

@property (nonatomic,strong) NSDictionary *brandDic;


@property (weak, nonatomic) IBOutlet UITextView *friendTextView;

@property (weak, nonatomic) IBOutlet UITableViewCell *NumberCell;

@property (nonatomic,strong) NSMutableArray *numberArr;

@property (weak, nonatomic) IBOutlet UITableViewCell *TextCell;

@property (nonatomic,strong) NSMutableArray *textArr;


@property (nonatomic,strong) NSMutableArray *BQArr;

@property (weak, nonatomic) IBOutlet UITableViewCell *BQCell;

@property (weak, nonatomic) IBOutlet UICollectionView *consignmentCollectionView;
@property (nonatomic,strong) NSMutableArray *imageArr;
@property (nonatomic,strong) NSDictionary *typeDic;
@property (nonatomic,strong) NSMutableArray *imageStrArr;

@property (weak, nonatomic) IBOutlet UITextField *JSRTextField;
@property (nonatomic,strong) NSDictionary *JSRDic;

@end

@implementation ConsignmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

    _JMSJTextField.userInteractionEnabled = NO;
    _BQArr = [NSMutableArray array];
    BQCellHeight = 55;
    NumberCellHeight = 44;
    TextCellHeight = 92;
    _imageArr = [NSMutableArray array];
    _imageStrArr = [NSMutableArray array];

    for (int i = 0; i< 9; i++) {
        NSString *str = @"";
        
        [_imageStrArr addObject:str];
        
    }
    
    idStr = @"";
    nameStr = @"";
    good_id = @"";
    _SPSLTextField.text = @"1";
    
    _numberArr = [NSMutableArray array];
    
    _textArr = [NSMutableArray array];
    
    self.navigationItem.title = @"生成寄卖单";
    
    _JSRTextField.userInteractionEnabled = NO;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    _JSRTextField.placeholder = SYGData[@"user_name"];
    
    _JMKHLabel.userInteractionEnabled = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tureAction:) name:@"SupplierTureNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectTypeAction:) name:@"SelectTypeNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ContractAction) name:@"ContractNotification" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(consignmentCNotifiationAction) name:@"AddContractNotification" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notiPushCell:) name:@"NotiPushCell" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(RemoveAllCell) name:@"RemoveAllCell" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotifacationTypeSelection) name:@"NSNotifacationTypeSelection" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SNEditAction:) name:@"SNEditAction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AddSticksNotification:) name:@"AddSticksNotification" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LabelClassificationNotification:) name:@"LabelClassificationNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BrandChoiceNotification:) name:@"BrandChoiceNotification" object:nil];

    
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
    
    if (_isEdit) {
        
        //右边Item
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(0, 0, 35, 30);
        [rightBtn setTitle:@"删除" forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [rightBtn addTarget:self action:@selector(delegateAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
        self.navigationItem.rightBarButtonItem = rightButtonItem;
        
    }else{
    
        if (_codeDic) {
            
            _JMDLabel.text = [NSString stringWithFormat:@"寄卖单号:%@",_codeDic[@"goods_sn"]];
            good_id = _codeDic[@"id"];
            goods_sn = _codeDic[@"goods_sn"];
            
        }else{
            
            idStr = @"1";
            
//            _KHDic = @{@"name":@"",@"id":@"1",@"phone":@""};

            //商品编号数据
            [self SPBHData];
            
        }

    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, kScreenHeight-64-50, kScreenWidth, 50);
    button.backgroundColor = [RGBColor colorWithHexString:@"#026fbb"];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    button.tag = 100;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
 
    [_consignmentCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ConsignmentCollectionViewCell"];
    
    _BZTextField.delegate = self;
    _SPSLTextField.delegate = self;
    _SPMCTextField.delegate = self;
    _JMSJTextField.delegate = self;
    _KHDSJTextField.delegate = self;
//    _YJTextField.delegate = self;
    _JMJGTextField.delegate = self;
//    _YJLTextField.delegate = self;

    
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
    
    
    storageV = [[[NSBundle mainBundle]loadNibNamed:@"StorageView" owner:self options:nil]lastObject];
    storageV.frame = CGRectMake(10, 64, kScreenWidth-20, kScreenHeight-53);
    storageV.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:storageV];
    //类型选择
    typeSelectionV = [[[NSBundle mainBundle]loadNibNamed:@"TypeSelectionvView" owner:self options:nil]lastObject];
    typeSelectionV.frame = CGRectMake(10, 64, kScreenWidth-20, 450);
    typeSelectionV.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:typeSelectionV];
    [self loadData];
    
    QXESView = [[UIView alloc]initWithFrame:CGRectMake(10, 44*4+10, kScreenWidth-20, 160)];
    QXESView.hidden = YES;
    QXESView.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    [[UIApplication sharedApplication].keyWindow addSubview:QXESView];
    
    UILabel *qxerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 33, kScreenWidth-20, 21)];
    qxerLabel.textColor = [RGBColor colorWithHexString:@"#787fc7"];
    qxerLabel.text = @"全新二手选择";
    qxerLabel.font = [UIFont systemFontOfSize:17];
    qxerLabel.textAlignment = NSTextAlignmentCenter;
    [QXESView addSubview:qxerLabel];
    
    for (int i = 0; i<2; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i==0) {
            [button setTitle:@"全新" forState:UIControlStateNormal];
        }else{
            [button setTitle:@"二手" forState:UIControlStateNormal];
        }
        [button setTitleColor:[RGBColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, i*44+55+17, kScreenWidth-20, 44);
        button.tag = 200+i;
        [button addTarget:self action:@selector(QXESAction:) forControlEvents:UIControlEventTouchUpInside];
        [QXESView addSubview:button];
    }
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 55+17, kScreenWidth-20, 1)];
    
    view1.backgroundColor = [RGBColor colorWithHexString:@"#d3d3d3"];
    
    [QXESView addSubview:view1];
    
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 44+55+17, kScreenWidth-20, 1)];
    
    view.backgroundColor = [RGBColor colorWithHexString:@"#d3d3d3"];
    
    [QXESView addSubview:view];
    
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    _JMSJTextField.text = dateString;
    
    
    //隐藏键盘
    UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleAction)];;
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    singleRecognizer.cancelsTouchesInView = NO;
    //给self.view添加一个手势监测；
    
    [self.tableView addGestureRecognizer:singleRecognizer];

    
    consignmentContractV.hidden = YES;
    
    
    if (_isEdit) {
        
        
        _JSRTextField.text = _editDic[@"goods"][@"input_add_user_name"];
        
        _JSRDic = @{@"id":_editDic[@"goods"][@"input_add_user"]};
        
        for (NSDictionary *dic in _editDic[@"goods"][@"attribute"]) {
            
            if ([dic[@"type"] isEqualToString:@"select"]) {
                
                [_BQArr addObject:dic];

            }
        }
        
        NSLog(@"%@",_BQArr);
        
        [self BQUpData];

        self.navigationItem.title = @"编辑寄卖商品";

        
        NSDictionary *dic = @{@"id":_editDic[@"goods"][@"category_id"]};
        
        _typeDic = dic;
        
        NSLog(@"%@",_editDic);
        
        if (_editDic[@"goods"][@"brand_id"]) {
            
            if ([_editDic[@"goods"][@"brand_id"] integerValue] != 0) {
                
                NSDictionary *dic1 = @{@"id":_editDic[@"goods"][@"brand_id"],@"brand_name":_editDic[@"goods"][@"brand_name"]};
                
                _brandDic = dic1;
                
                _brandTextField.text = _editDic[@"goods"][@"brand_name"];
                
            }
            
        }
        
        _selectLabel.text = _editDic[@"goods"][@"category_name"];
        _selectImageV.image = [UIImage imageNamed:_editDic[@"goods"][@"category_name"]];
        
        if (!_selectImageV.image) {
            _selectImageV.image = [UIImage imageNamed:@"其他"];
        }
        
        NSLog(@"%@",_editDic);
        good_id = _editDic[@"goods"][@"goods_id"];
        
        goods_sn = _editDic[@"goods"][@"goods_sn"];
        
        _JMDLabel.text = [NSString stringWithFormat:@"寄卖单号:%@",_editDic[@"goods"][@"goods_sn"]];
        
        idStr = _editDic[@"customer_id"];
        
//        _KHXXLabel.text = [NSString stringWithFormat:@"客户信息: %@ %@",_editDic[@"customer_name"],_editDic[@"customer_mobile"]];
        _JMKHLabel.text = [NSString stringWithFormat:@"%@ %@",_editDic[@"customer_name"],_editDic[@"customer_mobile"]];
        _SPMCTextField.text = _editDic[@"goods"][@"goods_name"];
        
        _KHDSJTextField.text = _editDic[@"customer_price"];
        
        
        _JMJGTextField.text = _editDic[@"price"];
        
        _SPSLTextField.text = _editDic[@"goods"][@"number"];
        
        _friendTextView.text = _editDic[@"friend_describe"];
        
        if ([_editDic[@"goods"][@"is_new"] isEqualToString:@"1"]) {
            _QXESLabel.text = @"全新";
        }else{
            _QXESLabel.text = @"二手";
        }
//        _YJTextField.text = _editDic[@"commission"];
        _BZTextField.text = _editDic[@"remark"];

//        _YJLTextField.text = [NSString stringWithFormat:@"%.0lf",[_editDic[@"percent"] floatValue]];
        
        _JMSJTextField.text = _editDic[@"add_time"];
        
        
        NSArray *imageArr = _editDic[@"goods"][@"pic"][@"href"];
        
        for (int i = 0 ; i < imageArr.count; i++) {
            NSLog(@"%@",imageArr[i]);
            
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imageArr[i]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                NSLog(@"");
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                
                if (error) {
                    
                }
                if (image) {
                    [_imageArr addObject:image];
                    
                    if ([BaseUrl isEqualToString:@"http://syg.hpdengshi.com/index.php?s=/Api/"]) {
                        
                        [_imageStrArr replaceObjectAtIndex:i withObject:[imageArr[i] substringFromIndex:23]];
                    }else{
                        
                        [_imageStrArr replaceObjectAtIndex:i withObject:[imageArr[i] substringFromIndex:24]];
                    }

                }
                [_consignmentCollectionView reloadData];
            }];
    }
    }
    
    if (_BJDic) {
        
        [self BJDicAdd];
    }

    _BZLabel.hidden = YES;
    
    [self KHNOEdit];
    

    
    [self customData];
    
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
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [_birthView addSubview:cancelButton];
    [self.tableView addSubview:_birthView];
    
}

- (void)trueAction{
    _birthView.hidden = YES;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormat stringFromDate:_datePicker.date];
    _birthDate = [dateFormat dateFromString:dateStr];
    _JMSJTextField.text = dateStr;
}
- (void)cancelAction{
    _birthView.hidden = YES;
}

//品牌通知
- (void)BrandChoiceNotification:(NSNotification*)noti{
    
    
    _brandTextField.text = [noti object][@"brands_name"];
    
    _brandDic = [noti object];
    
}


//自定义属性
- (void)customData{

    [_numberArr removeAllObjects];
    [_textArr removeAllObjects];
    
    TextCellHeight = 92;
    NumberCellHeight = 44;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    if (_typeDic) {
        [params setObject:_typeDic[@"id"] forKey:@"category_id"];
    }else{
        [params setObject:@"4" forKey:@"category_id"];
    }
    
    [DataSeviece requestUrl:get_category_attributehtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        NSLog(@"%@",result[@"result"][@"msg"]);
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            
            if ([dic[@"type"] isEqualToString:@"number"]) {
                
                [_numberArr addObject:dic];
            }
            
            if ([dic[@"type"] isEqualToString:@"text"]) {
                
                [_textArr addObject:dic];
            }
        }

        for (int i = 0; i < _numberArr.count; i++) {
            
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 44*(i+1), kScreenWidth, 1)];
            view.backgroundColor = [RGBColor colorWithHexString:@"#d9d9d9"];
            [_NumberCell.contentView addSubview:view];

            UILabel *label = [_NumberCell.contentView viewWithTag:500+i];
            
            if (!label) {
                label = [[UILabel alloc]initWithFrame:CGRectMake(10, 11+44*(i+1), 63, 21)];
            }
            
            label.textColor = [RGBColor colorWithHexString:@"#333333"];
            label.font = [UIFont systemFontOfSize:14];
            label.text = [NSString stringWithFormat:@"%@:",_numberArr[i][@"attribute_name"]];
            label.tag = 500+i;
            [_NumberCell.contentView addSubview:label];
            
            UITextField *textField = [_NumberCell.contentView viewWithTag:600+i];
            
            if (!textField) {
                textField = [[UITextField alloc]initWithFrame:CGRectMake(90, 7+44*(i+1), 230, 30)];
            }
            textField.delegate = self;
            textField.font = [UIFont systemFontOfSize:16];
            textField.tag = 600+i;
            [_NumberCell.contentView addSubview:textField];
            
            if (_editDic) {
                
                for (NSDictionary *dic in _editDic[@"goods"][@"attribute"]) {
                    
                    if ([dic[@"type"] isEqualToString:@"number"]) {
                        
                    if ([dic[@"id"] isEqualToString:_numberArr[i][@"id"]]) {
                        
                        textField.text = dic[@"attribute_value"];
                    }
                    }
                    
                }
                
            }

        }
        
        for (int i = 0; i < _textArr.count; i++) {
            
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 44*i +92, kScreenWidth, 1)];
            view.backgroundColor = [RGBColor colorWithHexString:@"#d9d9d9"];
            [_TextCell.contentView addSubview:view];
            
            UILabel *label = [_TextCell.contentView viewWithTag:700+i];
            
            if (!label) {
                label = [[UILabel alloc]initWithFrame:CGRectMake(10, 11+44*i +92, kScreenWidth - 20, 21)];
            }
            
            label.textColor = [RGBColor colorWithHexString:@"#333333"];
            label.font = [UIFont systemFontOfSize:14];
            label.text = [NSString stringWithFormat:@"%@:",_textArr[i][@"attribute_name"]];
            label.tag = 700+i;
            [_TextCell.contentView addSubview:label];
            
            UITextView *textField = [_TextCell.contentView viewWithTag:800+i];
            
            if (!textField) {
                textField = [[UITextView alloc]initWithFrame:CGRectMake(10, label.bottom, kScreenWidth -20, 60)];
            }

            textField.delegate = self;

            textField.font = [UIFont systemFontOfSize:16];
            textField.tag = 800+i;
            [_TextCell.contentView addSubview:textField];
            
            if (_editDic) {
                
                for (NSDictionary *dic in _editDic[@"goods"][@"attribute"]) {
                    
                    if ([dic[@"type"] isEqualToString:@"text"]) {

                    if ([dic[@"id"] isEqualToString:_textArr[i][@"id"]]) {
                        
                        textField.text = dic[@"attribute_value"];
                    }
                        
                    }
                    
                }
                
            }
        }

        NumberCellHeight = NumberCellHeight + (44*_numberArr.count);
        
        TextCellHeight = TextCellHeight + (92*_textArr.count);

        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

//清空界面
- (void)removeUI{

    
    NSDictionary *dic = @{@"id":@"2"};
    
    _typeDic = dic;
    
    _selectLabel.text = @"箱包";
    _selectImageV.image = [UIImage imageNamed:@"箱包"];
    
    if (!_selectImageV.image) {
        _selectImageV.image = [UIImage imageNamed:@"其他"];
    }
    if ([idStr isEqualToString:@"1"]) {
        
    }else{
    
    idStr = _KHDic[@"id"];
    
        _JMKHLabel.text = [NSString stringWithFormat:@"%@ %@",_KHDic[@"name"],_KHDic[@"mobile"]];
    }
    
    _SPMCTextField.text = @"";
    
    _KHDSJTextField.text = @"";
    
    
    _JMJGTextField.text = @"";
    
    _SPSLTextField.text = @"1";
    _QXESLabel.text = @"全新";

    _BZTextField.text = @"";
    
    
    _KHCell.userInteractionEnabled = NO;
    [_imageArr removeAllObjects];
    [_imageStrArr removeAllObjects];
    [_consignmentCollectionView reloadData];
    
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    [self SPBHData];
    
}


//客户信息不可变
- (void)KHNOEdit{

    if (_KHDic) {
        NSLog(@"%@",_KHDic);
        _KHCell.userInteractionEnabled = NO;
//        _KHXXLabel.text = [NSString stringWithFormat:@"客户信息: %@ %@",_KHDic[@"name"],_KHDic[@"mobile"]];
        _JMKHLabel.text = [NSString stringWithFormat:@"%@ %@",_KHDic[@"name"],_KHDic[@"mobile"]];
        idStr = _KHDic[@"id"];
        nameStr = _KHDic[@"name"];
    }
}
//入库编辑
- (void)BJDicAdd{
    
    self.navigationItem.title = @"修改寄卖商品";
    
    _KHCell.userInteractionEnabled = NO;
    
    NSDictionary *dic = @{@"id":_BJDic[@"category_id"]};
    
    _typeDic = dic;
    
    _selectLabel.text = _BJDic[@"category_name"];
    _selectImageV.image = [UIImage imageNamed:_BJDic[@"category_name"]];
    
    if (!_selectImageV.image) {
        _selectImageV.image = [UIImage imageNamed:@"其他"];
    }
    
    idStr = _KHDic[@"id"];
//    _KHXXLabel.text = [NSString stringWithFormat:@"客户信息: %@ %@",_KHDic[@"name"],_KHDic[@"mobile"]];
    _JMKHLabel.text = [NSString stringWithFormat:@"%@ %@",_KHDic[@"name"],_KHDic[@"mobile"]];
    _SPMCTextField.text = _BJDic[@"goods_name"];
    
    _KHDSJTextField.text = _BJDic[@"customer_price"];
    
    
    _JMJGTextField.text = _BJDic[@"price"];
    
    _SPSLTextField.text = _BJDic[@"number"];
    
    if ([_BJDic[@"is_new"] isEqualToString:@"1"]) {
        _QXESLabel.text = @"全新";
    }else{
        _QXESLabel.text = @"二手";
        
    }
    _BZTextField.text = _BJDic[@"remark"];

    good_id = _BJDic[@"id"];
    
    goods_sn = _BJDic[@"goods_sn"];
    
    _JMDLabel.text = [NSString stringWithFormat:@"寄卖单号:%@",_BJDic[@"goods_sn"]];

}


//删除按钮
- (void)delegateAction{

    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否确定删除" delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"确定", nil];
    
    [alertV show];
    
    
    
}

//商品编号数据
- (void)SPBHData{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    [params setObject:@"JM" forKey:@"type"];
    
    [DataSeviece requestUrl:create_goods_snhtml params:params success:^(id result) {
        NSLog(@"%@",result[@"result"]);
        
        goods_sn = result[@"result"][@"data"][@"goods_sn"];
        _JMDLabel.text = [NSString stringWithFormat:@"寄卖单号:%@",result[@"result"][@"data"][@"goods_sn"]];
        good_id = result[@"result"][@"data"][@"id"];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


//全新二手
- (void)QXESAction:(UIButton*)bt{
    QXESView.hidden = YES;
    bgView.hidden = YES;
    if (bt.tag == 200) {
        _QXESLabel.text = @"全新";
    }else{
        _QXESLabel.text = @"二手";
    }
}

//添加图片
- (IBAction)addImageVAction:(id)sender {
    
    if (_imageArr.count >= 9) {
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];

        alertV.message = @"图片不能超过九张";
        [alertV show];
    }else{
    
    // 创建控制器
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    // 默认显示相册里面的内容SavePhotos
    // 最多能选9张图片
    pickerVc.topShowPhotoPicker = YES;
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.delegate = self;
    [pickerVc showPickerVc:self];
    }
    
}

//类型选择
- (void)loadData{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    [params setObject:@"1" forKey:@"classify"];
    
    [DataSeviece requestUrl:get_category_listhtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            typeSelectionV.dataArr = result[@"result"][@"data"][@"item"];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


#pragma mark - 相册回调
- (void)pickerViewControllerDoneAsstes:(NSArray *)assets{
    if (_imageArr.count + assets.count > 9) {
        
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        alertV.message = @"图片不能超过九张";
        [alertV show];
        
        return;
    }

    NSInteger item = _imageArr.count;
    
    
    NSMutableArray *imageArr1 = [NSMutableArray array];
    for (int i = 0; i <assets.count; i++) {
        ZLPhotoAssets *asset = assets[i];
        ZLCamera *asset1  = assets[i];
        
        if ([assets[i] isKindOfClass:[ZLCamera class]]) {
            [_imageArr addObject:asset1.photoImage];
            [imageArr1 addObject:asset1.photoImage];
        }else{
            [_imageArr addObject:asset.originImage];
            [imageArr1 addObject:asset.originImage];
        }
    }

    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
    
    [params1 setObject:SYGData[@"id"] forKey:@"uid"];

    
    [DataSeviece requestUrl:get_qiniu_tokenhtml params:params1 success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        for (int i = 0; i < imageArr1.count; i++) {
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            
            [params setObject:result[@"result"][@"data"][@"qiniu_token"] forKey:@"token"];
            
            [params setObject:SYGData[@"shop_id"] forKey:@"x:shop_id"];

//            [params setObject:@{@"uid":SYGData[@"id"],@"sort":[NSString stringWithFormat:@"%ld",item+i]} forKey:@"data"];
            

            
            [manager POST:@"http://up-z2.qiniu.com" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                
                NSLog(@"image  %@",_imageArr[i]);
                
                NSData *imgData = UIImageJPEGRepresentation(imageArr1[i], 1);
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // 设置时间格式
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
                
                [formData appendPartWithFileData:imgData name:@"file" fileName:fileName mimeType:@"image/png"];
                
            } success:^(NSURLSessionDataTask *task, id responseObject) {
                
                NSLog(@"%@",responseObject);
                
                NSLog(@"%ld %ld",item,i+item);
                
                [_imageStrArr replaceObjectAtIndex:item + i withObject:responseObject[@"result"][@"data"][@"file_name"]];
                
                NSLog(@"%@",_imageStrArr);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@",error);
            }];
        }
        
        [_consignmentCollectionView reloadData];

        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    

    
    
    
}
#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _imageArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ConsignmentCollectionViewCell" forIndexPath:indexPath];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 52, 52)];
    
    imageV.image = _imageArr[indexPath.row];
    [cell.contentView addSubview:imageV];
    
    UIButton *deleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleButton.frame =  CGRectMake(42, 0, 20, 20);
    [deleButton setImage:[UIImage imageNamed:@"delet@2x"] forState:UIControlStateNormal];
    [deleButton addTarget:self action:@selector(deleteImageAction:) forControlEvents:UIControlEventTouchUpInside];
    deleButton.tag = 300+indexPath.row;
    [cell.contentView addSubview:deleButton];
    
    return cell;
}

//删除图片
- (void)deleteImageAction:(UIButton*)bt{

    NSInteger index = bt.tag - 300;
    
    [_imageArr removeObjectAtIndex:index];
    
    [_imageStrArr replaceObjectAtIndex:index withObject:@""];
    
    for (int i = 0; i < _imageArr.count+2; i++) {
        
        if (_imageArr.count != index) {
            
            if (i == 9) {
                
                [_imageStrArr replaceObjectAtIndex:8 withObject:@""];
                
            }else if (i > index) {
                
                [_imageStrArr replaceObjectAtIndex:i - 1 withObject:_imageStrArr[i]];
            }
        }
    }
    

    
    [_consignmentCollectionView reloadData];
    
}


#pragma mark -UITableViewDataSource||UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 4) {
        bgView.hidden = NO;
        typeSelectionV.hidden = NO;
    }else if (indexPath.row == 5){
        
        NSLog(@"品牌");
        
        //品牌
        BrandChoiceViewController *BrandChoiceVC = [[BrandChoiceViewController alloc]init];
        
        NSLog(@"%@",_typeDic);
        
        if (_typeDic) {
            
            BrandChoiceVC.sort_id = _typeDic[@"id"];
            
        }else{
            
            BrandChoiceVC.sort_id = @"4";
        }
        
        
        [self.navigationController pushViewController:BrandChoiceVC animated:YES];
        

    }else if (indexPath.row == 6){
        
        QXESView.hidden = NO;
        bgView.hidden = NO;
        
    }else if (indexPath.row == 7){
        CustomerInformationViewController *customerInformationVC = [[CustomerInformationViewController alloc]init];
        
        [self.navigationController pushViewController:customerInformationVC animated:YES];
        
    }else if (indexPath.row == 10){
    
        SticksViewController *sticksVC = [[SticksViewController alloc]init];
        
        [self.navigationController pushViewController:sticksVC animated:YES];
        
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
        return 44;
    }else if (indexPath.row == 1){
        return 10;
    }else if (indexPath.row == 2){
        return 94;
    }else if (indexPath.row == 3){
        return 10;
    }else if (indexPath.row == 4){
        return 44;
    }else if (indexPath.row == 5){
        return 44;
    }else if (indexPath.row == 6){
        return 44;
    }else if (indexPath.row == 7){
        return 44;
    }else if (indexPath.row == 8){
        return BQCellHeight;
    }else if (indexPath.row == 9){
        return 44;
    }else if (indexPath.row == 10){
        return 44;
    }else if (indexPath.row == 11){
        return 10;
    }else if (indexPath.row == 12){
        return 44;
    }else if (indexPath.row == 13){
        return 44;
    }else if (indexPath.row == 14){
        return 44;
    }else if (indexPath.row == 15){
        return NumberCellHeight;
    }else if (indexPath.row == 16){
        return 10;
    }else if (indexPath.row == 17){
        return TextCellHeight;
    }else if (indexPath.row == 18){
        return 72;
    }else if (indexPath.row == 19){
        return 10;
        
    }else if (indexPath.row == 20){
        return 92;
    }

    return 0;
}

//隐藏视图
- (void)bgButtonAction{
    
    
    bgView.hidden = YES;
    storageV.hidden = YES;
    typeSelectionV.hidden = YES;
    QXESView.hidden = YES;
    
    if (consignmentContractV&&consignmentContractV.hidden == NO) {

        consignmentContractV.hidden = YES;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

        NSMutableArray *arr = [NSMutableArray arrayWithArray:[defaults objectForKey:@"contractData1"]];

        if (arr.count !=0) {
            [arr removeObjectAtIndex:0];
            [defaults setObject:arr forKey:@"contractData1"];
            [defaults synchronize];
        }
        
    }
}


//点击完成和继续添加
- (void)buttonAction:(UIButton*)bt{
    
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    
    for (int i = 0; i < 9; i++) {
        
        if (![_imageStrArr[i] isEqualToString:@""]) {
            
            [dic setObject:_imageStrArr[i] forKey:[NSString stringWithFormat:@"%d",i]];
        }
    }
    
    if (dic.count < _imageArr.count) {
        
        alertV.message = @"图片还未上传成功,请稍后";
        [alertV show];
        return;
        
    }
    
    if ([_SPMCTextField.text isEqualToString:@""]&&_imageArr.count == 0) {
        alertV.message = @"商品名称和图片不能同时为空";
        [alertV show];
        return;

    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    
    [params setObject:good_id forKey:@"id"];
    
    [params setObject:goods_sn forKey:@"goods_sn"];
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    if (_JSRDic[@"id"]) {
        [params setObject:_JSRDic[@"id"] forKey:@"add_user"];
    }
    if (_typeDic) {
        [params setObject:_typeDic[@"id"] forKey:@"category_id"];
    }else{
        [params setObject:@"4" forKey:@"category_id"];
    }
    
    if (_brandDic) {
        
        [params setObject:_brandDic[@"id"] forKey:@"brand_id"];
        
        [params setObject:_brandDic[@"brands_name"] forKey:@"brand_name"];
    }
    
    [params setObject:_selectLabel.text forKey:@"category_name"];
    [params setObject:idStr forKey:@"customer_id"];
    
    [params setObject:_SPMCTextField.text forKey:@"goods_name"];
    
    [params setObject:_KHDSJTextField.text forKey:@"cost"];
    
    [params setObject:_JMJGTextField.text forKey:@"price"];
    
    [params setObject:_SPSLTextField.text forKey:@"number"];
    
    
    if ([_QXESLabel.text isEqualToString:@"全新"]) {
        [params setObject:@"1" forKey:@"is_new"];
    }else{
        [params setObject:@"2" forKey:@"is_new"];
    }
    
    [params setObject:@"JM" forKey:@"type"];
    
    [params setObject:_BZTextField.text forKey:@"remark"];
    
    [params setObject:nameStr forKey:@"name"];
    
    if (_imageStrArr.count != 0) {
        NSString *imageStr = @"";
        
        for (NSString *str in _imageStrArr) {
            
            if (![str isEqualToString:@""]) {
                
                imageStr = [NSString stringWithFormat:@"%@,%@",imageStr,str];
            }
        }
        if ([imageStr isEqualToString:@""]) {
            
        }else{

        imageStr = [imageStr substringFromIndex:1];
        }
        [params setObject:imageStr forKey:@"photo"];
    }
    
    [params setObject:_KHDSJTextField.text forKey:@"customer_price"];

    NSMutableDictionary *idDic = [NSMutableDictionary dictionary];

    for (NSDictionary *dic in _BQArr) {
        
        [idDic setObject:dic[@"attribute_name"] forKey:dic[@"id"]];
    }
    NSMutableDictionary *textDic = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < _numberArr.count; i++) {
        
        UITextField *textField = [_NumberCell.contentView viewWithTag:600+i];
        
        [textDic setObject:textField.text forKey:_numberArr[i][@"id"]];
        
    }

    for (int i = 0; i < _textArr.count; i++) {
        
        UITextView *textField = [_TextCell.contentView viewWithTag:800+i];
        
        [textDic setObject:textField.text forKey:_textArr[i][@"id"]];
        
    }

    [params setObject:@{@"select":idDic,@"text":textDic} forKey:@"attribute"];
    
    [params setObject:_JMSJTextField.text forKey:@"add_time"];
    
    [params setObject:_friendTextView.text forKey:@"friend_describe"];
    
    if (bt.tag  == 100) {
        
        if (_isEdit) {
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
            
            [params setObject:SYGData[@"id"] forKey:@"uid"];
            [params setObject:_editDic[@"goods"][@"goods_id"] forKey:@"id"];
            NSLog(@"%@",_editDic);
            
            [params setObject:_typeDic[@"id"] forKey:@"category_id"];
            [params setObject:_SPMCTextField.text forKey:@"goods_name"];
            [params setObject:_editDic[@"goods"][@"goods_sn"] forKey:@"goods_sn"];
            [params setObject:_KHDSJTextField.text forKey:@"cost"];
            [params setObject:_JMJGTextField.text  forKey:@"price"];
            [params setObject:_JMJGTextField.text forKey:@"money"];
            [params setObject:_SPSLTextField.text forKey:@"number"];
            [params setObject:@"JM" forKey:@"type"];
            [params setObject:idStr forKey:@"customer_id"];
            [params setObject:_BZTextField.text forKey:@"remark"];
            [params setObject:_JSRDic[@"id"] forKey:@"add_user"];
            [params setObject:_JMSJTextField.text forKey:@"add_time"];
            [params setObject:_friendTextView.text forKey:@"friend_describe"];

            if (_brandDic) {
                
                [params setObject:_brandDic[@"id"] forKey:@"brand_id"];
                
                [params setObject:_brandDic[@"brands_name"] forKey:@"brand_name"];
            }
            

            
            NSMutableDictionary *idDic = [NSMutableDictionary dictionary];
            
            for (NSDictionary *dic in _BQArr) {
                
                [idDic setObject:dic[@"attribute_name"] forKey:dic[@"id"]];
            }
            NSMutableDictionary *textDic = [NSMutableDictionary dictionary];
            
            for (int i = 0; i < _numberArr.count; i++) {
                
                UITextField *textField = [_NumberCell.contentView viewWithTag:600+i];
                
                [textDic setObject:textField.text forKey:_numberArr[i][@"id"]];
                
            }
            
            for (int i = 0; i < _textArr.count; i++) {
                
                UITextView *textField = [_TextCell.contentView viewWithTag:800+i];
                
                [textDic setObject:textField.text forKey:_textArr[i][@"id"]];
                
            }
            
            [params setObject:@{@"select":idDic,@"text":textDic} forKey:@"attribute"];
            
            
            if (_imageStrArr.count != 0) {
                NSString *imageStr = @"";
                
                for (NSString *str in _imageStrArr) {
                    
                    if (![str isEqualToString:@""]) {
                        imageStr = [NSString stringWithFormat:@"%@,%@",imageStr,str];

                    }
                    
                }
                if ([imageStr isEqualToString:@""]) {
                    
                }else{

                imageStr = [imageStr substringFromIndex:1];
                }
                NSLog(@"%@",imageStr);
                [params setObject:imageStr forKey:@"photo"];
            }
            
            if ([_QXESLabel.text isEqualToString:@"全新"]) {
                [params setObject:@"1"forKey:@"is_new"];
            }else{
                [params setObject:@"2"forKey:@"is_new"];
            }
            
            
            [params setObject:@"2" forKey:@"is_pause"];
            [params setObject:_KHDSJTextField.text forKey:@"customer_price"];
//            [params setObject:_YJTextField.text forKey:@"commission"];
            
            [DataSeviece requestUrl:edit_goodshtm params:params success:^(id result) {
                NSLog(@"%@",result);
                NSLog(@"%@",result[@"result"][@"msg"]);
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil ,nil];
                
                if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                    
                    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
                    hud.labelText = @"编辑成功";
                    hud.mode = MBProgressHUDModeCustomView;
                    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"done@2x"]];
                    
                    [[UIApplication sharedApplication].keyWindow addSubview:hud];
                    
                    [hud showAnimated:YES whileExecutingBlock:^{
                        sleep(1);
                    } completionBlock:^{
                        [hud removeFromSuperview];
                    }];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"EditNotification" object:nil];

                    [self.navigationController popViewControllerAnimated:YES];

                }else{
                
                    alert.message = result[@"result"][@"msg"];
                    [alert show];
                }
                
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];

            
        }else{
        
            //数据储存
            
            NSMutableArray * arr1 = [NSMutableArray arrayWithArray:[defaults objectForKey:@"contractData1"]];
            if (_BJDic) {
                [arr1 replaceObjectAtIndex:_index withObject:params];
            }else{
                [arr1 addObject:params];
            }
            
            [defaults setObject:arr1 forKey:@"contractData1"];
            
            [defaults synchronize];
            
            bgView.hidden = NO;
            
            [consignmentContractV removeFromSuperview];
            consignmentContractV = [[[NSBundle mainBundle]loadNibNamed:@"ConsignmentContractView" owner:self options:nil]lastObject];
            consignmentContractV.frame = CGRectMake(10, 64, kScreenWidth-20, 450);
        
            [[UIApplication sharedApplication].keyWindow addSubview:consignmentContractV];
        }

    }else{
    
        [self removeUI];
        
    }
    
}

- (void)consignmentCNotifiationAction{

    consignmentContractV.hidden = YES;
    bgView.hidden = YES;
    _BJDic = nil;
    [self removeUI];

}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == self.tableView) {
        CGFloat contentOffsetY = scrollView.contentOffset.y;
        _birthView.transform = CGAffineTransformMakeTranslation(0, contentOffsetY);

        for (int i = 0; i<2; i++) {
            UIButton *bt = [self.view viewWithTag:100+i];
            
            bt.transform = CGAffineTransformMakeTranslation(0, contentOffsetY);
        }

    }
}

//左边返回按钮
- (void)leftBtnAction{
    

    if (_editDic) {
        
        [self.navigationController popViewControllerAnimated:YES];

        
    }else{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[defaults objectForKey:@"contractData1"]];

    if (arr.count == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BackNotification" object:nil];
        
        [self.navigationController popViewControllerAnimated:YES];
 
    }else{
        
        bgView.hidden = NO;
        [consignmentContractV removeFromSuperview];
        
        consignmentContractV = [[[NSBundle mainBundle]loadNibNamed:@"ConsignmentContractView"  owner:self options:nil]lastObject];
        consignmentContractV.frame = CGRectMake(10, 64, kScreenWidth-20, 450);
        
        [[UIApplication sharedApplication].keyWindow addSubview:consignmentContractV];
    }
        
        
    }
//    [defaults removeObjectForKey:@"contractData1"];
//    
//    [defaults synchronize];

    
}
#pragma mark -UITextViewDelegate||UITextFieldDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    _BZLabel.hidden = YES;
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if (textView.text.length == 0) {
        _BZLabel.hidden = NO;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];

    return YES;
}


- (void)singleAction{

    [_BZTextField resignFirstResponder];
    [_SPSLTextField resignFirstResponder];
    [_SPMCTextField resignFirstResponder];
    [_JMSJTextField resignFirstResponder];
    [_KHDSJTextField resignFirstResponder];
    [_JMJGTextField resignFirstResponder];
    

    for (int i = 0; i < _numberArr.count; i++) {
        UITextField *textField = [_NumberCell.contentView viewWithTag:600+i];
        
        [textField resignFirstResponder];
    }
    
    for (int i = 0; i < _textArr.count; i++) {
        UITextView *textField = [_TextCell.contentView viewWithTag:800+i];
        
        [textField resignFirstResponder];
    }

}



//移除通知
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
//接收通知
- (void)tureAction:(NSNotification*)noti{
    
//    supplierV.hidden = YES;
//    bgView.hidden = YES;
    
    NSDictionary *dic = [noti object];
    _JMKHLabel.text = [NSString stringWithFormat:@"%@ %@ %@",dic[@"name"],dic[@"mobile"],dic[@"wechat"]];
//    _KHXXLabel.text = [NSString stringWithFormat:@"客户信息: %@ %@ %@",dic[@"name"],dic[@"mobile"],dic[@"wechat"]];
    
    idStr = dic[@"id"];
    nameStr = dic[@"name"];
    _KHDic = dic;
}
//选择通知
- (void)selectTypeAction:(NSNotification*)noti{
    
    bgView.hidden = YES;
    typeSelectionV.hidden = YES;
    
    NSDictionary *dic = [noti object];
    
    _typeDic = dic;
    
    if (![_selectLabel.text isEqualToString:dic[@"category_name"]]) {
        [_BQArr removeAllObjects];
        BQCellHeight = 65;
        [self BQUpData];
        [self.tableView reloadData];
    }
    
    _selectLabel.text = dic[@"category_name"];
    
    _selectImageV.image = [UIImage imageNamed:dic[@"category_name"]];
    
    if (!_selectImageV.image) {
        _selectImageV.image = [UIImage imageNamed:@"其他"];
    }
    
    [self customData];
    
}

//完成通知
- (void)ContractAction{
    bgView.hidden = YES;
    consignmentContractV.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ConsignmentNotification" object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}



- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //改变导航栏标题的字体颜色和大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"寄卖背景"] forBarMetrics:UIBarMetricsDefault];


}

- (void)notiPushCell:(NSNotification*)noti{
    consignmentContractV.hidden = YES;
    bgView.hidden = YES;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSArray *arr = [defaults objectForKey:@"contractData1"];
    
    _index = [[noti object] integerValue];
    
    NSDictionary *dic = arr[_index];
    
    _BJDic = dic;
    
    [self BJDicAdd];


}

- (void)RemoveAllCell{

    bgView.hidden = YES;
    consignmentContractV.hidden = YES;
}


- (void)NSNotifacationTypeSelection{
    
    [self loadData];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:SYGData[@"id"] forKey:@"uid"];
        [params setObject:_editDic[@"goods"][@"goods_id"] forKey:@"id"];
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:  nil, nil];

        [DataSeviece requestUrl:delete_goodshtml params:params success:^(id result) {
            NSLog(@"%@",result);
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                alertV.message = @"删除成功" ;
                
                [alertV show];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"BackNotification" object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ConsignmentNotification" object:nil];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
            
                alertV.message = result[@"result"][@"msg"];
                
                [alertV show];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];

    }
}

- (IBAction)editSNAction:(id)sender {
    
    EditSNViewController *editSNVC = [[EditSNViewController alloc]init];
    
    editSNVC.snStr = [_JMDLabel.text substringFromIndex:5];
    [self.navigationController pushViewController:editSNVC animated:YES];
    
}


- (void)SNEditAction:(NSNotification*)noti{
    
    goods_sn = [noti object];
    _JMDLabel.text = [NSString stringWithFormat:@"寄卖单号:%@",[noti object]];
    
}

//经手人返回通知
- (void)AddSticksNotification:(NSNotification*)noti{
    
    _JSRDic = [noti object];
    
    _JSRTextField.text = _JSRDic[@"user_name"];
    
    
}
//标签跳转
- (IBAction)BQAction:(id)sender {
    
    LabelClassificationViewController *LabelClassificationVC = [[LabelClassificationViewController alloc]init];
    
    if (_typeDic) {
        LabelClassificationVC.category_id =_typeDic[@"id"];
    }else{
        
        LabelClassificationVC.category_id = @"4";
    }

    if (_BQArr.count != 0) {
        
        LabelClassificationVC.oldArr = [_BQArr copy];
    }
    
    
    
    [self.navigationController pushViewController:LabelClassificationVC animated:YES];
    
}

//标签通知
- (void)LabelClassificationNotification:(NSNotification*)noti{


    _BQArr = [NSMutableArray arrayWithArray:[noti object]];
    
    [self BQUpData];
    

}
//标签删除
- (void)BQbuttonAction:(UIButton*)bt{

    
    NSInteger index = bt.tag - 10000;
    
    [_BQArr removeObjectAtIndex:index];
    
    [self BQUpData];
    
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
        
        
        if (left + rect.size.width > kScreenWidth - 75) {
            BQCellHeight = BQCellHeight +30;
            left = 10;
        }
        
        button.frame = CGRectMake(left, BQCellHeight, rect.size.width+10, 20);
        [button setTitle:labelArr[i][@"attribute_name"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        
        NSString *color = colorDic[labelArr[i][@"parent_id"]];
        
        if (!color) {
            
            NSInteger index = colorDic.count%10;
            
            color = colorArr[index];
            
            [colorDic setObject:colorArr[index] forKey:labelArr[i][@"parent_id"]];
        }
        
        button.backgroundColor = [RGBColor colorWithHexString:color];
        button.layer.cornerRadius = 3;
        button.layer.masksToBounds = YES;
        button.tag = 10000 + i;
        [button addTarget:self action:@selector(BQbuttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.selected = YES;
        [_BQCell.contentView addSubview:button];
        left = left + rect.size.width + 20;
        
        UIImageView *imageV = [_BQCell viewWithTag:button.tag +1000];
        if (!imageV) {
        
            imageV = [[UIImageView alloc]init];
        }
        imageV.frame = CGRectMake(button.right - 6, button.top - 6, 13, 13);
        imageV.userInteractionEnabled = YES;
        imageV.image = [UIImage imageNamed:@"deletbq@2x"];
        imageV.tag = button.tag + 1000;
        [_BQCell.contentView addSubview:imageV];
        
    }
    
    for (NSInteger i = labelArr.count; i < labelArr.count +10; i++) {
        
        UIView *view = [_BQCell viewWithTag:10000 + i];
        
        if (view) {
            [view removeFromSuperview];
        }
        
        UIView *view1 = [_BQCell viewWithTag:11000 +i];
        if (view1) {
            [view1 removeFromSuperview];
        }
    }
    BQCellHeight = BQCellHeight +40;
    
    [self.tableView reloadData];
    
}

- (IBAction)timeAction:(id)sender {
    
    _birthView.hidden = NO;
}



@end
