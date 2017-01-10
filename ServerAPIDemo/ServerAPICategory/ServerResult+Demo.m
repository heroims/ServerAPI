//
//  ServerResult+Demo.m
//  ServerAPIDemo
//
//  Created by Zhao Yiqi on 2017/1/3.
//  Copyright © 2017年 Zhao Yiqi. All rights reserved.
//

#import "ServerResult+Demo.h"

@implementation ServerResult (Demo)

-(NSString *)errorMessage{
    switch (self.status) {
            case ServerResultStatus_Success:
            
            return nil;
            case ServerResultStatus_ErrorTimeout:
            
            return @"网络请求超时";
            case ServerResultStatus_ErrorNoNetwork:
            
            return @"网络异常请检查网络";
            case ServerResultStatus_ErrorServerAPI:
            return @"服务器未知错误";
        default:
            return @"网络异常请检查网络";
    }
}

//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [self yy_modelEncodeWithCoder:aCoder];
//}
//
//- (id)initWithCoder:(NSCoder *)aDecoder {
//    return [self yy_modelInitWithCoder:aDecoder];
//}
//
//- (id)copyWithZone:(NSZone *)zone {
//    return [self yy_modelCopy];
//}

@end
