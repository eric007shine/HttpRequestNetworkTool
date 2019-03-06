//
//  HttpRequestTool.m
//  afn
//
//  Created by Macx on 2019/3/4.
//  Copyright © 2019年 Wangxiaohan. All rights reserved.
//

#import "HttpRequestTool.h"
#import "HttpRequestBasics.h"
#import "HttpNetwork.h"

@implementation HttpRequestTool

+ (instancetype)defaultCenter{
    static id requestTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestTool = [[HttpRequestTool alloc] init];
    });
    return requestTool;
}
+ (NSURLSessionDataTask *)sendRequest:(ResponseConfigure)configureBlock{
    return [[HttpRequestTool defaultCenter] sendRequest:configureBlock
                                                Success:nil
                                                Failure:nil
                                               Finished:nil];
}
+ (NSURLSessionDataTask *)sendRequest:(ResponseConfigure)configureBlock
                              Success:(SuccessCallBackData)success{
    return [[HttpRequestTool defaultCenter] sendRequest:configureBlock
                                                Success:success
                                                Failure:nil
                                               Finished:nil];
}
+ (NSURLSessionDataTask *)sendRequest:(ResponseConfigure)configureBlock
                              Failure:(FailedCallBackReason)failure{
    return [[HttpRequestTool defaultCenter] sendRequest:configureBlock
                                                Success:nil
                                                Failure:failure
                                               Finished:nil];
}
+ (NSURLSessionDataTask *)sendRequest:(ResponseConfigure)configureBlock
                             Finished:(FinishedCallBack)finished{
    return [[HttpRequestTool defaultCenter] sendRequest:configureBlock
                                                Success:nil
                                                Failure:nil
                                               Finished:finished];
}
+ (NSURLSessionDataTask *)sendRequest:(ResponseConfigure)configureBlock
                              Success:(SuccessCallBackData)success
                              Failure:(FailedCallBackReason)failure{
    return [[HttpRequestTool defaultCenter] sendRequest:configureBlock
                                                Success:success
                                                Failure:failure
                                               Finished:nil];
}
+ (NSURLSessionDataTask *)sendRequest:(ResponseConfigure)configureBlock
                              Success:(SuccessCallBackData)success
                              Failure:(FailedCallBackReason)failure
                             Finished:(FinishedCallBack)finished{
    return [[HttpRequestTool defaultCenter] sendRequest:configureBlock
                                                Success:success
                                                Failure:failure
                                               Finished:finished];
}
#pragma mark 私有方法，外部进来的方法统一调用这个方法进行网络请求
- (NSURLSessionDataTask *)sendRequest:(ResponseConfigure)configureBlock
                              Success:(SuccessCallBackData)success
                              Failure:(FailedCallBackReason)failure
                             Finished:(FinishedCallBack)finished{
    HttpRequestConfigure *configure = [HttpRequestConfigure setConfigure];
    if (configureBlock) {
        configureBlock(configure);
    }
    HttpRequestConfigure *requestConfigure = [self resetRequestConfiguration:configure];
    if ([[HttpNetwork sharedNetwork] isReachable]) {
        return [[HttpRequestBasics defaultCenter] requestWithConfigure:requestConfigure Success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *data = [self analyzeResponseData:responseObject];
            if (success) {
                success(data);
            }
        } Failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSString *reason = [self returnErrorDescription:error];
            if (failure) {
                failure(reason);
            }
        } Finished:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject, NSError * _Nullable error) {
            NSDictionary *data = [self analyzeResponseData:responseObject];
            NSString *reason = [self returnErrorDescription:error];
            if (finished) {
                finished(data, reason);
            }
        }];
    }
    else{
        failure(kNotHttpNetExpression);
        return nil;
    }
}
#pragma mark 重置请求配置 -- 按后台要去设置请求头和请求体，自行修改 --
- (HttpRequestConfigure *)resetRequestConfiguration:(HttpRequestConfigure *)configure{
    // 请求地址
    if (kEmptyString(configure.specialUrl)) {
        [configure setValue:[NSString stringWithFormat:@"%@%@",HttpRequestBaseUrl,configure.apiUrl] forKey:@"requestUrl"];
    }
    else{
        [configure setValue:configure.specialUrl forKey:@"requestUrl"];
    }
    // 请求头&请求体
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *osVersion = [[UIDevice currentDevice] systemVersion];
    NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDate = [dateFormatter stringFromDate:date];
    NSString *userToken = @"";
    NSDictionary *headDict = @{
                               @"appVersion":appVersion,
                               @"lang":@"zh-CN",
                               @"os":@"iOS",
                               @"osVersion":osVersion,
                               @"uid":deviceUUID,
                               @"time":currentDate,
                               @"userToken":userToken,
                               @"platformID":@"91GOUWU"
                               };
    NSData *headData = [NSJSONSerialization dataWithJSONObject:headDict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *headString = [[NSString alloc]initWithData:headData encoding:NSUTF8StringEncoding];
    if (kEmptyDict(configure.parameters)) {
        configure.parameters = @{@"head":headString};
    }
    else{
        NSDictionary *body = configure.parameters;
        NSData *BodyData = [NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error:nil];
        NSString *bodyString = [[NSString alloc]initWithData:BodyData encoding:NSUTF8StringEncoding];
        configure.parameters = @{@"head":headString,@"body":bodyString};
    }
    return configure;
}
#pragma mark 解析返回的数据 -- 这部分看接口返回的数据情况而定，自行修改 --
- (NSDictionary *)analyzeResponseData:(id)responseObject{
    if (responseObject == nil || [responseObject isEqual:[NSNull null]]) {
        return @{};
    }
    return responseObject;
}
#pragma mark 返回错误描述 -- 这部分如果知道新的字段，可自行添加 --
- (NSString *)returnErrorDescription:(NSError *)error{
    NSString *reason = error.userInfo[@"NSLocalizedDescriptionKey"];
    if (!kEmptyString(reason)) {
        return reason;
    }
    NSString *status = error.userInfo[@"NSLocalizedDescription"];
    if ([status isEqualToString:@"cancelled"]) {
        return @"取消请求";
    }
    return @"请求失败";
}
@end
