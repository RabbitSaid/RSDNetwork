//
//  RSDServer.m
//  RSDNetwork
//
//  Created by Eiwodetianna on 16/11/1.
//  Copyright © 2016年 RabbitSaid. All rights reserved.
//

#import "RSDServer.h"

@interface RSDServer ()


@property (nonatomic, copy, readonly) NSString *releaseNetworkBaseUrl;

@property (nonatomic, copy, readonly) NSString *adhocNetworkBaseUrl;

@property (nonatomic, copy, readonly) NSString *developNetworkBaseUrl;
/**
 *  自定义服务器地址
 */
@property (nonatomic, copy) NSString *customerNetworkBaseUrl;


@end

@implementation RSDServer

#pragma mark - public

+ (RSDServer *)serverType:(RSDServerType)serverType {
    RSDServer *server = [RSDServer shareServer];
    server.serverType = serverType ?: kRSDNetworkServerType;
    return server;
}

- (NSString *)url {
    NSString *url = nil;
    switch (self.serverType) {
        case RSDServerTypeRelease:
            url = kRSDNetworkReleaseHost;
            break;
        case RSDServerTypeAdhoc:
            url = kRSDNetworkAdhocHost;
            break;
        case RSDServerTypeDevelop:
            url = kRSDNetworkDevelopHost;
            break;
        case RSDServerTypeCustom:
            url = self.customerNetworkBaseUrl;
            break;
        default:
            break;
    }

    return url;
}

#pragma mark - private

+ (RSDServer *)shareServer {
    static dispatch_once_t onceToken;
    static RSDServer *server = nil;
    dispatch_once(&onceToken, ^{
        server = [[RSDServer alloc] init];
    });
    return server;
}


- (instancetype)init {
    self = [super init];
    if (self) {
#ifdef RELEASE
        // 优先宏定义正式环境
        self.serverType = RSDServerTypeRelease;
#elif defined ADHOC
        self.serverType = RSDServerTypeAdhoc;
#else
        if (self.customerNetworkBaseUrl) {
            self.serverType = RSDServerTypeCustom;
        } else {
            self.serverType = RSDServerTypeDevelop;
        }
#endif
    }
    return self;
}



- (NSString *)customerNetworkBaseUrl {
    NSString *url = [[NSUserDefaults standardUserDefaults] stringForKey:@"kRSDCustmoerNetworkBaseUrl"];
    return url;
}



@end
