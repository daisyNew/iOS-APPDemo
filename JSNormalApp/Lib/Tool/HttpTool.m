//
//  HttpTool.m
//  JSNormalApp
//
//  Created by DaisyNew on 16/6/8.
//  Copyright © 2016年 DaisyNew. All rights reserved.
//

#import "HttpTool.h"
#import <AFNetworking.h>

@implementation HttpTool
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 2.发送请求
    [manager POST:url parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if (success) {
                  success(responseObject);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (failure) {
                  failure(error);
              }
          }];
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 2.发送请求
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> totalFormData) {
        for (FormData *formData in formDataArray) {
            [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 2.发送请求
    [manager GET:url parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             if (success) {
                 success(responseObject);
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if (failure) {
                 failure(error);
             }
         }];
}

+(void)postWithURL:(NSString *)url
     requestHeader:(NSDictionary *)header
            params:(NSMutableDictionary *)params
           success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if (header != nil) {
        for (id key in header.allKeys) {
            [manager.requestSerializer setValue:[header objectForKey:key] forHTTPHeaderField:key];
        }
    }
    
    NSMutableDictionary* newParams = [NSMutableDictionary dictionary];
    for (NSString* key in params.allKeys) {
        NSString* value = params[key];
        if ([value isKindOfClass:[NSString class]]) {
            NSString* string = (NSString*)value;
            string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [newParams setObject:string forKey:key];
        }else{
            [newParams setObject:value forKey:key];
        }
    }
    
    // 2.发送请求
    [manager POST:url parameters:newParams
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if (success) {
                  success(responseObject);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (failure) {
                  failure(error);
              }
          }];
}


+ (void)getWithURL:(NSString *)url
     requestHeader:(NSDictionary *)header
            params:(NSMutableDictionary *)params
           success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if (header != nil) {
        for (id key in header.allKeys) {
            [manager.requestSerializer setValue:[header objectForKey:key] forHTTPHeaderField:key];
        }
        
    }
    
    NSMutableDictionary* newParams = [NSMutableDictionary dictionary];
    for (NSString* key in params.allKeys) {
        NSString* value = params[key];
        if ([value isKindOfClass:[NSString class]]) {
            NSString* string = (NSString*)value;
            string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [newParams setObject:string forKey:key];
        }else{
            [newParams setObject:value forKey:key];
        }
    }
    
    // 2.发送请求
    [manager GET:url parameters:newParams
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if (success) {
                 success(responseObject);
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if (failure) {
                 failure(error);
             }
         }];
    
}

+ (void)putWithURL:(NSString *)url
     requestHeader:(NSDictionary *)header
            params:(NSMutableDictionary *)params
           success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    if (header != nil) {
        for (id key in header.allKeys) {
            [manager.requestSerializer setValue:[header objectForKey:key] forHTTPHeaderField:key];
        }
    }
    
    NSMutableDictionary* newParams = [NSMutableDictionary dictionary];
    for (NSString* key in params.allKeys) {
        NSString* value = params[key];
        if ([value isKindOfClass:[NSString class]]) {
            NSString* string = (NSString*)value;
            string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [newParams setObject:string forKey:key];
        }else{
            [newParams setObject:value forKey:key];
        }
    }
    
    // 2.发送请求
    [manager PUT:url parameters:newParams
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if (success) {
                 success(responseObject);
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if (failure) {
                 failure(error);
             }
         }];
}


@end


/**
 *  用来封装文件数据的模型
 */
@implementation FormData
@end