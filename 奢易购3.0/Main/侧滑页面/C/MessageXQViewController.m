//
//  MessageXQViewController.m
//  奢易购3.0
//
//  Created by guest on 16/8/31.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "MessageXQViewController.h"

@interface MessageXQViewController (){

    UILabel *titleLabel;
    
    UILabel *contentLabel;
    
    UIScrollView *scrollView;
}

@end

@implementation MessageXQViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [RGBColor colorWithHexString:@"ececec"];
    
    
    
    //设置标题
    self.navigationItem.title = @"消息中心";

    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"返回（20x38）.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;

    [self loadData];
    
    scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:scrollView];
    

    
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 20)];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [RGBColor colorWithHexString:@"#999999"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    [scrollView addSubview:titleLabel];
    
    contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, 100)];
    
    contentLabel.font = [UIFont systemFontOfSize:15];
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = [RGBColor colorWithHexString:@"#999999"];
    [scrollView addSubview:contentLabel];
    
}

- (void)loadData{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:_XQId forKey:@"id"];
    
    [DataSeviece requestUrl:get_messagerie_detailhtml params:params success:^(id result) {
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        
      CGRect rect =[result[@"result"][@"data"][@"title"] boundingRectWithSize:CGSizeMake(kScreenWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil];
      CGRect rect1 =[result[@"result"][@"data"][@"content"] boundingRectWithSize:CGSizeMake(kScreenWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil];
        
        NSLog(@"%lf",rect.size.height);
        titleLabel.height = rect.size.height;
        contentLabel.height = rect1.size.height;
        titleLabel.text = result[@"result"][@"data"][@"title"];

        contentLabel.text = result[@"result"][@"data"][@"content"];
        
        scrollView.contentSize = CGSizeMake(kScreenWidth, contentLabel.bottom);
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}


- (void)leftBtnAction{

    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
