//
//  UserModel.m
//  BMHeadLine
//
//  Created by 徐益智 on 16/1/18.
//  Copyright © 2016年 Vdianjing. All rights reserved.
//

#import "UserModel.h"

#define kUid @"uid"
#define kMobile @"mobile"
#define kTruename @"username"
#define kNickName @"nickName"
#define kAvator @"avatar"
#define kToken @"token"

static UserModel *_userModel;
@implementation UserModel
/**
 *  编码
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.uid forKey:kUid];
    [aCoder encodeObject:self.mobile forKey:kMobile];
    [aCoder encodeObject:self.username forKey:kTruename];
    [aCoder encodeObject:self.nickname forKey:kNickName];
    [aCoder encodeObject:self.avatar forKey:kAvator];
    [aCoder encodeObject:self.token forKey:kToken];
}

/**
*  解码
*/
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        if (aDecoder == nil) {
            return self;
        }
        self.uid = [aDecoder decodeObjectForKey:kUid];
        self.mobile = [aDecoder decodeObjectForKey:kMobile];
        self.username = [aDecoder decodeObjectForKey:kTruename];
        self.nickname = [aDecoder decodeObjectForKey:kNickName];
        self.token = [aDecoder decodeObjectForKey:kToken];
        self.avatar = [aDecoder decodeObjectForKey:kAvator];
    }
    return self;
}

- (void)save
{
    NSString *documentsPath ;
    NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *path  = [docPath objectAtIndex:0];
    documentsPath = [NSString stringWithFormat:@"%@/user",path];
    MyLog(@"path = %@", documentsPath);
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *vdArchiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [vdArchiver encodeObject:self forKey:@"key1"];
    [vdArchiver finishEncoding];
    [data writeToFile:documentsPath atomically:YES];
}

+ (UserModel *)queryModel
{
    NSString *documentsPath ;
    NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *path  = [docPath objectAtIndex:0];
    documentsPath = [NSString stringWithFormat:@"%@/user",path];
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:documentsPath];
    NSKeyedUnarchiver *vdUnarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    UserModel * model  = [vdUnarchiver decodeObjectForKey:@"key1"];
    [vdUnarchiver finishDecoding];
    return model;
}

/**
 *删除所有文件
 */
+ (void)deleteAllFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSAllDomainsMask, YES) objectAtIndex:0];
    NSDirectoryEnumerator* en = [fileManager enumeratorAtPath:documentsDirectory];
    NSError* err = nil;
    BOOL res;
    
    NSString* file;
    while (file = [en nextObject]) {
        res = [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:file] error:&err];
        if (!res && err) {
            MyLog(@"oops: %@", err);
        }
    }
}

+ (void)deleteUserFile {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *docu = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSAllDomainsMask, YES) objectAtIndex:0];
    NSString *documentsDirectory = [NSString stringWithFormat:@"%@/user",docu];
    
    NSString *filePath = documentsDirectory;
    if ([fileManager fileExistsAtPath:filePath]) {
        [fileManager removeItemAtPath:filePath error:nil];
        
    }
}

@end
