//
//  ManagementViewController.m
//  奢易购3.0
//
//  Created by guest on 16/7/20.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "ManagementViewController.h"
#import "AppDelegate.h"
#import "FinanceViewController.h"
#import "EmailViewController.h"
#import "PlatformAccountViewController.h"
#import "AccountSwitchingViewController.h"



@interface ManagementViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *isSwitch;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end

@implementation ManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置标题
    self.navigationItem.title = @"账号管理";
    
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
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"f1f2fa"];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];

    NSString *switchStr = [defaults objectForKey:[NSString stringWithFormat:@"%@switch",SYGData[@"id"]]];
    
    if ([switchStr isEqualToString:@"1"]) {
        [_isSwitch setOn:NO];
    }else{
        [_isSwitch setOn:YES];

    }
    
    
    
}
//左边返回按钮
- (void)leftBtnAction{
    
    [self dismissViewControllerAnimated:YES completion:nil];

    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        //财务管理
        FinanceViewController *financeVC = [[FinanceViewController alloc]init];
        financeVC.isPersonnel = NO;
        
        [self.navigationController pushViewController:financeVC animated:YES];
        
        
    }else if (indexPath.row == 1){
    
        //人员管理
        FinanceViewController *financeVC = [[FinanceViewController alloc]init];
        financeVC.isPersonnel = YES;
        
        [self.navigationController pushViewController:financeVC animated:YES];
        

        
    }else if (indexPath.row == 2){
    
        // 电子邮箱管理
        
        EmailViewController *emailVC = [[EmailViewController alloc]init];
        
        [self.navigationController pushViewController:emailVC animated:YES];
    }else if (indexPath.row == 3){
    
        //绑定平台账号
         PlatformAccountViewController *storageVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"PlatformAccountViewController"];
        
        [self.navigationController pushViewController:storageVC animated:YES];

    }else if (indexPath.row == 5){
        
        AccountSwitchingViewController *AccountSwitchingVC = [[AccountSwitchingViewController alloc]init];
        
        [self.navigationController pushViewController:AccountSwitchingVC animated:YES];
    
    }


}

- (IBAction)switchAction:(UISwitch *)sender {
    
    
    BOOL isButtonOn = [sender isOn];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    

    if (isButtonOn) {
        
        [defaults setObject:@"0" forKey:[NSString stringWithFormat:@"%@switch",SYGData[@"id"]]];

        
    }else {
        
        [defaults setObject:@"1" forKey:[NSString stringWithFormat:@"%@switch",SYGData[@"id"]]];
        
    }
    
    [defaults synchronize];
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    alertV.alertViewStyle = UIAlertViewStyleSecureTextInput;
    
    [alertV show];

    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    UITextField *tf = [alertView textFieldAtIndex:0];

    
    [MD5CommonDigest MD5:tf.text success:^(id result) {
        
        NSLog(@"%@",result);
        
        if ([result isEqualToString:@"1"]) {
            
        }else{
            UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alertV show];
            
            [_isSwitch setOn:!_isSwitch.isOn];
            
            if ([[defaults objectForKey:[NSString stringWithFormat:@"%@switch",SYGData[@"id"]]] isEqualToString:@"1"]) {
                
                [defaults setObject:@"0" forKey:[NSString stringWithFormat:@"%@switch",SYGData[@"id"]]];
                
            }else{
                
                [defaults setObject:@"1" forKey:[NSString stringWithFormat:@"%@switch",SYGData[@"id"]]];
                
            }

        }
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
    
//
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:SYGData[@"id"] forKey:@"uid"];
//    
//    
//    [DataSeviece requestUrl:get_userinfohtml params:params success:^(id result) {
//        
//        NSLog(@"%@ %@",result,result[@"result"]);
//        
//        NSString *mdsStr = [MD5CommonDigest md5HexDigest:tf.text];
//        
//        NSLog(@"%@",mdsStr);
//        
//        
//        if ([result[@"result"][@"password"] isEqualToString:mdsStr]) {
//            
//            NSLog(@"正确");
//            
//        }else{
//            
//
//            
//        }
//
//        
//        
//    } failure:^(NSError *error) {
//        
//        NSLog(@"%@",error);
//        
//    }];
    
    
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

    if (indexPath.row == 3) {
        return 0;
    }
    
    if (indexPath.row == 4) {
        return 10;
    }else if (indexPath.row == 6){
        return 10;
    }
    
    return 44;

}


- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    

    _phoneLabel.text = SYGData[@"mobile"];

}

@end
