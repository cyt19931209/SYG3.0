//
//  ScanViewController.m
//  WXMovie
//
//  Created by mR yang on 15/10/28.
//  Copyright (c) 2015年 mR yang. All rights reserved.
//

#import "ScanViewController.h"
#import "ScanCollectionView.h"



@interface ScanViewController ()<UIScrollViewDelegate>
{
    ScanCollectionView *scanCollectionV;
}

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
//       NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    
//    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.barTintColor = qMYRGB(242,61, 67);
    if (_isDelegate) {
      
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(0, 0, 35, 30);
        [rightBtn setTitle:@"删除" forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [rightBtn addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
        
        self.navigationItem.rightBarButtonItem = rightButtonItem;
        
    }
    

    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"返回（20x38）.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    

    
    scanCollectionV=[[ScanCollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth+40, kScreenHeight)];
//    1.把数组传到scanCollectionV中
    scanCollectionV.backgroundColor = [UIColor whiteColor];
    scanCollectionV.imageURLArr=_imageURLArr;
//    scanCollectionV.photosIdArr = _photosIdArr;
    NSLog(@"%@",_currentIndexPath);
    [scanCollectionV scrollToItemAtIndexPath:_currentIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    [self.view addSubview:scanCollectionV];
    
}
//删除
- (void)editAction{

    NSMutableArray *urlArr = [NSMutableArray arrayWithArray:_imageURLArr];
    
    NSLog(@"%ld",scanCollectionV.index);
    
    [urlArr removeObjectAtIndex:scanCollectionV.index];
    
    _imageURLArr = [urlArr copy];
    
    scanCollectionV.imageURLArr=_imageURLArr;

    [scanCollectionV reloadData];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RemoveImageNotification" object:[NSString stringWithFormat:@"%ld",scanCollectionV.index]];
    
    if (_imageURLArr.count == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }

}


//返回
- (void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //改变导航栏标题的字体颜色和大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏背景.png"] forBarMetrics:UIBarMetricsDefault];
    
}
@end
