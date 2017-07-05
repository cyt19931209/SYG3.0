//
//  ReleaseCompleteViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/10/28.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "ReleaseCompleteViewController.h"
#import "OneButtonPublishingViewController.h"


@interface ReleaseCompleteViewController ()

@property (nonatomic,strong) NSMutableDictionary *errorDic;

@end

@implementation ReleaseCompleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _errorDic = [NSMutableDictionary dictionary];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"Back Chevron@2x"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;

    [self createUI];

}
//加载视图
- (void)createUI{

    UIImageView *topImageV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 35, 50, 70, 70)];
    
    topImageV.image = [UIImage imageNamed:@"done@2x"];
    
    [self.view addSubview:topImageV];
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2 -112, topImageV.bottom+30, 224, 50)];
    
    textLabel.textAlignment = NSTextAlignmentCenter;
    
    textLabel.text = @"商品信息已提交至您选择的平台请等待平台审核";
    
    textLabel.numberOfLines = 0;
    
    textLabel.font = [UIFont systemFontOfSize:16];
    
    textLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
    
    [self.view addSubview:textLabel];
    
    UILabel *TJLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, textLabel.bottom +50, kScreenWidth, 20)];
    TJLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
    TJLabel.font = [UIFont systemFontOfSize:16];
    TJLabel.text = @"提交结果";
    TJLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:TJLabel];
    
    BOOL isError = false;
    
    NSString *errorStr = @"";
    
    NSMutableArray *itemArr = [NSMutableArray array];
    
    for (int i = 0; i < _arr.count; i++) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i *kScreenWidth/_arr.count, TJLabel.bottom + 20, kScreenWidth/_arr.count, 34)];
        
        [self.view addSubview:view];
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(view.width/2 - 34, 0, 34, 34)];
        
        imageV.image = [UIImage imageNamed:_arr[i][@"img"]];
        
        [view addSubview:imageV];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imageV.right +10, 7, 50, 20)];
        
        label.textColor = [RGBColor colorWithHexString:@"#666666"];
        
        label.font = [UIFont systemFontOfSize:16];
        
        if ([_arr[i][@"isSuccess"] isEqualToString:@"1"]) {
            
            label.text = @"成功";
            
        }else{
            
            label.text = @"失败";
            isError = YES;
            if ([_arr[i][@"img"] isEqualToString:@"panghu@2x"]) {
                errorStr = [NSString stringWithFormat:@"%@ 胖虎:%@",errorStr,_arr[i][@"msg"]];
                [itemArr addObject:@"1"];
            }else if ([_arr[i][@"img"] isEqualToString:@"aiding@2x"]){
                errorStr = [NSString stringWithFormat:@"%@ 爱丁猫:%@",errorStr,_arr[i][@"msg"]];
                [itemArr addObject:@"2"];
            }else if ([_arr[i][@"img"] isEqualToString:@"sina@2x"]){
                errorStr = [NSString stringWithFormat:@"%@ 微博:%@",errorStr,_arr[i][@"msg"]];
                [itemArr addObject:@"3"];
            }
            
        }
        
        [view addSubview:label];
        
    }
    
    [_errorDic setObject:errorStr forKey:@"error"];
    [_errorDic setObject:itemArr forKey:@"item"];
    
    if (isError) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(kScreenWidth/2 - 145, TJLabel.bottom + 90, 290, 48);
        
        button.backgroundColor = [RGBColor colorWithHexString:@"#787fc6"];
        
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.titleLabel.font = [UIFont systemFontOfSize:20];
        [button setTitle:@"失败商品重新发送" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(againPush) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
    }
    
    
}
//重新发布
- (void)againPush{
    
    OneButtonPublishingViewController *OneButtonPublishingVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"OneButtonPublishingViewController"];
    
    OneButtonPublishingVC.isAgain = YES;
    OneButtonPublishingVC.againDic = _errorDic;
    
    OneButtonPublishingVC.oldDic = _dataDic;
    [self.navigationController pushViewController:OneButtonPublishingVC animated:YES];
    
}


- (void)leftBtnAction{
    
    
    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
    
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"发布完成";
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#787fc6"]}];
    
}



@end
