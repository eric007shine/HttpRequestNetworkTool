//
//  HttpConstant.h
//  afn
//
//  Created by Wangxiaohan on 2019/3/4.
//  Copyright © 2019年 Wangxiaohan. All rights reserved.
//

#ifndef HttpConstant_h
#define HttpConstant_h

#import <AFNetworking.h>

// 判断是否有效字符串
#define kEmptyString(string) ([string isKindOfClass:[NSNull class]] || string == nil || [string length] < 1 ? YES : NO )
// 判断数组是否为空
#define kEmptyArray(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
// 判断字典是否为空
#define kEmptyDict(dict) (dict == nil || [dict isKindOfClass:[NSNull class]] || dict.allKeys.count == 0 || dict.allKeys == nil)

// Basics网络请求成功回调
typedef void (^ResponseSuccess)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject);
// Basics网络请求失败回调
typedef void (^ResponseFailed)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);
// Basics网络请求结束回调（无论成功或者失败）
typedef void (^ResponseFinished)(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject, NSError * _Nullable error);
// Tool网络请求成功回调
typedef void (^SuccessCallBackData)(NSDictionary *dict);
// Tool网络请求失败回调
typedef void (^FailedCallBackReason)(NSString *reason);
// Tool网络请求结束回调（无论成功或者失败）
typedef void(^FinishedCallBack)(NSDictionary * _Nullable dict, NSString *reason);
// 返回请求发送后task
typedef void (^CallBackTask)(NSURLSessionDataTask *task);
// 取消网络请求回调
typedef void (^CancelRequest)(NSString *reason);

typedef enum : NSUInteger {
    RequestTypeGET,// GET请求
    RequestTypePOST,// POST请求
} RequestType;

typedef enum : NSUInteger {
    HttpNotReachable,// 网络不可用
    HttpReachableViaWiFi,// WiFi网络
    HttpReachableViaWWAN,// 可用网络
} HttpNetworkStatusType;

#define kNotHttpNetExpression @"--网络不可用---"

#endif /* HttpConstant_h */
