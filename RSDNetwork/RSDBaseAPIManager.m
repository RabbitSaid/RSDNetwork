//
//  RSDBaseAPIManager.m
//  RSDNetwork
//
//  Created by Eiwodetianna on 16/11/1.
//  Copyright © 2016年 RabbitSaid. All rights reserved.
//

#import "RSDBaseAPIManager.h"
#import "RSDRequest.h"

@interface RSDBaseAPIManager ()



@property (nonatomic, copy) NSString *requestURL;

@property (nonatomic, strong) NSMutableArray<RSDRequest *> *requestArray;

@end

@implementation RSDBaseAPIManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.requestArray = [NSMutableArray array];
    }
    return self;
}



- (NSString *)requestPath {
    return nil;
}

- (RSDRequestMethodType)requestMethodType {
    return RSDRequestMethodTypeGET;
}

- (NSDictionary *)requestParameters {
    return nil;
}

- (RSDServerType)serverType {
    return kRSDNetworkServerType;
}

- (BOOL)shouldFetchCachedData {
    return kRSDShouldFetchCatchedData;
}

- (NSString *)requestURL {
    NSString *baseUrl = [RSDServer serverType:[self serverType]].url;
    NSString *requestPath = nil;
    if (nil == self.requestPath || [self.requestPath isEqualToString:@""]) {
        requestPath = @"";
    } else {
        if ([self.requestPath hasPrefix:@"/"]) {
            requestPath = self.requestPath;
        } else {
            requestPath = [@"/" stringByAppendingString:self.requestPath];
        }
        
    }
    
    return [NSString stringWithFormat:@"%@://%@%@", kRSDNetworkScheme, baseUrl, requestPath];
}

- (NSDictionary *)requestHeaders {
    return nil;
}

- (RSDRequest *)startLoadWithSuccess:(RSDRequestSuccessBlock)success failure:(RSDRequestFailedBlock)failure {
    
    RSDRequestMethodType methodType = [self requestMethodType];
    NSDictionary *requestHeaders = [self requestHeaders];
    
    NSDictionary *requestParameters = [self requestParameters];
    NSDictionary *formData = nil;
    if ([self respondsToSelector:@selector(uploadFormData)]) {
        formData = [self performSelector:@selector(uploadFormData)];
    }
    __weak typeof(self) weakSelf = self;

    void(^cathedBlock)(RSDResponse *responseObject) = [self shouldFetchCachedData] ? success : nil;
    
    RSDRequest *request = [RSDRequest requestWithUrlString:self.requestURL headers:requestHeaders parameters:requestParameters methodType:methodType uploadFormData:formData success:^(RSDResponse *responseObject) {
        responseObject.customParseDelegate = weakSelf;
        
        success ? success(responseObject) : nil;
        
        [weakSelf.requestArray removeObject:responseObject.originReuqest];
    } catched:^(RSDResponse *responseObject) {
        responseObject.customParseDelegate = weakSelf;
        cathedBlock ? cathedBlock(responseObject) : nil;
    } failure:^(RSDResponse *responseObject) {
        
        failure ? failure(responseObject) : nil;
        [weakSelf.requestArray removeObject:responseObject.originReuqest];
    }];

    [_requestArray addObject:request];
    return request;

}

- (void)cancelAllRequest {
    for (RSDRequest *request in _requestArray) {
        [request cancel];
    }
    
}

- (NSArray *)requstList {
    return [_requestArray copy];
}

- (id)customObjectCustomParseWithResponse:(RSDResponse *)response {
    return nil;
}

@end
