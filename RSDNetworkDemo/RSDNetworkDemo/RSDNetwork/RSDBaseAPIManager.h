//
//  RSDBaseAPIManager.h
//  RSDNetwork
//
//  Created by Eiwodetianna on 16/11/1.
//  Copyright © 2016年 RabbitSaid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSDRequest.h"
#import "RSDResponse.h"
#import "RSDServer.h"

#pragma mark -- 获取API所需基本设置
@protocol RSDRequestDelegate <NSObject>

@optional

/**
 *  设置请求路径，默认为nil
 */
- (NSString *)requestPath;

/**
 *  设置HTTP Method，默认为RSDRequestMethodTypeGET
 */
- (RSDRequestMethodType)requestMethodType;

/**
 *  设置请求时需要的参数
 */
- (NSDictionary *)requestParameters;

/**
 *  设置是否读取缓存数据，如果为YES则可以缓存
 */
- (BOOL)shouldFetchCachedData;

/**
 *  服务器类型
 */
- (RSDServerType)serverType;

- (NSDictionary *)requestHeaders;

@end



@protocol RSDRequestUploadDelegate <NSObject>

@required
- (NSDictionary<NSString *, NSArray<NSData *> *> *)uploadFormData;

@end


/** 请求成功的Block */
typedef void(^RSDRequestSuccessBlock)(RSDResponse *responseObject);
/** 请求失败的Block */
typedef void(^RSDRequestFailedBlock)(RSDResponse *responseObject);


@interface RSDBaseAPIManager : NSObject
<
RSDRequestDelegate,
RSDResponseCustomParseDelegate
>

@property (nonatomic, strong, readonly) NSArray *requstList;

/**
 *  发送请求
 *
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 *
 *  @return 本次请求对应的requestID
 */

- (RSDRequest *)startLoadWithSuccess:(RSDRequestSuccessBlock)success failure:(RSDRequestFailedBlock)failure;

/**
 *  取消request的所有请求
 */
- (void)cancelAllRequest;

@end
