//
//  DBPhone.h
//  danbai_client_ios
//
//  Created by dbjyz on 15/6/25.
//  Copyright (c) 2015年 db. All rights reserved.
//

#ifndef danbai_client_ios_DBPhone_h
#define danbai_client_ios_DBPhone_h


/** 设备型号识别 */
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) && [[UIDevice currentDevice].systemVersion doubleValue] < 9.0)
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 8.0)

/** 尺寸 */
#define iphone4And4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960),[[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5And5s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6And6s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)

#define iPhone6plusAnd6splus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)



#endif
