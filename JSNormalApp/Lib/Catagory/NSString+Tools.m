//
//  NSString+Tools.m
//  JSNormalApp
//
//  Created by dbjyz on 15/6/13.
//  Copyright (c) 2015年 db. All rights reserved.
//

#import "NSString+Tools.h"
#import "sys/utsname.h"

@implementation NSString (Tools)


- (CGSize)sizeWithFont:(UIFont *)font{
    NSDictionary *att = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    return [self sizeWithAttributes:att];
}


- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    NSDictionary *att = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:att context:nil].size;
}

//手机号码验证
- (BOOL)validateMobile
{
    // 由于手机号码的规则一直在变，所以我这边只需要判断输入的内容为以1开头的11位数字
    NSRange numberRange = [self rangeOfString:@"^1\\d{10}$" options:NSRegularExpressionSearch];
    return numberRange.location != NSNotFound;
}


//真实姓名
- (BOOL) validateTrueName
{
    //    NSString *nameRegex = @"^([\u4e00-\u9fa5]+|([a-zA-Z]+\\s?)+)$";
    NSString *nameRegex = @"^[\u4E00-\u9FFF|A-Za-z|\\.|\\s]*$";
    NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nameRegex];
    return [namePredicate evaluateWithObject:self];
    
}


//身份证号
- (BOOL) validateIdentityCard
{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}


//判断是否有特殊符号
- (BOOL)effectivePassword
{
    NSString *regex = @"[a-zA-Z0-9]{6,20}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

-(BOOL) validateBlankString {
    NSString *regex = @"^\\s*|\\s*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}


//判断手机型号
+ (NSString *)deviceString
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2G (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2G (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad Mini 2G";
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad Mini 3 (China)";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (Cellular)";
    if ([deviceString isEqualToString:@"AppleTV2,1"])   return @"Apple TV 2G";
    if ([deviceString isEqualToString:@"AppleTV3,1"])   return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV3,2"])   return @"Apple TV 3 (2013)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    NSLog(@"NOTE: Unknown device type: %@", deviceString);
    return deviceString;
}

@end
