//
//  BaseVC.h
//  youxue
//
//  Created by DaisyNew on 16/5/13.
//  Copyright © 2016年 决胜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

/**
   UIViewController 基类， 可以配置所有视图控制器的统一样式等
 */
@interface BaseVC : UIViewController


@end

/**
 *  加载动画扩展
 */
@interface BaseVC (ProgressHUD)

//  默认Loading...
@property (nonatomic, copy) NSString *showText;

@property (nonatomic, assign) BOOL isShowingProgressHUD;

/**
 * 默认形式，Loading...+菊花  加载在window上
 */
- (void)showProgressHud;
/**
 * 自定义显示文字， 和进度提示风格
 */
- (void)showProgressHudWithTitle:(NSString *)title mode:(MBProgressHUDMode)mode;
/**
 * 自定义显示文字，自定义视图
 */
- (void)showProgressHudWithTitle:(NSString *)title mode:(MBProgressHUDMode)mode customView:(UIView *)customView;
/**
 * 自定义显示文字，风格，和父视图
 */
- (void)showProgressHudWithTitle:(NSString *)title mode:(MBProgressHUDMode)mode onView:(UIView *)view;
/**
 * 自定义显示文字，风格，视图，和父视图
 */
- (void)showProgressHudWithTitle:(NSString *)title mode:(MBProgressHUDMode)mode customView:(UIView *)customView onView:(UIView *)view;


/**
 *  隐藏加载动画
 */
- (void)hideProgressHud;
- (void)hideProgressHudWithDelay:(NSTimeInterval)delayTimeInterval;

@end