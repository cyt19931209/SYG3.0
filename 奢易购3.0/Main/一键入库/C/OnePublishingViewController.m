//
//  OnePublishingViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/10/20.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "OnePublishingViewController.h"
#import "BrandChoiceViewController.h"
#import "RepertoryPublishViewController.h"

@interface OnePublishingViewController ()

@end

@implementation OnePublishingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //背景图片
    
    UIImageView *bgImageV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    bgImageV.image = [UIImage imageNamed:@"logobg"];
    
    [self.view addSubview:bgImageV];
    
    //logo
    
    UIImageView *logoImageV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-60, 60, 121, 93)];
    logoImageV.image = [UIImage imageNamed:@"logo222@2x"];
    
    [self.view addSubview:logoImageV];
    
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"返回（20x38）.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //右边Item
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 22, 15);
    [rightBtn setImage:[UIImage imageNamed:@"侧滑按钮（44x30"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 150, kScreenHeight/2 - 115, 300, 230)];
    
    whiteView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:whiteView];
    
    
    NSArray *imageArr = @[@"panghu@2x",@"aiding@2x",@"sina@2x",@"wechat@2x"];
    
    NSArray *laberArr = @[@"胖虎",@"爱丁猫",@"微博",@"朋友圈"];
    
    for (int i = 0; i < 4; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake((i*75)+5.5, 30, 64, 64);
        
        button.backgroundColor = [RGBColor colorWithHexString:@"#FAF8FF"];
        
        [whiteView addSubview:button];
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(7, 7, 50, 50)];
        
        [button addSubview:imageV];
        
        imageV.image = [UIImage imageNamed:imageArr[i]];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((i*75)+5.5, 104, 64, 20)];
        
        label.textColor = [RGBColor colorWithHexString:@"#666666"];
        
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        [whiteView addSubview:label];
        
        label.text = laberArr[i];
    }
    
    UIButton *tureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    tureButton.backgroundColor = [RGBColor colorWithHexString:@"#787fc6"];
    
    tureButton.frame = CGRectMake(10, 152, 280, 48);
    
    [tureButton setTitle:@"一键发布" forState:UIControlStateNormal];
    
    tureButton.titleLabel.font = [UIFont systemFontOfSize:20];
    
    tureButton.layer.cornerRadius = 4;
    
    tureButton.layer.masksToBounds = YES;
    
    [tureButton addTarget:self action:@selector(tureButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [whiteView addSubview:tureButton];
    
}


- (void)tureButtonAction{

    RepertoryPublishViewController *repVC = [[RepertoryPublishViewController alloc]init];
    
    [self.navigationController pushViewController:repVC animated:YES];

    
//    BrandChoiceViewController *BrandChoiceVC = [[BrandChoiceViewController alloc]init];
//    
//    [self.navigationController pushViewController:BrandChoiceVC animated:YES];
//
//
}

//菜单
- (void)rightBtnAction{

    
    
}

//左边返回按钮
- (void)leftBtnAction{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UIImage *image = [UIImage imageNamed:@"bg_clear"];
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
    
}



@end
