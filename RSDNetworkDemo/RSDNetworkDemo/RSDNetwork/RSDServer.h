//
//  RSDServer.h
//  RSDNetwork
//
//  Created by Eiwodetianna on 16/11/1.
//  Copyright © 2016年 RabbitSaid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSDNetworkConfiguration.h"


@interface RSDServer : NSObject

/**
 *  服务器类型
 */
@property (nonatomic) RSDServerType serverType;
/**
 *  服务器地址
 */
@property (nonatomic, copy, readonly) NSString *url;

+ (RSDServer *)serverType:(RSDServerType)serverType;

@end
