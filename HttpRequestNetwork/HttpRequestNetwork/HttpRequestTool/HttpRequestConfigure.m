//
//  HttpRequestConfigure.m
//  afn
//
//  Created by Macx on 2019/3/4.
//  Copyright © 2019年 Wangxiaohan. All rights reserved.
//

#import "HttpRequestConfigure.h"

@implementation HttpRequestConfigure

+ (instancetype)setConfigure{
    return [[HttpRequestConfigure alloc] init];
}
// -- 默认参数在这里设置 --
- (instancetype)init{
    self = [super init];
    if (self) {
        // 默认请求方式为GET
        _requestType = RequestTypeGET;
        // 默认请求超时时间为60秒
        _timeoutInterval = 60.0;
    }
    return self;
}

@end
