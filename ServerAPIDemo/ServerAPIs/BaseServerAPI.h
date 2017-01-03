//
//  BaseServerAPI.h
//  ServerAPIDemo
//
//  Created by Zhao Yiqi on 2016/12/5.
//  Copyright © 2016年 Zhao Yiqi. All rights reserved.
//

#import "ServerAPI.h"
#import "ServerAPI+Demo.h"

//网络配置宏最好单独抽出一个地方维护
#define TIMEOUT_HTTPREQUEST 30 //网络请求超时时间
#define BASE_URL @"http://xxx.xxx.xxx"

@interface BaseServerAPI : ServerAPI

@end
