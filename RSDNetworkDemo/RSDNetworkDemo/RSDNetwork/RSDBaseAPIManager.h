//
//  RSDBaseAPIManager.h
//  RSDNetwork
//
//  Created by Eiwodetianna on 16/11/1.
//  Copyright © 2016年 RabbitSaid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSDAPIManagerProtocol.h"

@interface RSDBaseAPIManager : NSObject
<
RSDRequestDelegate,
RSDResponseCustomParseDelegate
>


@end
