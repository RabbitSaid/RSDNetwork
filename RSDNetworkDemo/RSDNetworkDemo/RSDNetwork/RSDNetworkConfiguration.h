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

static NSString *const kRSDNetworkReleaseHost = @"github.com";
static NSString *const kRSDNetworkAdhocHost = @"github.com";
static NSString *const kRSDNetworkDevelopHost = @"github.com";

static const RSDServerType kRSDNetworkServerType = RSDServerTypeRelease;


// 网络请求超时时间,默认设置为30秒
static const NSTimeInterval kRSDTimeoutSeconds = 30.0f;
static const BOOL kRSDShouldFetchCatchedData = YES;


#endif /* RSDNetworkConfiguration_h */
