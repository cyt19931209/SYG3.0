//
//  EditBooksViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/10/19.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "EditBooksViewController.h"
#import "ZLPhoto.h"
#import "AFNetworking.h"
#import "StorageViewController.h"
#import "ZFFSView.h"
#import "SticksViewController.h"
#import "StockPriceViewController.h"


@interface EditBooksViewController ()<ZLPhotoPickerViewControllerDelegate,UITextFieldDelegate,UIAlertViewDelegate>{

    UIView *bgView;
    
    ZFFSView *zffsView;
    
    UITableView *zffsTableView;
    
    NSString *add_user;
    
    NSString *account_id;
    
    NSDictionary *_notiDic;
}

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) NSMutableArray *zffsDataArr;


@property (weak, nonatomic) IBOutlet UICollectionView *storageCollection;
@property (nonatomic,strong) NSMutableArray *imageArr;
@property (nonatomic,strong) NSMutableArray *imageStrArr;

@property (weak, nonatomic) IBOutlet UITextField *SPMCTextField;
@property (weak, nonatomic) IBOutlet UITextField *CJJETextField;
@property (weak, nonatomic) IBOutlet UITextField *FKZHTextField;
@property (weak, nonatomic) IBOutlet UITextField *FKJSRTextField;
@property (weak, nonatomic) IBOutlet UILabel *FKZHLabel;
@property (weak, nonatomic) IBOutlet UILabel *FKJSRLabel;

@end

@implementation EditBooksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageArr = [NSMutableArray array];
    _imageStrArr = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AddSticksNotification:) name:@"AddSticksNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShowAction:) name:@"ShowNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ZFFSNotification:) name:@"ZFFSNotification" object:nil];
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"返回（20x38）.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 35, 30);
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:self action:@selector(delegateAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
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
    

    
    //隐藏键盘
    UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleAction)];;
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    singleRecognizer.cancelsTouchesInView = NO;
    
    //给self.view添加一个手势监测；
    
    [self.tableView addGestureRecognizer:singleRecognizer];

    [_storageCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"StorageCollectionViewCell"];
    
    NSArray *imageArr = _dataDic[@"imurl"];
    
    for (int i = 0 ; i < imageArr.count; i++) {

        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgUrl,imageArr[i]]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            NSLog(@"");
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            if (error) {
                
            }
            if (image) {
                [_imageArr addObject:image];
                
                [_imageStrArr addObject:imageArr[i]];
                
            }
            [_storageCollection reloadData];
    
        }];
    }
    
    _SPMCTextField.text = _dataDic[@"goods_name"];
    
    _CJJETextField.text = _dataDic[@"amount"];
    
    _FKZHTextField.text = _dataDic[@"account"];
    
    _FKJSRTextField.text = _dataDic[@"operation_user"];
    
    add_user = _dataDic[@"add_user"];
    account_id = _dataDic[@"account_id"];
    
    if ([_dataDic[@"type"] isEqualToString:@"1"]) {
        _FKZHLabel.text = @"付款账号:";
        _FKJSRLabel.text = @"付款经手人:";
    }else{
        _FKZHLabel.text = @"收款账号:";
        _FKJSRLabel.text = @"收款经手人:";
    }
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
}

- (void)bgButtonAction{
    
    bgView.hidden = YES;
    zffsView.hidden = YES;
    
}

- (void)singleAction{

    [_SPMCTextField resignFirstResponder];
    
    [_CJJETextField resignFirstResponder];

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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 3) {
        return 44;
    }else if (indexPath.row == 4){
        return 44;
    }else if (indexPath.row == 5){
        return 44;
    }

    return 0;
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
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    
    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
    
    [params1 setObject:SYGData[@"id"] forKey:@"uid"];
    
    
    [DataSeviece requestUrl:get_qiniu_tokenhtml params:params1 success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);

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
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            
            [params setObject:result[@"result"][@"data"][@"qiniu_token"] forKey:@"token"];
            
            [params setObject:SYGData[@"shop_id"] forKey:@"x:shop_id"];
            
            [manager POST:@"http://up-z2.qiniu.com" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                
                NSData *imgData = UIImageJPEGRepresentation(imageArr1[i], .5);
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // 设置时间格式
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
                [formData appendPartWithFileData:imgData name:@"upfile" fileName:fileName mimeType:@"image/png"];
                
            } success:^(NSURLSessionDataTask *task, id responseObject) {
                
                NSLog(@"%@",responseObject);
                [_imageStrArr addObject:responseObject[@"result"][@"data"][@"file_name"]];
                NSLog(@"%@",_imageStrArr);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@",error);
            }];
        }
        
        [_storageCollection reloadData];

        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    

    
}


