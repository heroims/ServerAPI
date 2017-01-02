//
//  ServerResult.h
//  xgoods
//
//  Created by admin on 2016/12/2.
//  Copyright © 2016年 Look. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ServerAPI;

typedef enum ServerResultStatus:NSInteger{
    ServerResultStatus_Success=0,//默认只代表请求成功，可通过扩展代表更深层的意义
    ServerResultStatus_ErrorNoNetwork,//网络请求失败，包括各类未知情况
    ServerResultStatus_ErrorTimeout,//请求超时
    ServerResultStatus_ErrorServerAPI,//服务器错误，在实现responseFormatWithData协议时根据个人需求设置此状态
}ServerResultStatus;

@interface ServerResult : NSObject

@property(nonatomic,strong)id originData;
@property(nonatomic,strong)id formatData;

@property(nonatomic,assign)ServerResultStatus status;

@property(nonatomic,strong)NSError *error;//传入error会自动改变status

@property(nonatomic,strong)ServerAPI *api;

@end
