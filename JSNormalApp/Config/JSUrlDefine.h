//
//  JSUrlDefine.h
//  JSNormalApp
//
//  Created by DaisyNew on 16/6/2.
//  Copyright © 2016年 DaisyNew. All rights reserved.
//

/**定义接口的类*/

#ifndef JSUrlDefine_h
#define JSUrlDefine_h


#if IsDeveloperEnvironment

#define BaseURL                      @"http://www0.juesheng.com"

#define JPushIsProduction 0





#else

#define BaseURL                      @"http://www.juesheng.com"

#define JPushIsProduction 1







#endif

#define JoinString(url)        [NSString stringWithFormat:@"%@/%@",BaseURL,url]

#define SendCode             JoinString(@"sendCode")

#define ShareUrl                JoinString(@"ShareUrl")

#define LoginAndRegister  JoinString(@"LoginAndRegister")

#endif /* JSUrlDefine_h */
