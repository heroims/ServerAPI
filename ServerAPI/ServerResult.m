//
//  ServerResult.m
//  ServerAPIDemo
//
//  Created by Zhao Yiqi on 2016/12/2.
//  Copyright © 2016年 Zhao Yiqi. All rights reserved.
//

#import "ServerResult.h"

NSInteger ServerError_NoError=-99999;

@implementation ServerError

@end

@implementation ServerResult

-(void)setError:(NSError *)error{
    _error=error;
    if (error.code==NSURLErrorTimedOut) {
        _status=ServerResultStatus_ErrorTimeout;
    }
    else{
        _status=ServerResultStatus_ErrorNoNetwork;
    }
}

-(void)setServerError:(ServerError *)serverError{
    _serverError=serverError;
    _status=ServerResultStatus_ErrorServerAPI;
}

@end
