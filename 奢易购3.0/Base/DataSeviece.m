//
//  DataSeviece.m
//  RMXJY
//
//  Created by MacBooK on 16/3/4.
//  Copyright © 2016年 MacBooK. All rights reserved.
//

#import "DataSeviece.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

@implementation DataSeviece


+(void)requestUrl:(NSString *)url
           params:(NSMutableDictionary *)param
          success:(void (^)(id result))successBlock
          failure:(void (^)(NSError *error))failBlock{

    //1.拼接url
    url = [BaseUrl stringByAppendingString:url];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSLog(@"%@\n %@",url,param);
    
    NSDictionary *parameters = @{@"data":param};

//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
//    NSLog(@"%@",[defaults objectForKey:@"sessionId"]);
    
//    [manager.requestSerializer setValue:[NSString stringWithFormat:@"PHPSESSID=%@",[defaults objectForKey:@"sessionId"]]   forHTTPHeaderField:@"Cookie"];
//    [manager.requestSerializer setValue:@"PHPSESSID=1r19ojcnjagrrv7ljahja45892"   forHTTPHeaderField:@"Cookie"];
    
    [manager.requestSerializer setValue:@"21" forHTTPHeaderField:@"appVerCode"];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    [manager POST:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        successBlock(responseObject);
        [hud hide:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failBlock(error);
        [hud hide:YES];
    }];
    
}


@end
