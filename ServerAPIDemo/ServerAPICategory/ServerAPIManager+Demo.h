//
//  ServerAPIManager+Demo.h
//  ServerAPIDemo
//
//  Created by Zhao Yiqi on 2017/1/3.
//  Copyright © 2017年 Zhao Yiqi. All rights reserved.
//

#import "ServerAPIManager.h"
#import "ServerAPIProtocol.h"

@interface ServerAPIManager (Demo)<ServerAPIManagerRequestProtocol,ServerAPIManagerCacheProtocol>

@end
