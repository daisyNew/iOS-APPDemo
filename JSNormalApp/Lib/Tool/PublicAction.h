//
//  PublicAction.h
//  JSNormalApp
//
//  Created by DaisyNew on 16/3/24.
//  Copyright © 2016年 DaisyNew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void (^SuccessBlock)(NSString *status);
typedef void (^FailBlock)(NSError *error);

/** 
 * 可在此类中写一些公共方法，比如分享、点赞、评论等方法。
 */
@interface PublicActon : NSObject

/**
 *  分享给朋友
 *
 *  @param parameter      分享内容的字典，包含：title、shareText、shareURL
 *  @param imageUrl       图片url
 *  @param viewController 当前点击分享的页面
 */
+ (void)sharedToFriendWithParameter:(NSDictionary *)parameter imageUrl:(NSString *)imageUrl presentedController:(UIViewController *)viewController;

/**
 *  分享到朋友圈
 *
 *  @param parameter      分享内容的字典，包含：title、shareText、shareURL
 *  @param imageUrl       图片url
 *  @param viewController 当前点击分享的页面
 */
+ (void)sharedToFriendCircleWithParameter:(NSDictionary *)parameter imageUrl:(NSString *)imageUrl presentedController:(UIViewController *)viewController;


@end
