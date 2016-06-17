//
//  UIView+SetLayer.m
//  danbai_client_ios
//
//  Created by dbjyz on 15/6/16.
//  Copyright (c) 2015年 db. All rights reserved.
//

#import "UIView+SetLayer.h"

@implementation UIView (SetLayer)

- (void)setCornerRadius:(CGFloat)cornerRadius{

    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = YES;
}

- (void)setBorderWidth:(CGFloat)width color:(UIColor *)color{
    
    self.layer.borderWidth = width;
    self.layer.borderColor = [color CGColor];
}

@end
