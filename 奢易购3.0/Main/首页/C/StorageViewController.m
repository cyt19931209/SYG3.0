//
//  StorageViewController.m
//  奢易购3.0
//
//  Created by guest on 16/7/25.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "StorageViewController.h"
#import "TypeSelectionView.h"
#import "ZLPhoto.h"
#import "StorageTureView.h"
#import "AFNetworking.h"
#import "StockPriceViewController.h"
#import "StockDetailsViewController.h"
#import "SDWebImageManager.h"
#import "EditSNViewController.h"
#import "PaymentTwoViewController.h"
#import "CustomerInformationViewController.h"
#import "SticksViewController.h"
#import "MBProgressHUD.h"
#import "LabelClassificationViewController.h"
#import "BrandChoiceViewController.h"


@interface StorageViewController ()<ZLPhotoPickerViewControllerDelegate,UITextViewDelegate,UITextViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{

//    NSDictionary *KHDic;

    UIView *_birthView;
    UIDatePicker *_datePicker;
    NSDate *_birthDate;

    UIView *bgView;
    TypeSelectionView *typeSelectionV;
    UIView *QXESView;
    StorageTureView *storageTureV;
    NSString *idStr;
    NSString *good_id;
    NSDictionary *dataDic;
    
    UIAlertView *alertV1;
    
    NSInteger BQCellHeight;
    
    NSInteger NumberCellHeight;
    
    NSInteger TextCellHeight;
    
    NSArray *colorArr;
    
    NSMutableDictionary *colorDic;
}

@property (nonatomic,strong) NSDictionary *brandDic;

@property (weak, nonatomic) IBOutlet UITextField *brandTextField;

@property (weak, nonatomic) IBOutlet UITableViewCell *NumberCell;

@property (nonatomic,strong) NSMutableArray *numberArr;

@property (weak, nonatomic) IBOutlet UITableViewCell *TextCell;

@property (nonatomic,strong) NSMutableArray *textArr;


@property (nonatomic,strong) NSMutableArray *BQArr;

@property (weak, nonatomic) IBOutlet UITableViewCell *BQCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *KHCell;

@property (weak, nonatomic) IBOutlet UICollectionView *storageCollection;
@property (nonatomic,strong) NSMutableArray *imageArr;
@property (nonatomic,strong) NSDictionary *typeDic;
@property (nonatomic,strong) NSMutableArray *imageStrArr;



@property (weak, nonatomic) IBOutlet UITextField *JSRTextField;
@property (nonatomic,strong) NSDictionary *JSRDic;

@end

