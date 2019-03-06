//
//  HttpNetwork.h
//  afn
//
//  Created by Wangxiaohan on 2019/3/4.
//  Copyright © 2019年 Wangxiaohan. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kHttpReachabilityChangedNotification;

NS_ASSUME_NONNULL_BEGIN

@interface HttpNetwork : NSObject
// 实例化
+ (instancetype)sharedNetwork;
// 判断当前网络是否可用
- (BOOL)isReachable;
// 获取当前的网络状态
- (HttpNetworkStatusType)returnCurrentHttpNetworkStatus;

@end

NS_ASSUME_NONNULL_END
