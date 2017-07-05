//
//  QRCodeViewController.m
//  RMXJY
//
//  Created by MacBooK on 16/3/4.
//  Copyright © 2016年 MacBooK. All rights reserved.
//

#import "QRCodeViewController.h"
#import "StockDetailsViewController.h"
#import "AppDelegate.h"
#import "MerchandiseViewController.h"
#import "ExpressWebViewController.h"
#import "StorageViewController.h"
#import "ConsignmentViewController.h"
#import "TransactionRecordViewController.h"


@interface QRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>{

    AVCaptureSession * session;//输入输出的中间桥梁

}

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"条形码/二维码";
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"返回（20x38）.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bgopa@2x.png"] forBarMetrics:UIBarMetricsDefault];


    
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //初始化链接对象
    session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [session addInput:input];
    [session addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    //开始捕获
    [session startRunning];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    imageV.image = [UIImage imageNamed:@"扫码背景.png"];
    
    [self.view addSubview:imageV];
    
    output = [[AVCaptureMetadataOutput alloc]init];
    CGSize size = self.view.bounds.size;
    CGRect cropRect = CGRectMake(50, 160, 220, 220);
    CGFloat p1 = size.height/size.width;
    CGFloat p2 = 1920./1080.; //使用了1080p的图像输出
    if (p1 < p2) {
        CGFloat fixHeight = self.view.bounds.size.width * 1920. / 1080.;
        CGFloat fixPadding = (fixHeight - size.height)/2;
        output.rectOfInterest = CGRectMake((cropRect.origin.y + fixPadding)/fixHeight,
                                            cropRect.origin.x/size.width,
                                            cropRect.size.height/fixHeight,
                                            cropRect.size.width/size.width);
    } else {
        CGFloat fixWidth = self.view.bounds.size.height * 1080. / 1920.;
        CGFloat fixPadding = (fixWidth - size.width)/2;
        output.rectOfInterest = CGRectMake(cropRect.origin.y/size.height,
                                            (cropRect.origin.x + fixPadding)/fixWidth,
                                            cropRect.size.height/size.height,
                                            cropRect.size.width/fixWidth);
    }
    
}

//左边返回按钮
- (void)leftBtnAction{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackNotification" object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//- (void)moveScanLayer:(NSTimer *)timer
//{
//    CGRect frame = _scanLayer.frame;
//    if (_boxView.frame.size.height < _scanLayer.frame.origin.y) {
//        frame.origin.y = 0;
//        _scanLayer.frame = frame;
//    }else{
//        frame.origin.y += 5;
//        [UIView animateWithDuration:0.1 animations:^{
//            _scanLayer.frame = frame;
//        }];
//    }
//}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if (metadataObjects.count>0) {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        //输出扫描字符串
        NSLog(@"%@",metadataObject.stringValue);
        [session stopRunning];

//        if (metadataObject.stringValue.length == 6) {

            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            
            [params setObject:SYGData[@"id"] forKey:@"uid"];
        
            [params setObject:metadataObject.stringValue forKey:@"goods_sn"];
            
            [DataSeviece requestUrl:get_goods_by_snhtml params:params success:^(id result) {
                
                NSLog(@"%@",result);
                
                
                if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                    
                    if ([result[@"result"][@"data"][@"type"] isEqualToString:@"2"]) {
                       
                        if ([result[@"result"][@"data"][@"goodsinfo"][@"type"] isEqualToString:@"HS"]){
                            
                            StorageViewController *storageVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"StorageViewController"];
                            
                            storageVC.codeDic = result[@"result"][@"data"][@"goodsinfo"];
                            
                            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
                            
                            [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
                            [self.navigationController pushViewController:storageVC animated:YES];

                        }else if ([result[@"result"][@"data"][@"goodsinfo"][@"type"] isEqualToString:@"JM"]){
                        
                            ConsignmentViewController *consignmentVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"ConsignmentViewController"];
                            consignmentVC.codeDic = result[@"result"][@"data"][@"goodsinfo"];
                            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
                            
                            [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
                            
                            [self.navigationController pushViewController:consignmentVC animated:YES];

                        }else{
                            
                            TransactionRecordViewController *transactionRecordVC = [[UIStoryboard storyboardWithName:@"Share" bundle:nil] instantiateViewControllerWithIdentifier:@"TransactionRecordViewController"];
                            
                            transactionRecordVC.sales_id = result[@"result"][@"data"][@"salesinfo"][@"id"];
                            
                            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
                            
                            [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
                            
                            [self.navigationController pushViewController:transactionRecordVC animated:YES];
                            
                        }
                        
                    }else{
                    
                    
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
                        
                        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
                        
                        [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
                        
                        [self.navigationController pushViewController:transactionRecordVC animated:YES];
                        
                    }

                    }
                }else{
                    
                    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:result[@"result"][@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    
                    [alertV show];
                    
                }
                
            } failure:^(NSError *error) {
                
                NSLog(@"%@",error);
                
            }];

//        }else{
//            ExpressWebViewController *expressWebVC = [[ExpressWebViewController alloc]init];
//            expressWebVC.expressStr = metadataObject.stringValue;
//            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//            [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
//            [self.navigationController pushViewController:expressWebVC animated:YES];
//        }
    }

}

@end
