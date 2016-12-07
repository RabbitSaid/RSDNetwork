//
//  RSDResponse.m
//  RSDNetwork
//
//  Created by Eiwodetianna on 16/10/31.
//  Copyright © 2016年 RabbitSaid. All rights reserved.
//

#import "RSDResponse.h"
#import "RSDRequest.h"

@interface RSDResponse()

@property (nonatomic, strong, readwrite, nullable) id customObject;

@property (nonatomic, strong, readwrite, nullable) id jsonObject;

@property (nonatomic, copy, readwrite, nullable) NSString *contentString;


/** 回调二进制Data */
@property (nonatomic, strong, readwrite) NSData *responseData;

@property (nonatomic, strong, readwrite) NSError *responseError;
/** 错误信息 */
@property (nonatomic, strong, readwrite) RSDRequest *originReuqest;

/** 是否是缓存数据 */
@property (nonatomic, assign, readwrite) BOOL isCached;

@end

@implementation RSDResponse

+ (instancetype)responseWithData:(NSData *)data originRequest:(RSDRequest *)originRequest {
    return [[RSDResponse alloc] initWithData:data originRequest:originRequest];
}

+ (instancetype)responseWithCatchedData:(NSData *)catchedData originRequest:(RSDRequest *)originRequest {
    return [[RSDResponse alloc] initWithCatchedData:catchedData originRequest:originRequest];
}

+ (instancetype)responseWithError:(NSError *)error originRequest:(RSDRequest *)originRequest {
    return [[RSDResponse alloc] initWithError:error originRequest:originRequest];
}

- (instancetype)initWithData:(NSData *)data originRequest:(nonnull RSDRequest *)originRequest {
    return [self initWithData:data error:nil originRequest:originRequest];
}

- (instancetype)initWithError:(NSError *)error originRequest:(nonnull RSDRequest *)originRequest {
    return [self initWithData:nil error:error originRequest:originRequest];
}

- (instancetype)initWithCatchedData:(NSData *)catchedData originRequest:(RSDRequest *)originRequest {
    self = [self initWithData:catchedData error:nil originRequest:originRequest];
    _isCached = YES;
    return self;
}

- (instancetype)initWithData:(NSData *)data error:(NSError *)error originRequest:(RSDRequest *)originRequest {
    self = [super init];
    if (self) {
        self.responseError = error;
        self.responseData = data;
        self.originReuqest = originRequest;
        
    }
    return self;
}

- (NSError *)responseError {
    return _responseError;
}

- (id)jsonObject {
    
    if (nil == _jsonObject) {
        
        NSError *error = nil;
        self.jsonObject = [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"RSDResponse json object error: %@", error);
    }
    return _jsonObject;
}

- (NSString *)contentString {
    
    if (nil == _contentString) {
        self.contentString = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    }
    
    return _contentString;
    
}

- (id)customObject {
    
    if (self.customParseDelegate && [self.customParseDelegate respondsToSelector:@selector(customObjectCustomParseWithResponse:)]) {
        
        return [self.customParseDelegate customObjectCustomParseWithResponse:self];
    }
    return nil;
}

@end