//保存按钮
- (void)delegateAction{

    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:_dataDic[@"id"] forKey:@"pay_id"];
    
    [params setObject:_CJJETextField.text forKey:@"amount"];
    
    [params setObject:account_id forKey:@"account_id"];
    
    [params setObject:add_user forKey:@"add_user"];
    
    if ([account_id isEqualToString:@"2"]) {

        if (_notiDic) {
            
        if (_notiDic[@"id"]) {
            [params setObject:_notiDic[@"number"] forKey:@"number"];
            [params setObject:_notiDic[@"id"] forKey:@"goods_id"];
        }else{
            [params setObject:_notiDic forKey:@"goods"];
        }
        }else{
        
            [params removeObjectForKey:@"account_id"];
        }
        
    }
    [DataSeviece requestUrl:edit_pay_loghtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            alertV.message = @"保存成功";
            [alertV show];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
        
            alertV.message = result[@"result"][@"msg"];
            [alertV show];
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

}

- (void)leftBtnAction{

    [self.navigationController popViewControllerAnimated:YES];


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
    
    [_imageStrArr removeObjectAtIndex:index];
    
    [_storageCollection reloadData];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.row == 4) {
        
    
        bgView.hidden = NO;
        
        zffsView = [[ZFFSView alloc]initWithFrame:CGRectMake(10, 43, kScreenWidth -20, kScreenHeight - 143)];
        
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
        
        if (_dataDic[@"is_trade"]) {
            
        }else{
            
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
        
        zffsTableView.delegate = zffsView;
        zffsTableView.dataSource = zffsView;
        
        [zffsView addSubview:zffsTableView];
        
        [_zffsDataArr removeAllObjects];
        
        [self zffsLoadData];
        
        if ([_dataDic[@"payment"] isEqualToString:@"5"])  {
            UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改完成后该置换商品不会被删除 请自行处理 是否确定修改" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertV show];
            
            bgView.hidden = YES;
            zffsView.hidden = YES;
            
        }
        
        
    }else if (indexPath.row == 5){
        
        SticksViewController *sticksVC = [[SticksViewController alloc]init];
        
        [self.navigationController pushViewController:sticksVC animated:YES];
        
    
    }
    
    
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
        zffsView.dataArr = [_zffsDataArr copy];
        
        [zffsTableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)KWDKAction{
    
    bgView.hidden = YES;
    
    zffsView.hidden = YES;
    
    if ([_dataDic[@"type"] isEqualToString:@"1"]) {
      
        StockPriceViewController *stockPriceVC = [[StockPriceViewController alloc]init];
        stockPriceVC.type = @"1";
        stockPriceVC.goods_id = @"1";
        [self.navigationController pushViewController:stockPriceVC animated:YES];
        
    }else{
        
        StorageViewController *storageVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"StorageViewController"];
        storageVC.isType = @"1";
        NSDictionary *dic = @{@"phone":@"",@"name":_dataDic[@"customer_name"],@"id":_dataDic[@"customer_id"]};
        storageVC.KHDic = dic;
        storageVC.isJM = YES;
        storageVC.goods_id = @"1";
        
        [self.navigationController pushViewController:storageVC animated:YES];
        
    }
    
    
    
}


- (void)QDAction{
    
    bgView.hidden = YES;
    zffsView.hidden = YES;
    
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
//货物抵款通知
- (void)ShowAction:(NSNotification*)noti{
    
    bgView.hidden = YES;
    zffsView.hidden = YES;
    _notiDic = [noti object];

    _CJJETextField.text = _notiDic[@"DJ"];
    
    account_id = @"2";
    
    _FKZHTextField.text = _notiDic[@"goods_name"];
    
    
}

//经手人返回通知
- (void)AddSticksNotification:(NSNotification*)noti{
    
    
    _FKJSRTextField.text = [noti object][@"user_name"];
    
    add_user = [noti object][@"id"];
    
}
//账号返回通知
- (void)ZFFSNotification:(NSNotification*)noti{

    zffsView.hidden = YES;
    bgView.hidden = YES;
    
    _FKZHTextField.text = [noti object][@"account"];

    account_id = [noti object][@"id"];

}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 1) {
        
        bgView.hidden = NO;
        
        zffsView.hidden = NO;

        
    }

    
}



@end
