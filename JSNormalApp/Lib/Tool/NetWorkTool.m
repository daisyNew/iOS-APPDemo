//
//  NetWorkTool.m
//  danbai_client_ios
//
//  Created by dbjyz on 15/8/14.
//  Copyright (c) 2015年 db. All rights reserved.
//

#import "NetWorkTool.h"
#import <Reachability/Reachability.h>

@implementation NetWorkTool

+(void)monitor{
    
    // 添加网络监控
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    
    [reach startNotifier];
}

- (void) reachabilityChanged: (NSNotification*)note {
    Reachability * reach = [note object];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    
    if(![reach isReachable])
    {
        hud.labelText  = @"网络不可用";
        [hud show:YES];
        [hud hide:YES afterDelay:2];
        return;
    }
    
    NSLog(@"网络可用");
    
    if (reach.isReachableViaWiFi) {
        
        NSLog(@"当前通过wifi连接");
    } else {
        NSLog(@"wifi未开启，不能用");
    }
    
    if (reach.isReachableViaWWAN) {
        hud.labelText  = @"当前网络非Wifi，是否继续观看";
        [hud show:YES];
        [hud hide:YES afterDelay:2];
    } else {
        
        NSLog(@"2g or 3g网络未使用");
        
    }
}


@end
