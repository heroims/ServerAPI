//
//  ServerAPIManager.h
//  xgoods
//
//  Created by admin on 2016/12/2.
//  Copyright © 2016年 Look. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerAPI.h"
#import "ServerAPIProtocol.h"

@interface ServerAPIManager : NSObject<ServerAPIManagerRequestOptionalProtocol>

+ (instancetype)sharedServerAPIManager;

/**
 请求字典key对应requestID  value对应ServerAPI
 */
@property(nonatomic,strong)NSMutableDictionary *apiRequests;

/**
 请求requestID数组按先进先出顺序排列
 */
@property(nonatomic,strong)NSMutableArray *apiRequestIDs;


/**
 添加 删除记录的ServerAPI
 在发起请求和解析数据时分别调用
 */
-(void)addRequestWithServerAPI:(ServerAPI*)api;
-(void)removeRequestWithServerAPI:(ServerAPI*)api;

@end
