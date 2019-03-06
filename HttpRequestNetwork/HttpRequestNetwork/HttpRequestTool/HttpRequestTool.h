//
//  HttpRequestTool.h
//  afn
//
//  Created by Macx on 2019/3/4.
//  Copyright © 2019年 Wangxiaohan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequestConfigure.h"

#define HttpRequestIndex 3

#if HttpRequestIndex == 1// 内网
#define HttpRequestBaseUrl @""
#elif HttpRequestIndex == 2// 外网
#define HttpRequestBaseUrl @""
#elif HttpRequestIndex == 3// 线上
#define HttpRequestBaseUrl @""
#endif

typedef void (^ResponseConfigure)(HttpRequestConfigure *configure);

NS_ASSUME_NONNULL_BEGIN

@interface HttpRequestTool : NSObject
// 不需要任何回调
+ (NSURLSessionDataTask *)sendRequest:(ResponseConfigure)configureBlock;
// 只需要成功回调
+ (NSURLSessionDataTask *)sendRequest:(ResponseConfigure)configureBlock
                              Success:(SuccessCallBackData)success;
// 只需要失败回调
+ (NSURLSessionDataTask *)sendRequest:(ResponseConfigure)configureBlock
                              Failure:(FailedCallBackReason)failure;
// 只需要结束回调
+ (NSURLSessionDataTask *)sendRequest:(ResponseConfigure)configureBlock
                             Finished:(FinishedCallBack)finished;
// 需要成功和失败回调
+ (NSURLSessionDataTask *)sendRequest:(ResponseConfigure)configureBlock
                              Success:(SuccessCallBackData)success
                              Failure:(FailedCallBackReason)failure;
// 需要成功，失败和结束回调
+ (NSURLSessionDataTask *)sendRequest:(ResponseConfigure)configureBlock
                              Success:(SuccessCallBackData)success
                              Failure:(FailedCallBackReason)failure
                             Finished:(FinishedCallBack)finished;

@end

NS_ASSUME_NONNULL_END
