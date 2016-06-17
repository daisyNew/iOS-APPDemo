//
//  UserModel.h
//  BMHeadLine
//
//  Created by 徐益智 on 16/1/18.
//  Copyright © 2016年 Vdianjing. All rights reserved.
//

#import <Foundation/Foundation.h>

/**  用户model*/
@interface UserModel : NSObject <NSCoding>

@property (strong,nonatomic) NSString * uid; // user_id
@property (strong,nonatomic) NSString * mobile;
@property (strong,nonatomic) NSString * username; // 名称
@property (strong,nonatomic) NSString * nickname; // 昵称
@property (strong,nonatomic) NSString * avatar;//头像
@property (strong,nonatomic) NSString * token;//

- (void)save;

//判断有无登陆的方法
+ (UserModel *)queryModel;

+ (void)deleteAllFile;

+ (void)deleteUserFile;

@end
