//
//  RSDCache.m
//  RSDNetwork
//
//  Created by Eiwodetianna on 16/11/3.
//  Copyright © 2016年 RabbitSaid. All rights reserved.
//

#import "RSDCache.h"

static NSString *const NetworkResponseCache = @"NetworkResponseCache";

@interface RSDCache ()

@property (nonatomic, strong) NSURLCache *URLCache;

@end

@implementation RSDCache

#pragma mark - public

+ (instancetype)shareCache {
    static RSDCache *cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[RSDCache alloc] init];
        cache.URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024
                                                             diskCapacity:20 * 1024 * 1024
                                                                 diskPath:nil];
        [NSURLCache setSharedURLCache:cache.URLCache];
    });
    return cache;
}


- (void)getCachedDataForDataTask:(NSURLSessionDataTask *)dataTask completionHandler:(CompletionHandlerBlock)completionHandler {
//    NSLog(@"%@", dataTask);
    //获取缓存
    [[NSURLCache sharedURLCache] getCachedResponseForDataTask:dataTask completionHandler:^(NSCachedURLResponse * _Nullable cachedResponse) {
        
        completionHandler(cachedResponse.data);
    }];
}


/**
 *  获取网络缓存的总大小 bytes(字节)
 */
//- (NSInteger)getAllCacheSize {
////    return [_dataCache.diskCache totalCost];
//}

/**
 *  删除所有网络缓存,
 */
//- (void)removeAllHTTPCache {
////    [_dataCache.diskCache removeAllObjects];
//}




@end
