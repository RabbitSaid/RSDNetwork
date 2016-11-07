//
//  RSDCache.h
//  RSDNetwork
//
//  Created by Eiwodetianna on 16/11/3.
//  Copyright © 2016年 RabbitSaid. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef void (^CompletionHandlerBlock) (NSData * _Nullable cachedData);


@interface RSDCache : NSObject

+ (instancetype)shareCache;

- (void)getCachedDataForDataTask:(NSURLSessionDataTask * _Nullable)dataTask completionHandler:(CompletionHandlerBlock _Nullable)completionHandler;


///**
// *  获取网络缓存的总大小 bytes(字节)
// */
//- (NSInteger)getAllCacheSize;
//
///**
// *  删除所有网络缓存,
// */
//- (void)removeAllCache;

@end
NS_ASSUME_NONNULL_END
