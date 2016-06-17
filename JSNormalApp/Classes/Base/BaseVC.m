//
//  BaseVC.m
//  youxue
//
//  Created by DaisyNew on 16/5/13.
//  Copyright © 2016年 决胜. All rights reserved.
//

#import "BaseVC.h"
#import <objc/runtime.h>

@interface BaseVC ()

{
    MBProgressHUD *_progressHUD;
}

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end



@implementation BaseVC (ProgressHUD)

const void *IsShowingProgressHUD = (void *)@"isShowingProgressHUD";
const void *ShowTextKey = (void *)@"showTextKey";

/**
 *  展示加载动画
 */
- (void)showProgressHud {
    
    [self showProgressHudWithTitle:@"加载中···" mode:MBProgressHUDModeIndeterminate customView:nil onView:nil];
}

///  自定义显示文字， 和进度提示风格
- (void)showProgressHudWithTitle:(NSString *)title mode:(MBProgressHUDMode)mode {
    [self showProgressHudWithTitle:title mode:mode customView:nil onView:nil];
}

///  自定义显示文字，自定义视图
- (void)showProgressHudWithTitle:(NSString *)title mode:(MBProgressHUDMode)mode customView:(UIView *)customView {
    [self showProgressHudWithTitle:title mode:mode customView:customView onView:nil];
}

///  自定义显示文字，风格， 和父视图
- (void)showProgressHudWithTitle:(NSString *)title mode:(MBProgressHUDMode)mode onView:(UIView *)view {
    [self showProgressHudWithTitle:title mode:mode customView:nil onView:view];
}

///  自定义显示文字，风格，视图，和父视图
- (void)showProgressHudWithTitle:(NSString *)title mode:(MBProgressHUDMode)mode customView:(UIView *)customView onView:(UIView *)view {
    
    UIView *onView = view;
    if (nil == onView) {
        onView = self.view;
    }
    
    if (_progressHUD == nil) {
        _progressHUD = [[MBProgressHUD alloc] initWithView:onView];
    }
    if (_progressHUD.superview == nil) {
        [onView addSubview:_progressHUD];
    } else {
        if (_progressHUD.superview != onView) {
            [_progressHUD hide:YES];
            self.isShowingProgressHUD = NO;
            _progressHUD = [[MBProgressHUD alloc] initWithView:onView];
            [onView addSubview:_progressHUD];
        }
    }
    _progressHUD.mode = mode;
    _progressHUD.labelText = title;
    if (customView) {
        _progressHUD.customView = customView;
    }
    
    if (YES == self.isShowingProgressHUD) {
        return;
    }
    self.isShowingProgressHUD = YES;
    [_progressHUD show:YES];
}

/**
 *  隐藏加载动画
 */
- (void)hideProgressHud {
    self.isShowingProgressHUD = NO;
    [_progressHUD hide:YES];
    [_progressHUD removeFromSuperview];
    _progressHUD = nil;
}

- (void)hideProgressHudWithDelay:(NSTimeInterval)delayTimeInterval {
    self.isShowingProgressHUD = NO;
    [_progressHUD hide:YES afterDelay:delayTimeInterval];
    
}

#pragma mark - 动态添加属性
- (BOOL)isShowingProgressHUD {
    
    NSNumber *value = objc_getAssociatedObject(self, IsShowingProgressHUD);
    return value.boolValue;
}

- (void)setIsShowingProgressHUD:(BOOL)isShowingProgressHUD {
    
    objc_setAssociatedObject(self, IsShowingProgressHUD, @(isShowingProgressHUD), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)showText {
    return objc_getAssociatedObject(self, ShowTextKey);
}
- (void)setShowText:(NSString *)showText {
    objc_setAssociatedObject(self, ShowTextKey, showText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