@implementation StorageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    colorArr = @[@"#404CCF",@"#2B2D46",@"#595E93",@"#8087D6",@"#5665FF",@"#B8BDF0",@"#1A26A2",@"#989DCB",@"#0918B2",@"#A2AAFF"];
    colorDic = [NSMutableDictionary dictionary];
    _BQArr = [NSMutableArray array];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    BQCellHeight = 65;
    
    NumberCellHeight = 44;
    TextCellHeight = 92;

    _numberArr = [NSMutableArray array];
    _textArr = [NSMutableArray array];
    
    idStr = @"";
    _SPSLLabel.text = @"1";
    _BZTextView.delegate = self;
    _SPMCTextField.delegate = self;
    _DJJJTextField.delegate = self;
    
    _ZJJTextField.delegate = self;
    _SJTextField.delegate = self;
    _RKSJTextField.delegate = self;
    _SPSLLabel.delegate = self;
    _ZJJTextField.userInteractionEnabled = NO;
    _ZJJButton.userInteractionEnabled = NO;
    _DJJJButton.userInteractionEnabled = NO;
    _JSRTextField.userInteractionEnabled = NO;
    _SPLLLabel.userInteractionEnabled = NO;
    _RKSJTextField.userInteractionEnabled = NO;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    _JSRTextField.placeholder = SYGData[@"user_name"];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BrandChoiceNotification:) name:@"BrandChoiceNotification" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tureAction:) name:@"SupplierTureNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectTypeAction:) name:@"SelectTypeNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HideViewAction) name:@"HideViewAction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SupplierBackAction) name:@"SupplierBackNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PushHideViewAction) name:@"PushHideViewAction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotifacationTypeSelection) name:@"NSNotifacationTypeSelection" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SNEditAction:) name:@"SNEditAction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AddSticksNotification:) name:@"AddSticksNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LabelClassificationNotification:) name:@"LabelClassificationNotification" object:nil];

    
    _imageArr = [NSMutableArray array];
    _imageStrArr = [NSMutableArray array];
    
    for (int i = 0; i < 9; i++) {
        
        [_imageStrArr addObject:@""];
        
    }
    
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
          
            _SPBHLabel.text = [NSString stringWithFormat:@"商品编号:%@",_codeDic[@"goods_sn"]];
            good_id = _codeDic[@"id"];
            
            
        }else{
            
            
            //商品编号数据
            [self SPBHData];
            _KHDic =  @{@"id":@"1",@"name":@"客户1",@"mobile":@""};

            idStr = @"1";

        }
    }
    
    //抵价品
    if ([_isType isEqualToString:@"1"]) {
        self.navigationItem.title = @"抵价品入库";

        NSLog(@"%@",_KHDic);
      
        if (_KHDic[@"mobile"]) {
//            _suppleLabel.text = [NSString stringWithFormat:@"供货商: %@ %@",_KHDic[@"name"],_KHDic[@"mobile"]];
            _SPLLLabel.text = [NSString stringWithFormat:@"%@ %@",_KHDic[@"name"],_KHDic[@"mobile"]];
  
        }else{
//            _suppleLabel.text = [NSString stringWithFormat:@"供货商: %@",_KHDic[@"name"]];
            
            _SPLLLabel.text = [NSString stringWithFormat:@"%@",_KHDic[@"name"]];

        }
        
        idStr = _KHDic[@"id"];
        _KHCell.userInteractionEnabled = NO;

    }else{
    
    for (int i = 0; i<1; i++) {
        self.navigationItem.title = @"回收商品入库";

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*kScreenWidth/2, kScreenHeight-64-50, kScreenWidth, 50);
        button.backgroundColor = [RGBColor colorWithHexString:@"#787fc6"];
        if (i == 0) {
            [button setTitle:@"完成" forState:UIControlStateNormal];
        }else{
            [button setTitle:@"继续入库" forState:UIControlStateNormal];
        }
        button.tag = 100+i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    }
    [_storageCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"StorageCollectionViewCell"];
    
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

    _RKSJTextField.text = dateString;
    
    //隐藏键盘
    UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleAction)];;
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    singleRecognizer.cancelsTouchesInView = NO;

    //给self.view添加一个手势监测；
    
    [self.tableView addGestureRecognizer:singleRecognizer];

    if (_isEdit) {
        
        self.navigationItem.title = @"编辑回收商品";

        _JSRTextField.text = _editDic[@"add_user_name"];
        _JSRDic = @{@"id":_editDic[@"add_user"]};
        
        _SPSLLabel.userInteractionEnabled = NO;
        _DJJJTextField.userInteractionEnabled = NO;
        _ZJJTextField.userInteractionEnabled = NO;
        
        _DJJJButton.userInteractionEnabled = YES;
        _ZJJButton.userInteractionEnabled = YES;
        
        good_id = _editDic[@"id"];
        NSDictionary *dic = @{@"id":_editDic[@"category_id"]};
        
        _typeDic = dic;
        
        NSLog(@"%@",_editDic);
        
        if (_editDic[@"brand_id"]) {
            
            if ([_editDic[@"brand_id"] integerValue] != 0) {
                
                NSDictionary *dic1 = @{@"id":_editDic[@"brand_id"],@"brand_name":_editDic[@"brand_name"]};
                
                _brandDic = dic1;

                _brandTextField.text = _editDic[@"brand_name"];
            }

        }
        
        _selectLabel.text = _editDic[@"category_name"];
        
        _selectImageV.image = [UIImage imageNamed:_editDic[@"category_name"]];
        
        if (!_selectImageV.image) {
            _selectImageV.image = [UIImage imageNamed:@"其他"];
        }
        
        
        idStr = _editDic[@"customer_id"];
        if (!_editDic[@"customer_mobile"]) {
//            _suppleLabel.text = [NSString stringWithFormat:@"供货商:%@",_editDic[@"customer_name"]];

            _SPLLLabel.text = [NSString stringWithFormat:@"%@",_editDic[@"customer_name"]];
        }else{
//            _suppleLabel.text = [NSString stringWithFormat:@"供货商:%@ %@",_editDic[@"customer_name"],_editDic[@"customer_mobile"]];
            _SPLLLabel.text = [NSString stringWithFormat:@"%@ %@",_editDic[@"customer_name"],_editDic[@"customer_mobile"]];
        
        }
        _SPMCTextField.text = _editDic[@"goods_name"];
        
        _SPSLLabel.text = _editDic[@"number"];
        
        _friendTextView.text = _editDic[@"friend_describe"];

        _SJTextField.text = [NSString stringWithFormat:@"%ld",[_editDic[@"price"] integerValue]];
        if ([_editDic[@"is_new"] isEqualToString:@"1"]) {
            
            _QXESLabel.text = @"全新";
            
        }else{
            
            _QXESLabel.text = @"二手";
        }
        
        _SPBHLabel.text =[NSString stringWithFormat:@"商品编号:%@", _editDic[@"goods_sn"]];
        
        if ([[defaults objectForKey:[NSString stringWithFormat:@"%@switch",SYGData[@"id"]]] isEqualToString:@"1"]) {
            
            _DJJJTextField.text =[NSString stringWithFormat:@"%ld",[_editDic[@"cost"] integerValue]];
            _DJJJTextField.userInteractionEnabled = YES;
            _DJJJButton.userInteractionEnabled = NO;

        }else{
            
            _DJJJTextField.text =@"*****";
        }

        for (NSDictionary *dic in _editDic[@"attribute"]) {
            
            if ([dic[@"type"] isEqualToString:@"select"]) {
                
                [_BQArr addObject:dic];
            }
        }
        
        
        [self BQUpData];

        
        _BZTextView.text = _editDic[@"remark"];
        
        NSTimeInterval time=[_editDic[@"add_time"] doubleValue];//因为时差问题要加8小时 == 28800 sec
        NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
        _RKSJTextField.text = currentDateStr;
        

        if ([_BZTextView.text isEqualToString:@""]) {
            _BZLabel.hidden = NO;
        }else{
            _BZLabel.hidden = YES;

        }
        
        NSArray *imageArr = _editDic[@"photo_list"];
        
        for (int i = 0 ; i < imageArr.count; i++) {
            
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imageArr[i][@"image_url"]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                NSLog(@"");
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                
                if (error) {
                    
                }
                if (image) {
                    
                    
                    [_imageArr addObject:image];
                    
                    if ([BaseUrl isEqualToString:@"http://syg.hpdengshi.com/index.php?s=/Api/"]) {
                        
                        [_imageStrArr replaceObjectAtIndex:i withObject:[imageArr[i][@"image_url"] substringFromIndex:23]];

                    }else{
                        
                        [_imageStrArr replaceObjectAtIndex:i withObject:[imageArr[i][@"image_url"] substringFromIndex:24]];
                    }
                }
                
                NSLog(@"%@",_imageStrArr);

                [_storageCollection reloadData];
            }];
            
        }
    }
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
    _RKSJTextField.text = dateStr;
    
}
- (void)cancelAction{
    _birthView.hidden = YES;
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
                
                for (NSDictionary *dic in _editDic[@"attribute"]) {
                    
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
                label = [[UILabel alloc]initWithFrame:CGRectMake(10, 11+44*i +92, kScreenWidth  -20, 21)];
            }
            
            label.textColor = [RGBColor colorWithHexString:@"#333333"];
            label.font = [UIFont systemFontOfSize:14];
            label.text = [NSString stringWithFormat:@"%@:",_textArr[i][@"attribute_name"]];
            label.tag = 700+i;
            [_TextCell.contentView addSubview:label];
            
            UITextView *textView = [_TextCell.contentView viewWithTag:800+i];
            
            if (!textView) {
                textView = [[UITextView alloc]initWithFrame:CGRectMake(10, label.bottom, kScreenWidth - 20, 50)];
            }
            textView.delegate = self;
            
            textView.font = [UIFont systemFontOfSize:16];
            textView.tag = 800+i;
            [_TextCell.contentView addSubview:textView];
            
            if (_editDic) {
                
                for (NSDictionary *dic in _editDic[@"attribute"]) {
                    if ([dic[@"type"] isEqualToString:@"text"]) {

                    if ([dic[@"id"] isEqualToString:_textArr[i][@"id"]]) {
                        
                        textView.text = dic[@"attribute_value"];
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



//删除按钮
- (void)delegateAction{
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否确定删除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    
    [alertV show];
    
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

//商品编号数据
- (void)SPBHData{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    [params setObject:@"HS" forKey:@"type"];
    
    [DataSeviece requestUrl:create_goods_snhtml params:params success:^(id result) {
        NSLog(@"%@",result[@"result"]);
        
        
        _SPBHLabel.text = [NSString stringWithFormat:@"商品编号:%@",result[@"result"][@"data"][@"goods_sn"]];
        good_id = result[@"result"][@"data"][@"id"];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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

    [self.tableView reloadData];

}

//品牌通知
- (void)BrandChoiceNotification:(NSNotification*)noti{
    
    
    _brandTextField.text = [noti object][@"brands_name"];
    
    _brandDic = [noti object];
    
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

//隐藏视图
- (void)bgButtonAction{

    bgView.hidden = YES;
//    monetEditV.hidden = YES;
//    [monetEditV.monetTextField resignFirstResponder];
//    [monetEditV.removeTextField resignFirstResponder];
//
//    storageV.hidden = YES;
    typeSelectionV.hidden = YES;
//    supplierV.hidden = YES;
    storageTureV.hidden = YES;
    QXESView.hidden = YES;
    

}


- (IBAction)addImageButton:(id)sender {
    
    // 创建控制器
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    // 默认显示相册里面的内容SavePhotos
    // 最多能选9张图片
    pickerVc.topShowPhotoPicker = YES;
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.delegate = self;
    [pickerVc showPickerVc:self];
    /**
     *
     传值可以用代理，或者用block来接收，以下是block的传值
     __weak typeof(self) weakSelf = self;
     pickerVc.callBack = ^(NSArray *assets){
     weakSelf.assets = assets;
     [weakSelf.tableView reloadData];
     };
     */
    
}

#pragma mark - 相册回调
- (void)pickerViewControllerDoneAsstes:(NSArray *)assets{
    
    if (_imageArr.count + assets.count > 9) {
        
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alertV.message = @"图片不能超过九张";
        [alertV show];
        return;
    }
    
    NSMutableArray *imageArr1 = [NSMutableArray array];
    NSInteger item = _imageArr.count;

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
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
        
        NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
        
        [params1 setObject:SYGData[@"id"] forKey:@"uid"];
        
        [DataSeviece requestUrl:get_qiniu_tokenhtml params:params1 success:^(id result) {
            
            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            
            [params setObject:result[@"result"][@"data"][@"qiniu_token"] forKey:@"token"];
            
            [params setObject:SYGData[@"shop_id"] forKey:@"x:shop_id"];

//            
//            [params setObject:@{@"uid":SYGData[@"id"],@"sort":[NSString stringWithFormat:@"%ld",item+i]} forKey:@"data"];
            
            [manager POST:@"http://up-z2.qiniu.com" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                
                NSData *imgData = UIImageJPEGRepresentation(imageArr1[i], 1);
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // 设置时间格式
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
                
                
                [formData appendPartWithFileData:imgData name:@"file" fileName:fileName mimeType:@"image/png"];
                
            } success:^(NSURLSessionDataTask *task, id responseObject) {
                
                NSLog(@"%@ %d",responseObject,i);
                
                [_imageStrArr replaceObjectAtIndex:item + i withObject:responseObject[@"result"][@"data"][@"file_name"]];
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
                NSLog(@"%@",error);
                
            }];


        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
            
        }];

    }
    
    [_storageCollection reloadData];

}

//点击完成和继续入库
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
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];

    [params setObject:[_SPBHLabel.text substringFromIndex:5] forKey:@"goods_sn"];

    if (_typeDic) {
        [params setObject:_typeDic[@"id"] forKey:@"category_id"];
    }else{
        [params setObject:@"4" forKey:@"category_id"];
    }
    
    if (_brandDic) {
        
        [params setObject:_brandDic[@"id"] forKey:@"brand_id"];
        
        [params setObject:_brandDic[@"brands_name"] forKey:@"brand_name"];
    }
    [params setObject:good_id forKey:@"id"];
    [params setObject:idStr forKey:@"customer_id"];
    
    [params setObject:_SPMCTextField.text forKey:@"goods_name"];
    
    [params setObject:_DJJJTextField.text forKey:@"cost"];
    
    [params setObject:_SJTextField.text forKey:@"price"];
    
    [params setObject:_SPSLLabel.text forKey:@"number"];
    
    [params setObject:_friendTextView.text forKey:@"friend_describe"];

    
    [params setObject:@"" forKey:@"sort"];
    
    if ([_QXESLabel.text isEqualToString:@"全新"]) {
        [params setObject:@"1" forKey:@"is_new"];
    }else{
        [params setObject:@"2" forKey:@"is_new"];
    }
    
    [params setObject:@"HS" forKey:@"type"];
    
    [params setObject:_BZTextView.text forKey:@"remark"];
    
    [params setObject:_RKSJTextField.text forKey:@"add_time"];
    
    
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
    }else{
    
        [params setObject:@"" forKey:@"photo"];
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
    
    NSLog(@"%@",params);

    if (_isEdit) {
        
        if ([_DJJJTextField.text isEqualToString:@"*****"]) {
            [params setObject:_editDic[@"cost"] forKey:@"cost"];
        }
        [params setObject:_JSRDic[@"id"] forKey:@"add_user"];
        [params setObject:_editDic[@"id"] forKey:@"id"];
        [params setObject:_editDic[@"is_pause"] forKey:@"is_pause"];

        NSMutableDictionary *paymentDic = [NSMutableDictionary dictionary];
      
        NSArray *paymentArr = _editDic[@"payment"];
        if (paymentArr) {
        
        for (int i = 0; i < paymentArr.count; i++) {
            
            [paymentDic setObject:paymentArr[i] forKey:[NSString stringWithFormat:@"%d",i]];
        }

        }

        [params setObject:paymentDic forKey:@"payment"];
        

        [DataSeviece requestUrl:edit_goodshtm params:params success:^(id result) {
            
            NSLog(@"%@ %@",result[@"result"][@"msg"],result);
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
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil ,nil];
                alert.message = @"编辑失败";
                [alert show];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];

    }else{

        dataDic = [params copy];
        PaymentTwoViewController *paymentCollectionVC = [[PaymentTwoViewController alloc]init];
        
        paymentCollectionVC.HSRKDic = params;
        paymentCollectionVC.KHDic = _KHDic;
        paymentCollectionVC.JSRDic = _JSRDic;
        [self.navigationController pushViewController:paymentCollectionVC animated:YES];

    }
    
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
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackNotification" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _imageArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StorageCollectionViewCell" forIndexPath:indexPath];
    
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
    
    [_storageCollection reloadData];
    
    
    for (int i = 0; i < _imageArr.count+2; i++) {
        
        if (_imageArr.count != index) {
            
            if (i == 9) {
                
                [_imageStrArr replaceObjectAtIndex:8 withObject:@""];
                
            }else if (i > index) {
                
                [_imageStrArr replaceObjectAtIndex:i - 1 withObject:_imageStrArr[i]];
            }
        }
    }

    
    NSLog(@"%@",_imageStrArr);
    
}

#pragma mark -UITableViewDataSource||UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 5) {
        
        bgView.hidden = NO;
        typeSelectionV.hidden = NO;
        
    }else if (indexPath.row == 6){
      
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
        

      
    }else if (indexPath.row == 7){
    
        QXESView.hidden = NO;
        bgView.hidden = NO;
    }else if (indexPath.row == 10){

        CustomerInformationViewController *customerInformationVC = [[CustomerInformationViewController alloc]init];
        
        [self.navigationController pushViewController:customerInformationVC animated:YES];
        
    }else if (indexPath.row == 11){
        
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


- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == _DJJJTextField) {
        
        if (![_SPSLLabel.text isEqualToString:@""]&&![_DJJJTextField.text isEqualToString:@""]) {
            _ZJJTextField.text  = [NSString stringWithFormat:@"%.0lf",[_SPSLLabel.text floatValue]*[_DJJJTextField.text floatValue]];
            
        }
    }
    
    if (textField == _ZJJTextField) {
        
        if (![_ZJJTextField.text isEqualToString:@""]&&![_SPSLLabel.text isEqualToString:@""]) {
            
            _DJJJTextField.text  = [NSString stringWithFormat:@"%.0lf",[_ZJJTextField.text floatValue]/[_SPSLLabel.text floatValue]];
            
        }
        
    }
    
    if (textField == _SPSLLabel) {
        
        if (![_SPSLLabel.text isEqualToString:@""]&&![_DJJJTextField.text isEqualToString:@""]) {
            
            _ZJJTextField.text  = [NSString stringWithFormat:@"%.0lf",[_SPSLLabel.text floatValue]*[_DJJJTextField.text floatValue]];
            
        }

    }
    
}


- (void)singleAction{
    
    [_BZTextView resignFirstResponder];
    [_SPMCTextField resignFirstResponder];
    [_DJJJTextField resignFirstResponder];
    [_ZJJTextField resignFirstResponder];
    [_SJTextField resignFirstResponder];
    [_RKSJTextField resignFirstResponder];
    [_SPSLLabel resignFirstResponder];
    
    for (int i = 0; i < _numberArr.count; i++) {
        UITextField *textField = [_NumberCell.contentView viewWithTag:600+i];
        
        [textField resignFirstResponder];
    }
    
    for (int i = 0; i < _textArr.count; i++) {
        UITextView *textField = [_TextCell.contentView viewWithTag:800+i];
        
        [textField resignFirstResponder];
    }

}

- (void)HideViewAction{
    
    bgView.hidden = YES;
    
    bgView = nil;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"StockNotification" object:nil];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)SupplierBackAction{
    
    bgView.hidden = YES;
    bgView = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"StockAction" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackNotification" object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


//移除通知
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
//接收通知
- (void)tureAction:(NSNotification*)noti{

    
    NSDictionary *dic = [noti object];
    
    _SPLLLabel.text = [NSString stringWithFormat:@"%@ %@ %@",dic[@"name"],dic[@"mobile"],dic[@"wechat"]];
    
    idStr = dic[@"id"];
    
    _KHDic = dic;

}

- (void)PushHideViewAction{
    
    bgView.hidden = YES;
    
//    storageV.hidden = YES;
    
    StockPriceViewController *stockPriceVC = [[StockPriceViewController alloc]init];
    stockPriceVC.type = @"1";
    stockPriceVC.goods_id = good_id;
    [self.navigationController pushViewController:stockPriceVC animated:YES];
    
}


//- (void)canacelAction{
//    
//    supplierV.hidden = YES;
//    bgView.hidden = YES;
//
//}
- (void)viewWillDisappear:(BOOL)animated{
    
    [ super viewWillDisappear:animated];
    
    bgView.hidden = YES;    
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

//    storageV.bgView.hidden = YES;
    
    //改变导航栏标题的字体颜色和大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏背景.png"] forBarMetrics:UIBarMetricsDefault];
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        if ([_isType isEqualToString:@"1"]) {
            return 44;
        }
        return 0;
    }else if (indexPath.row == 1){
        return 44;

    }else if (indexPath.row == 2){
        return 10;

    }else if (indexPath.row == 3){
        return 94;

    }else if (indexPath.row == 4){
        return 10;

    }else if (indexPath.row == 5){
        return 44;

    }else if (indexPath.row == 6){
        
        return 44;
        
    }else if (indexPath.row == 7){
        
        return 44;

    }else if (indexPath.row == 8){
        return 44;

    }else if (indexPath.row == 9){
        return BQCellHeight;
    }else if (indexPath.row == 10){
        return 44;

    }else if (indexPath.row == 11){
        return 44;

    }else if (indexPath.row == 12){
        return 10;

    }else if (indexPath.row == 13){
        return 44;

    }else if (indexPath.row == 14){
        return 44;

    }else if (indexPath.row == 15){
        return 44;

    }else if (indexPath.row == 16){
        return NumberCellHeight;

    }else if (indexPath.row == 17){
        return 10;

    }else if (indexPath.row == 18){
        return TextCellHeight;
    }else if (indexPath.row == 19){
        return 10;
        
    }else if (indexPath.row == 20){
        return 92;
    }else if (indexPath.row == 21){
        if ([_isType isEqualToString:@"1"]) {
            return 0;
        }
        return 92;
    }else if (indexPath.row == 22){
    
        if ([_isType isEqualToString:@"1"]) {
            return 50;
        }
        return 0;
    }
    
    return 0;
    
}

- (IBAction)KWDKAction:(id)sender {
    
    StockPriceViewController *stockPriceVC = [[StockPriceViewController alloc]init];
    
    stockPriceVC.KHId = _KHDic[@"id"];
    stockPriceVC.type = @"JM";
    stockPriceVC.goods_id = _goods_id;
    [self.navigationController pushViewController:stockPriceVC animated:YES];
    
}


- (IBAction)KJQDAction:(id)sender {
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    
    if ([_SPMCTextField.text isEqualToString:@""]&&_imageArr.count == 0) {
        alertV.message = @"商品名称和图片不能同时为空";
        [alertV show];
        return;
        
    }
    if ([_SPSLLabel.text isEqualToString:@""]) {
        alertV.message = @"请输入商品数量";
        [alertV show];
        return;
        
    }
    
    
    if ([_DJTextField.text isEqualToString:@""]) {
        alertV.message = @"请输入抵价";
        [alertV show];
        return;
        
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    if (_typeDic) {
        
        [params setObject:_typeDic[@"id"] forKey:@"category_id"];
        
    }else{
        [params setObject:@"4" forKey:@"category_id"];
    }
    
    [params setObject:idStr forKey:@"customer_id"];
    
    
    [params setObject:_SPMCTextField.text forKey:@"goods_name"];
    
    
    [params setObject:_SJTextField.text forKey:@"price"];
    
    
    [params setObject:_SPSLLabel.text forKey:@"number"];
    
    [params setObject:@"" forKey:@"sort"];
    
    if ([_QXESLabel.text isEqualToString:@"全新"]) {
        [params setObject:@"1" forKey:@"is_new"];
    }else{
        [params setObject:@"2" forKey:@"is_new"];
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
    
    
    [params setObject:_BZTextView.text forKey:@"remark"];
    
    
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

    [params setObject:_DJTextField.text forKey:@"DJ"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowNotification" object:params];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)NSNotifacationTypeSelection{
    
    [self loadData];
    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertV1 == alertView) {
        
        UITextField *tf = [alertView textFieldAtIndex:0];
        
        [MD5CommonDigest MD5:tf.text success:^(id result) {
            
            NSLog(@"%@",result);
            
            if ([result isEqualToString:@"1"]) {
                _DJJJTextField.text =[NSString stringWithFormat:@"%ld",[_editDic[@"cost"] integerValue]];
                
                //            _ZJJTextField.text = [NSString stringWithFormat:@"%ld",[_editDic[@"cost"] integerValue]*[_editDic[@"number"] integerValue]];
                _DJJJTextField.userInteractionEnabled = YES;
                _DJJJButton.userInteractionEnabled = NO;
                _ZJJButton.userInteractionEnabled = NO;
            }else{
                    
                    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    
                    [alertV show];
                    
                }
            
            
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
        }];
        
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        
//        NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
//        
//        UITextField *tf = [alertView textFieldAtIndex:0];
//        
//        
//        if ([SYGData[@"password"] isEqualToString:tf.text]) {
//            
//            _DJJJTextField.text =[NSString stringWithFormat:@"%ld",[_editDic[@"cost"] integerValue]];
//            
////            _ZJJTextField.text = [NSString stringWithFormat:@"%ld",[_editDic[@"cost"] integerValue]*[_editDic[@"number"] integerValue]];
//            _DJJJTextField.userInteractionEnabled = YES;
//            _DJJJButton.userInteractionEnabled = NO;
//            _ZJJButton.userInteractionEnabled = NO;
//            
//
//        }else{
//            
//            UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            
//            [alertV show];
//            
//        }
    }else{
    
    if (buttonIndex == 1) {
        
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    [params setObject:_editDic[@"id"] forKey:@"id"];
    
    [DataSeviece requestUrl:delete_goodshtml params:params success:^(id result) {
        NSLog(@"%@",result);
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            alertV.message = @"删除成功";
            
            [alertV show];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"StockNotification" object:nil];
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
}

- (IBAction)editSNAction:(id)sender {
    
    EditSNViewController *editSNVC = [[EditSNViewController alloc]init];
    editSNVC.snStr = [_SPBHLabel.text substringFromIndex:5];
    [self.navigationController pushViewController:editSNVC animated:YES];
    
}

- (void)SNEditAction:(NSNotification*)noti{
    
    _SPBHLabel.text = [NSString stringWithFormat:@"商品编号:%@",[noti object]];
    
}

- (IBAction)JJShowAction:(id)sender {
    
    if (![_DJJJTextField.text isEqualToString:[NSString stringWithFormat:@"%ld",[_editDic[@"cost"] integerValue]]]) {
        alertV1 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        alertV1.alertViewStyle = UIAlertViewStyleSecureTextInput;
        
        [alertV1 show];
    }

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
