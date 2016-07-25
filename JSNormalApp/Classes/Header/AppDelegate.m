//
//  AppDelegate.m
//  JSNormalApp
//
//  Created by DaisyNew on 16/6/2.
//  Copyright © 2016年 DaisyNew. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomTabBarController.h"
#import "CustomNavigationController.h"
#import "UMMobClick/MobClick.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>


#define UmengShareAppID     @""
#define UmengShareAppSecret @""

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.rootViewController = [[CustomTabBarController alloc]init];
    
    //友盟统计
    [self umengTrack];
    
    //友盟分享
    [self umengShare];
    
    [self jpushWith:launchOptions];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)umengTrack{
    
    UMConfigInstance.appKey = UMengKey;
    UMConfigInstance.channelId = nil;
    UMConfigInstance.ePolicy = BATCH;
    
    [MobClick startWithConfigure:UMConfigInstance];
}

- (void)umengShare{

    [UMSocialData setAppKey:UMengKey];
    
    [UMSocialWechatHandler setWXAppId:UmengShareAppID appSecret:UmengShareAppSecret url:ShareUrl];
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToWechatFavorite,UMShareToWechatSession]];
    
}

- (void)jpushWith:(NSDictionary *)launchOptions{
    
    //极光推送
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    //Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    //Required
    [JPUSHService setupWithOption:launchOptions
                           appKey:JPushKey
                          channel:@"Publish channel"
                 apsForProduction:JPushIsProduction
            advertisingIdentifier:advertisingId];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
   
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == false) {
       
        
        
    }
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [JPUSHService setBadge:0];
    
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//注册device_token
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

@end
