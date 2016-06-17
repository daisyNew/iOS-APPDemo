//
//  NSString+Tools.h
//  JSNormalApp
//
//  Created by dbjyz on 15/6/13.
//  Copyright (c) 2015年 db. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * NSString类别，可用于验证某些信息
 */
@interface NSString (Tools)

//验证手机号码
- (BOOL)validateMobile;

//验证身份证号
- (BOOL) validateIdentityCard;

//真实姓名
- (BOOL) validateTrueName;

//判断是否有特殊符号
- (BOOL)effectivePassword;

//匹配首尾空白字符
-(BOOL) validateBlankString;


//判断手机型号
+ (NSString *)deviceString;

@end
