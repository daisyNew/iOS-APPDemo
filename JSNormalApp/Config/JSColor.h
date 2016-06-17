//
//  JSColor.h
//  JSNormalApp
//
//  Created by DaisyNew on 16/6/2.
//  Copyright © 2016年 DaisyNew. All rights reserved.
//

/**定义色值的类*/

#define ColorFromHex(hexValue) \
[UIColor colorWithRed:((float)(((hexValue) & 0xFF0000) >> 16))/255.0 \
green:((float)(((hexValue) & 0xFF00  ) >> 8 ))/255.0 \
blue:((float)( (hexValue) & 0xFF    ))       /255.0 \
alpha:1.0]

#define kGetColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define kGetColorWithAlpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

//可以定义色值规范，比如统一的背景色什么的
#define GlobalSeperatorColor ColorFromHex(0xebebeb)


