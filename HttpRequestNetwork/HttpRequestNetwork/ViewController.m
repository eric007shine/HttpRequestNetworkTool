//
//  ViewController.m
//  HttpRequestNetwork
//
//  Created by Macx on 2019/3/5.
//  Copyright © 2019年 JUNTIAN ASSET. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 没有回调
    [HttpRequestTool sendRequest:^(HttpRequestConfigure *configure) {
        configure.requestType = RequestTypePOST;
        configure.specialUrl = kHomePage_Ad_URL;
    }];
    // 成功回调
    [HttpRequestTool sendRequest:^(HttpRequestConfigure *configure) {
        configure.requestType = RequestTypePOST;
        configure.specialUrl = kHomePage_Ad_URL;
    } Success:^(NSDictionary *dict) {
        NSLog(@"dict:%@",dict);
    }];
    // 失败回调
    [HttpRequestTool sendRequest:^(HttpRequestConfigure *configure) {
        configure.requestType = RequestTypePOST;
        configure.specialUrl = kHomePage_Ad_URL;
    } Failure:^(NSString *reason) {
        NSLog(@"reason:%@",reason);
    }];
    // 结束回调
    [HttpRequestTool sendRequest:^(HttpRequestConfigure *configure) {
        configure.requestType = RequestTypePOST;
        configure.specialUrl = kHomePage_Ad_URL;
    } Finished:^(NSDictionary * _Nullable dict, NSString *reason) {
        NSLog(@"--");
    }];
    // 成功和失败回调
    [HttpRequestTool sendRequest:^(HttpRequestConfigure *configure) {
        configure.requestType = RequestTypePOST;
        configure.specialUrl = kHomePage_Ad_URL;
    } Success:^(NSDictionary *dict) {
        NSLog(@"dict:%@",dict);
    } Failure:^(NSString *reason) {
        NSLog(@"reason:%@",reason);
    }];
    // 成功，失败和结束回调
    NSURLSessionDataTask *task = [HttpRequestTool sendRequest:^(HttpRequestConfigure *configure) {
        configure.requestType = RequestTypePOST;
        configure.specialUrl = kHomePage_Ad_URL;
    } Success:^(NSDictionary *dict) {
        NSLog(@"dict:%@",dict);
    } Failure:^(NSString *reason) {
        NSLog(@"reason:%@",reason);
    } Finished:^(NSDictionary * _Nullable dict, NSString *reason) {
        NSLog(@"--");
    }];
    // 在需要取消请求的地方取消请求
    [task cancel];
}

@end
