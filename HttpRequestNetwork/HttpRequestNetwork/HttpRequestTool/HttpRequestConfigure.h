//
//  HttpRequestConfigure.h
//  afn
//
//  Created by Macx on 2019/3/4.
//  Copyright © 2019年 Wangxiaohan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HttpRequestConfigure : NSObject
// 拼接到服务器地址后面的路径
@property (nonatomic, copy)NSString *apiUrl;
// 整个请求路径
@property (nonatomic, copy, readonly)NSString *requestUrl;
// 与服务器地址(HttpRequestBaseUrl)不一样的请求路径
@property (nonatomic, copy, nullable)NSString *specialUrl;
// 请求方式 默认为GET
@property (nonatomic, assign)RequestType requestType;
// 参数
@property (nonatomic, strong, nullable)NSDictionary *parameters;
// 请求的超时时间,默认60秒
@property (nonatomic, assign)NSTimeInterval timeoutInterval;

+ (instancetype)setConfigure;

@end

NS_ASSUME_NONNULL_END
