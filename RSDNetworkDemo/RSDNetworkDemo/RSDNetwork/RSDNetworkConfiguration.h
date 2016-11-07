//
//  RSDNetworkConfiguration.h
//  RSDNetwork
//
//  Created by Eiwodetianna on 16/11/1.
//  Copyright © 2016年 RabbitSaid. All rights reserved.
//

#ifndef RSDNetworkConfiguration_h
#define RSDNetworkConfiguration_h

typedef NS_ENUM(NSUInteger, RSDServerType) {
    RSDServerTypeRelease = 1,
    RSDServerTypeAdhoc,
    RSDServerTypeDevelop,
    RSDServerTypeCustom
};

static NSString *const kRSDNetworkScheme = @"https";

static NSString *const kRSDNetworkReleaseHost = @"60.190.57.232:8080";
static NSString *const kRSDNetworkAdhocHost = @"192.168.100.42:8080";
static NSString *const kRSDNetworkDevelopHost = @"github.com";

static const RSDServerType kRSDNetworkServerType = RSDServerTypeDevelop;


// 网络请求超时时间,默认设置为20秒
static const NSTimeInterval kRSDTimeoutSeconds = 30.0f;
static const BOOL kRSDShouldFetchCatchedData = YES;


#endif /* RSDNetworkConfiguration_h */
