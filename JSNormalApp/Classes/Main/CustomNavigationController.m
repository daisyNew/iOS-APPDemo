//
//  CustomNavigationController.m
//  JSNormalApp
//
//  Created by DaisyNew on 16/6/2.
//  Copyright © 2016年 DaisyNew. All rights reserved.
//

#import "CustomNavigationController.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

/**
 *  第一次使用这个类的时候会调用(1个类只会调用1次)
 */
+ (void)initialize
{
    // 1.设置导航栏主题
    [self setupNavBarTheme];
    
    // 2.设置导航栏按钮主题
    [self setupBarButtonItemTheme];
}

/**
 *  设置导航栏按钮主题
 */
+ (void)setupBarButtonItemTheme
{
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    //去掉系统默认的返回按钮文字
    [item setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                 forBarMetrics:UIBarMetricsDefault];
    
    
    NSDictionary * dict=[NSDictionary dictionaryWithObjectsAndKeys:
                         [UIFont systemFontOfSize:15], NSFontAttributeName ,
                         [UIColor blackColor], NSForegroundColorAttributeName ,
                         nil];
    
    
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    
    
}

/**
 *  设置导航栏主题
 */
+ (void)setupNavBarTheme
{
    // 取出appearance对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    //返回图片
    navBar.backIndicatorImage = [UIImage imageNamed:@"jiantou"];
    navBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"jiantou"];
    
    navBar.tintColor = [UIColor blackColor];

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // 设置标题属性
    NSDictionary * dict=[NSDictionary dictionaryWithObjectsAndKeys:
                         [UIFont systemFontOfSize:20], NSFontAttributeName ,
                         [UIColor blackColor], NSForegroundColorAttributeName ,
                         nil];
    
    
    navBar.titleTextAttributes = dict;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
