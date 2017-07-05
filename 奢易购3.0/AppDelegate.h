//
//  AppDelegate.h
//  奢易购3.0
//
//  Created by guest on 16/7/18.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>

{
    NSString* wbtoken;
    NSString* wbCurrentUserID;
}


@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) MMDrawerController * drawerController;


@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wbRefreshToken;
@property (strong, nonatomic) NSString *wbCurrentUserID;


@end

