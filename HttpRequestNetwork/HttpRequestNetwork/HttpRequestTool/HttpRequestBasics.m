//
//  HttpRequestBasics.m
//  afn
//
//  Created by Macx on 2019/3/4.
//  Copyright © 2019年 Wangxiaohan. All rights reserved.
//

#import "HttpRequestBasics.h"

@interface AFHTTPSessionManager (wxh)

+ (instancetype)sharedManager;

@end

@implementation AFHTTPSessionManager (wxh)

+ (instancetype)sharedManager {
    static AFHTTPSessionManager *sessionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager = [AFHTTPSessionManager manager];
        // -- 返回数据的序列化器，大部分是用AFJSONResponseSerializer，可在这里做相应修改 --
        AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/json", @"text/javascript", @"text/html", @"image/jpeg", nil];
        sessionManager.responseSerializer = responseSerializer;
        // 请求参数的序列化器
        AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
        sessionManager.requestSerializer = requestSerializer;
        // -- 不需要证书验证，如果需要自行处理 --
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.validatesDomainName = NO;
        securityPolicy.allowInvalidCertificates = YES;
        sessionManager.securityPolicy = securityPolicy;
    });
    return sessionManager;
}

@end

@implementation HttpRequestBasics

+ (instancetype)defaultCenter{
    static id requestBasics = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestBasics = [[HttpRequestBasics alloc] init];
    });
    return requestBasics;
}
- (NSURLSessionDataTask *)requestWithConfigure:(HttpRequestConfigure *)configure
                                       Success:(ResponseSuccess)success
                                       Failure:(ResponseFailed)failure
                                      Finished:(ResponseFinished)finished{
    AFHTTPSessionManager *sessionManger = [AFHTTPSessionManager sharedManager];
    // -- 网络超时时间设置 --
    [sessionManger.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    sessionManger.requestSerializer.timeoutInterval = configure.timeoutInterval;
    [sessionManger.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    switch (configure.requestType) {
        case RequestTypeGET:{
            return [sessionManger GET:configure.requestUrl
                           parameters:configure.parameters
                             progress:nil
                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                  success(task,responseObject);
                                  finished(task,responseObject,nil);
                              }
                              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        failure(task,error);
                        finished(task,nil,error);
                   }];
            break;
        }
        case RequestTypePOST:{
            return [sessionManger POST:configure.requestUrl
                            parameters:configure.parameters
                              progress:nil
                               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                   success(task,responseObject);
                                   finished(task,responseObject,nil);
                               }
                               failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                       failure(task,error);
                       finished(task,nil,error);
                   }];
            break;
        }
        // --如果还需要其他类型的请求，可以在这里继续添加--
    }
}

@end
