//
//  ExpressWebViewController.m
//  奢易购3.0
//
//  Created by Andy on 16/9/13.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "ExpressWebViewController.h"

@interface ExpressWebViewController (){


    UIWebView *webView;
    
}

@end

@implementation ExpressWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://m.kuaidi100.com/result.jsp?com=&nu=%@",_expressStr]]];
    [self.view addSubview: webView];
    [webView loadRequest:request];
    

}



@end
