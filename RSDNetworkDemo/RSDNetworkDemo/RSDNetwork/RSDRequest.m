//
//  RSDRequest.m
//  RSDNetwork
//
//  Created by Eiwodetianna on 16/10/29.
//  Copyright © 2016年 Eiwodetianna. All rights reserved.
//

#import "RSDRequest.h"
#import "RSDResponse.h"
#import "RSDCache.h"
#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif
#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworkActivityIndicatorManager.h>
#else
#import "AFNetworkActivityIndicatorManager.h"
#endif

typedef void(^RSDSuccessBlock)(NSURLSessionDataTask *task, id reponseObject);
typedef void(^RSDFailureBlock)(NSURLSessionDataTask *task, NSError *error);

@interface RSDRequest ()

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation RSDRequest


- (AFHTTPSessionManager *)sessionManager {
    if (nil == _sessionManager) {
        //打开状态栏的等待菊花
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.requestSerializer.timeoutInterval = kRSDTimeoutSeconds;
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", @"multipart/form-data"]];
    }
    return _sessionManager;
}

+ (instancetype)requestWithUrlString:(NSString *)URL headers:(NSDictionary *)headers parameters:(NSDictionary *)parameters methodType:(RSDRequestMethodType)methodType uploadFormData:(NSDictionary<NSString *,NSArray<NSData *> *> *)uploadFormData success:(RSDHTTPRequestSuccessBlock)success catched:(RSDHTTPRequestCatchBlock)catchedHandler failure:(RSDHTTPRequestFailedBlock)failure {
    
    RSDRequest *request = [[self alloc] init];
    if (nil != headers) {
        for (id key in headers) {
            [request.sessionManager.requestSerializer setValue:[headers objectForKey:key] forHTTPHeaderField:key];
        }
    }
    
    RSDSuccessBlock successBlock = ^(NSURLSessionDataTask *task, id reponseObject) {
        
        RSDResponse *response = [RSDResponse responseWithData:reponseObject originRequest:request];
        success ? success(response) : nil;
    };
    RSDFailureBlock failureBlock =  ^(NSURLSessionDataTask *task, NSError *error) {
        RSDResponse *response = [RSDResponse responseWithError:error originRequest:request];
        failure?failure(response):nil;
        
    };
    switch (methodType) {
        case RSDRequestMethodTypeGET: {
            NSLog(@"Get");
            request.dataTask = [request.sessionManager GET:URL parameters:parameters progress:nil success:successBlock failure:failureBlock];
            NSLog(@"GET END");
            break;
        }
        case RSDRequestMethodTypePOST: {
            request.dataTask = [request.sessionManager POST:URL parameters:parameters progress:nil success:successBlock failure:failureBlock];
            break;
        }
        case RSDRequestMethodTypeUPLOAD: {
            
            request.dataTask = [request.sessionManager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                [uploadFormData enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSArray<NSData *> * _Nonnull obj, BOOL * _Nonnull stop) {
                    
                    if (!stop) {
                        [obj enumerateObjectsUsingBlock:^(NSData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            if (!stop) {
                                [formData appendPartWithFileData:obj
                                                            name:[NSString stringWithFormat:@"%@",key]
                                                        fileName:[NSString stringWithFormat:@"image%lu.jpg",idx] mimeType:@"image/jpeg"];
                            }
                        }];
                    }
                }];
            } progress:nil success:successBlock failure:failureBlock];
            break;
        }
        case RSDRequestMethodTypePUT: {
            request.dataTask = [request.sessionManager PUT:URL parameters:parameters success:successBlock failure:failureBlock];
            break;
        }
    }
    
    if (catchedHandler) {
        
        [[RSDCache shareCache] getCachedDataForDataTask:request.dataTask completionHandler:^(NSData * _Nullable cachedData) {
            if (cachedData) {
                RSDResponse *response = [RSDResponse responseWithCatchedData:cachedData originRequest:request];;
                catchedHandler(response);
            }
        }];
        
    }
    
    return request;
    
}

- (void)cancel {
    NSLog(@"cancel");
    [self.dataTask cancel];
}

- (NSNumber *)requestIdentifier {
    return @(self.dataTask.taskIdentifier);
}




@end
