//
//  JSProjectConfig.h
//  JSNormalApp
//
//  Created by DaisyNew on 16/6/2.
//  Copyright © 2016年 DaisyNew. All rights reserved.
//

/**工程配置的类*/

//  测试环境 值
//  1-测试
//  0-发布

#define IsDeveloperEnvironment   0

#define UMengKey  @""

//屏幕宽度
#define ScreenW   CGRectGetWidth([UIScreen mainScreen].bounds)
//屏幕高度
#define ScreenH   CGRectGetHeight([UIScreen mainScreen].bounds)

#define kGetY(f)   CGRectGetMaxY(f)//(f.origin.y + CGRectGetHeight(f))
#define kGetX(f)   CGRectGetMaxX(f)//(f.origin.x + CGRectGetWidth(f))

// 判断空
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))

//自定义Log
#ifdef DEBUG
#define MyLog(...) NSLog(__VA_ARGS__)
#else
#define MyLog(...)
#endif