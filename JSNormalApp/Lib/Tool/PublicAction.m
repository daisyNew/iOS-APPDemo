//
//  PublicAction.m
//  JSNormalApp
//
//  Created by DaisyNew on 16/3/24.
//  Copyright © 2016年 DaisyNew. All rights reserved.
//

#import "PublicAction.h"
#import "UMSocial.h"

@implementation PublicActon

+ (void)sharedToFriendWithParameter:(NSDictionary *)parameter imageUrl:(NSString *)imageUrl presentedController:(UIViewController *)viewController{

    NSString *snsName = [[UMSocialSnsPlatformManager sharedInstance].allSnsValuesArray objectAtIndex:2];
    [UMSocialData defaultData].extConfig.wechatSessionData.title = parameter[@"title"];
    
    NSString *shareText = parameter[@"shareText"];
    NSString *shareURL = parameter[@"shareURL"];
    UIImage *shareImage = [UIImage imageNamed:@"share_image"];
    
    UMSocialUrlResource *resource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage
                                                                                     url:imageUrl];
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = shareURL;
    
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[snsName]
                                                       content:shareText
                                                         image:shareImage
                                                      location:nil
                                                   urlResource:resource
                                           presentedController:viewController
                                                    completion:^(UMSocialResponseEntity * response){
                                                        if (response.responseCode == UMSResponseCodeSuccess) {
                                                            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                                                                 message:@"分享成功"
                                                                                                                delegate:nil
                                                                                                       cancelButtonTitle:@"好"
                                                                                                       otherButtonTitles:nil];
                                                            [alertView show];
                                                        } else if(response.responseCode != UMSResponseCodeCancel) {
                                                            
                                                        }
                                                    }];

    
    
}

+ (void)sharedToFriendCircleWithParameter:(NSDictionary *)parameter  imageUrl:(NSString *)imageUrl presentedController:(UIViewController *)viewController{
    
    //消息类型
    [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;
    //标题
    [UMSocialData defaultData].extConfig.qqData.title = parameter[@"title"];
    
    NSString *shareText = parameter[@"shareText"];
    
    NSString *shareURL = parameter[@"shareURL"];
    
    UIImage *shareImage = [UIImage imageNamed:@"share_image"];
    
    UMSocialUrlResource *resource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage
                                                                                     url:imageUrl];
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = shareURL;
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline]
                                                        content:shareText
                                                          image:shareImage
                                                       location:nil
                                                    urlResource:resource
                                            presentedController:viewController
                                                     completion:^(UMSocialResponseEntity *response){
                                                         if (response.responseCode == UMSResponseCodeSuccess) {
                                                             UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                                                                  message:@"分享成功"
                                                                                                                 delegate:nil
                                                                                                        cancelButtonTitle:@"好"
                                                                                                        otherButtonTitles:nil];
                                                             [alertView show];
                                                         } else if(response.responseCode != UMSResponseCodeCancel) {
                                                             
                                                         }
                                                     }];
    
    
}

@end
