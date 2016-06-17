//
//  UIView+SetLayer.h
//  danbai_client_ios
//
//  Created by dbjyz on 15/6/16.
//  Copyright (c) 2015年 db. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SetLayer)

/**
 *  设置图层的圆角
 *
 *  @param cornerRadius 圆角弧度
 */
- (void)setCornerRadius:(CGFloat)cornerRadius;

/**
 *  设置layer边框
 *
 *  @param width 边框宽度
 *  @param color 边框颜色
 */
- (void)setBorderWidth:(CGFloat)width color:(UIColor *)color;

@end
