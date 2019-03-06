//
//  HttpRequestBasics.h
//  afn
//
//  Created by Macx on 2019/3/4.
//  Copyright © 2019年 Wangxiaohan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequestConfigure.h"

NS_ASSUME_NONNULL_BEGIN

@interface HttpRequestBasics : NSObject
// 网络请求
- (NSURLSessionDataTask *)requestWithConfigure:(HttpRequestConfigure *)configure
                                       Success:(ResponseSuccess)success
                                       Failure:(ResponseFailed)failure
                                      Finished:(ResponseFinished)finished;
// 实例化
+ (instancetype)defaultCenter;

@end

NS_ASSUME_NONNULL_END
