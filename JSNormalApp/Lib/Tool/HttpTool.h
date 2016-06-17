//
//  HttpTool.h
//  JSNormalApp
//
//  Created by DaisyNew on 16/6/8.
//  Copyright © 2016年 DaisyNew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POST请求(上传文件数据)
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param formData  文件参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

/**
 *  POST请求（包含请求头，没有请求头的情况下header和fields可写nil）
 *
 *  @param url    请求地址
 *  @param header 请求头内容
 *  @param fields 请求头的字段
 *  @param params 请求体
 *  @param block  回调内容
 */
+ (void)postWithURL:(NSString *)url
      requestHeader:(NSDictionary *)header
             params:(NSMutableDictionary *)params
            success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 *  GET请求（包含请求头，没有请求头的情况下header和fields可写nil）
 *
 *  @param url    请求地址
 *  @param header 请求头内容
 *  @param fields 请求头的字段
 *  @param params 请求体
 *  @param block  回调内容
 */
+ (void)getWithURL:(NSString *)url
     requestHeader:(NSDictionary *)header
            params:(NSMutableDictionary *)params
           success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 *  PUT请求（包含请求头，没有请求头的情况下header和fields可写nil）
 *
 *  @param url    请求地址
 *  @param header 请求头内容
 *  @param fields 请求头的字段
 *  @param params 请求体
 *  @param block  回调内容
 */
+ (void)putWithURL:(NSString *)url
     requestHeader:(NSDictionary *)header
            params:(NSMutableDictionary *)params
           success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end

/**
 *  用来封装文件数据的模型
 */
@interface FormData : NSObject
/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;

@end
