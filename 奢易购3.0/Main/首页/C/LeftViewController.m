//
//  LeftViewController.m
//  奢易购3.0
//
//  Created by guest on 16/7/19.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "LeftViewController.h"
#import "ManagementViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MessageViewController.h"
#import "SettingViewController.h"
#import "OnePublishingViewController.h"

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation LeftViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataAction) name:@"DataNotifocation" object:nil];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];

    _phoneLabel.text = SYGData[@"mobile"];
    _nameLabel.text = SYGData[@"shop_name"];
    
}

- (void)dataAction{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    _phoneLabel.text = SYGData[@"mobile"];
    _nameLabel.text = SYGData[@"shop_name"];
    
}

//个人设置
- (IBAction)settingAction:(id)sender {
    
    
     SettingViewController *settingVC = [[SettingViewController alloc]init];
    
     UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:settingVC];
    
    [self presentViewController:navi animated:YES completion:^{
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        
        [delegate.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        
    }];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row == 1) {
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [delegate.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeNotification" object:nil];

    }else if (indexPath.row == 2){
    
        //库存
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        
        [delegate.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"StockNotification" object:nil];
        
    }else if (indexPath.row == 3){
        //销售记录
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        
        [delegate.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SalesRecordsNotification" object:nil];
        

    }else if (indexPath.row == 4){
        
        //账本
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        
        [delegate.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BooksNotification" object:nil];
        
    }else if (indexPath.row == 5){
        
        //寄卖管理
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        
        [delegate.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ConsignmentNotification" object:nil];
        

        
    }else if (indexPath.row == 6){
        
        //账号管理
        
        ManagementViewController *managementVC = [[UIStoryboard storyboardWithName:@"Share" bundle:nil] instantiateViewControllerWithIdentifier:@"ManagementViewController"];
        
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:managementVC];

        [self presentViewController:navi animated:YES completion:^{
            
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            
            [delegate.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        }];
        
    }
//    else if (indexPath.row == 7){
//    
//        OnePublishingViewController *OnePublishingVC = [[OnePublishingViewController alloc]init];
//        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:OnePublishingVC];
//        
//        [self presentViewController:navi animated:YES completion:^{
//            
//            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//            [delegate.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
//            
//        }];
//    }
    
}


- (IBAction)logoutAction:(id)sender {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;

    [delegate.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];

    LoginViewController *loginVC = [[LoginViewController alloc]init];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = loginVC;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [defaults removeObjectForKey:@"SYGData"];
    [defaults synchronize];
}
//消息按钮
- (IBAction)messageAction:(id)sender {
    
    MessageViewController *messageVC = [[MessageViewController alloc]init];
    
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:messageVC];

    
    [self presentViewController:navi animated:YES completion:^{
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        
        [delegate.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        
    }];
    
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [DataSeviece requestUrl:get_unreadhtml params:params success:^(id result) {
        NSLog(@"%@",result);
        if ([result[@"result"][@"data"][@"num"] isEqualToString:@"0"]) {
            _messageButton.selected = NO;
        }else{
            _messageButton.selected = YES;
        
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    _phoneLabel.text = SYGData[@"mobile"];
    _nameLabel.text = SYGData[@"shop_name"];

}

@end
