//
//  RSDResponse.h
//  RSDNetwork
//
//  Created by Eiwodetianna on 16/10/31.
//  Copyright © 2016年 RabbitSaid. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class RSDResponse;
@class RSDRequest;

@protocol RSDResponseCustomParseDelegate <NSObject>

@optional;
- (nullable id)customObjectCustomParseWithResponse:(RSDResponse *)response;

@end

@interface RSDResponse : NSObject

/** 自定义响应结果，需要实现<RSDResponseCustomParseDelegate>协议方法 */
@property (nonatomic, strong, readonly, nullable) id customObject;

@property (nonatomic, weak, nullable) id<RSDResponseCustomParseDelegate> customParseDelegate;


/** 回调二进制Data */
@property (nonatomic, strong, readonly) NSData *responseData;

@property (nonatomic, strong, readonly) NSError *responseError;

@property (nonatomic, strong, readonly) RSDRequest *originReuqest;

/** 返回message */
@property (nonatomic,copy, readonly) NSString *responseMessage;

/** 是否是缓存数据 */
@property (nonatomic, assign, readonly) BOOL isCached;

+ (instancetype)responseWithData:(nullable NSData *)data originRequest:(RSDRequest *)originRequest;

+ (instancetype)responseWithCatchedData:(nullable NSData *)catchedData originRequest:(RSDRequest *)originRequest;

+ (instancetype)responseWithError:(NSError *)error originRequest:(RSDRequest *)originRequest;

- (instancetype)initWithCatchedData:(nullable NSData *)catchedData originRequest:(RSDRequest *)originRequest;

- (instancetype)initWithData:(nullable NSData *)data originRequest:(RSDRequest *)originRequest;

- (instancetype)initWithError:(NSError *)error originRequest:(RSDRequest *)originRequest;

@end

@interface RSDResponse (RSDResponseParse)

/** 回调字符串 */
@property (nonatomic, copy, readonly, nullable) NSString *contentString;
/** 回调json对象, 字典或者数组 */
@property (nonatomic, strong, readonly, nullable) id jsonObject;

@end

NS_ASSUME_NONNULL_END
