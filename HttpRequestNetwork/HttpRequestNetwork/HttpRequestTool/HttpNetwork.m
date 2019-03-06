//
//  HttpNetwork.m
//  afn
//
//  Created by Wangxiaohan on 2019/3/4.
//  Copyright © 2019年 Wangxiaohan. All rights reserved.
//

#import "HttpNetwork.h"
#import <Reachability.h>

@interface HttpNetwork ()

@property (nonatomic, strong)Reachability *reachability;

@end

NSString * const kHttpReachabilityChangedNotification = @"kHttpReachabilityChangedNotification";

@implementation HttpNetwork

+ (instancetype)sharedNetwork{
    static HttpNetwork *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil){
            instance = [[HttpNetwork alloc] init];
        }
    });
    return instance;
}
- (instancetype)init{
    if (self = [super init]) {
        [self.reachability startNotifier];
        [self addNetworkingStatusNotification];
    }
    return self;
}
- (void)addNetworkingStatusNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveReachabilityChangedNotification:) name:kReachabilityChangedNotification object:nil];
}
- (void)receiveReachabilityChangedNotification:(NSNotification *)notification{
    [[NSNotificationCenter defaultCenter] postNotificationName:kHttpReachabilityChangedNotification object:nil];
}
- (BOOL)isReachable{
    return [self.reachability currentReachabilityStatus] != NotReachable;
}
- (HttpNetworkStatusType)returnCurrentHttpNetworkStatus{
    NetworkStatus status = self.reachability.currentReachabilityStatus;
    switch (status) {
        case ReachableViaWiFi:
            return HttpReachableViaWiFi;
            break;
        case ReachableViaWWAN:
            return HttpReachableViaWWAN;
            break;
        default:
            return HttpNotReachable;
            break;
    }
}
- (Reachability *)reachability{
    if (!_reachability) {
        _reachability = [Reachability reachabilityForInternetConnection];
    }
    return _reachability;
}

@end
