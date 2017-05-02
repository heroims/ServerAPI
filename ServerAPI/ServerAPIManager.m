//
//  ServerAPIManager.m
//  ServerAPIDemo
//
//  Created by Zhao Yiqi on 2016/12/2.
//  Copyright © 2016年 Zhao Yiqi. All rights reserved.
//

#import "ServerAPIManager.h"

@implementation ServerAPIManager

static ServerAPIManager *sharedInstanceServerAPIManager=nil;

+(instancetype)sharedServerAPIManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstanceServerAPIManager=[[[self class] alloc] init];
    });
    return sharedInstanceServerAPIManager;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstanceServerAPIManager=[super allocWithZone:zone];
    });
    return sharedInstanceServerAPIManager;
}

-(NSMutableDictionary*)apiRequests{
    if (_apiRequests==nil) {
        _apiRequests=[[NSMutableDictionary alloc] init];
    }
    return _apiRequests;
}

-(NSMutableArray*)apiRequestIDs{
    if (_apiRequestIDs==nil) {
        _apiRequestIDs=[[NSMutableArray alloc] init];
    }
    return _apiRequestIDs;
}

-(void)addRequestWithServerAPI:(ServerAPI*)api{
    if (api&&api.requestID) {
        [self.apiRequests setObject:api forKey:api.requestID];
        [self.apiRequestIDs addObject:api.requestID];
    }
}

-(void)removeRequestWithServerAPI:(ServerAPI*)api{
    if (api&&api.requestID) {
        [self.apiRequests removeObjectForKey:api.requestID];
        [self.apiRequestIDs removeObject:api.requestID];
    }
}

#pragma mark - ServerAPIManagerRequestOptionalProtocol

-(void)cancelRequestWithRequestID:(NSString*)requestID{
    ServerAPI *api=self.apiRequests[requestID];
    [self cancelRequestWithAPI:api];
}

-(void)cancelRequestWithRequestsTag:(NSString*)requestsTag{
    if (requestsTag) {
        for (ServerAPI *api in self.apiRequests.allValues) {
            if (api.requestTag&&[api.requestTag isEqualToString:requestsTag]) {
                [self cancelRequestWithAPI:api];
            }
        }
    }
}

-(void)cancelRequestWithRequestIDList:(NSArray*)requestList{
    for (NSString *requestID in requestList) {
        [self cancelRequestWithRequestID:requestID];
    }
}

-(void)cancelRequestWithAPIList:(NSArray*)requestList{
    for (ServerAPI *api in requestList) {
        [self cancelRequestWithAPI:api];
    }
}

-(void)cancelLastRequest{
    ServerAPI *api=self.apiRequests[self.apiRequestIDs.lastObject];
    [self cancelRequestWithAPI:api];
}

-(void)cancelFirstRequest{
    ServerAPI *api=self.apiRequests[self.apiRequestIDs.firstObject];
    [self cancelRequestWithAPI:api];
}

@end
