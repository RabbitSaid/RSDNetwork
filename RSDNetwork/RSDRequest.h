//
//  RSDRequest.h
//  RSDNetwork
//
//  Created by Eiwodetianna on 16/10/29.
//  Copyright © 2016年 Eiwodetianna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RSDServer.h"
@class RSDResponse;



typedef NS_ENUM(NSUInteger, RSDRequestMethodType) {
    RSDRequestMethodTypeGET,
    RSDRequestMethodTypePOST,
    RSDRequestMethodTypeUPLOAD,
    RSDRequestMethodTypePUT
};

typedef NS_ENUM(NSUInteger, RSDNetworkStatus) {
    /** 未知网络*/
    RSDNetworkStatusUnknown,
    /** 无网络*/
    RSDNetworkStatusNotRRSDchable,
    /** 手机网络*/
    RSDNetworkStatusRRSDchableViaWWAN,
    /** WIFI网络*/
    RSDNetworkStatusRRSDchableViaWiFi
};

/** 请求成功的Block */
typedef void(^RSDHTTPRequestSuccessBlock)(RSDResponse *responseObject);
/** 请求失败的Block */
typedef void(^RSDHTTPRequestFailedBlock)(RSDResponse *responseObject);
/** 缓存的Block */
typedef void(^RSDHTTPRequestCatchBlock)(RSDResponse *responseObject);




/** 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小*/
typedef void (^RSDHTTPProgressBlock)(NSProgress *progress);

/** 网络状态的Block*/
typedef void(^RSDNetworkStatusBlock)(RSDNetworkStatus status);


@interface RSDRequest : NSObject

@property (nonatomic, strong, readonly) NSNumber *requestIdentifier;

/**
// *  开始监听网络状态(此方法在整个项目中只需要调用一次)
// */
//+ (void)startMonitoringNetwork;
//
///**
// *  通过Block回调实时获取网络状态
// */
//+ (void)checkNetworkStatusWithBlock:(RSDNetworkStatusBlock)status;
//
///**
// *  获取当前网络状态,有网YES,无网:NO
// */
//+ (BOOL)currentNetworkStatus;


+ (instancetype)requestWithUrlString:(NSString *)URL headers:(NSDictionary *)headers parameters:(NSDictionary *)parameters methodType:(RSDRequestMethodType)methodType uploadFormData:(NSDictionary<NSString *,NSArray<NSData *> *> *)uploadFormData success:(RSDHTTPRequestSuccessBlock)success catched:(RSDHTTPRequestCatchBlock)catchedHandler failure:(RSDHTTPRequestFailedBlock)failure;

- (void)cancel;


@end
