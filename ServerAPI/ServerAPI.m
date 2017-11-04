//
//  APIManager.m
//  ServerAPIDemo
//
//  Created by Zhao Yiqi on 2016/11/29.
//  Copyright © 2016年 Zhao Yiqi. All rights reserved.
//

#import "ServerAPI.h"
#import "ServerAPIManager.h"
#import <CommonCrypto/CommonDigest.h>

NSString *const UnkownRequestAPITag = @"UnkownTag";

@implementation ServerAPI{
    NSString *_requestID;
    NSDate *_startDate;
}

-(instancetype)init{
    if (self=[super init]) {
        self.requestTag=UnkownRequestAPITag;
        _requestID=[[NSUUID UUID] UUIDString];
    }
    return self;
}

-(void)requestDataWithCompletion:(sap_requestCompletion)completion{
    [self requestDataWithCompletion:completion progressHandle:nil];
}

-(void)requestDataWithCompletion:(sap_requestCompletion)completion progressHandle:(sap_progressHandle)progressHandle{
    [[ServerAPIManager sharedServerAPIManager] requestDataWithAPI:self completion:completion progressHandle:progressHandle];
    _requestID=[[NSUUID UUID] UUIDString];
    _startDate=[NSDate date];
}

-(void)cancelRequest{
    [[ServerAPIManager sharedServerAPIManager] cancelRequestWithAPI:self];
}

+(ServerAPI*)newRequestDataWithCompletion:(sap_requestCompletion)completion requestTag:(NSString*)requestTag{
    return [self newRequestDataWithCompletion:completion requestParameters:nil requestPathParameters:nil requestRequiredParameters:nil requestTag:requestTag];
}

+(ServerAPI*)newRequestDataWithCompletion:(sap_requestCompletion)completion requestParameters:(NSDictionary*)requestParameters requestTag:(NSString*)requestTag{
    return [self newRequestDataWithCompletion:completion requestParameters:requestParameters requestPathParameters:nil requestRequiredParameters:nil requestTag:requestTag];
}

+(ServerAPI*)newRequestDataWithCompletion:(sap_requestCompletion)completion requestParameters:(NSDictionary*)requestParameters requestPathParameters:(NSDictionary*)requestPathParameters requestTag:(NSString*)requestTag{
    return [self newRequestDataWithCompletion:completion requestParameters:requestParameters requestPathParameters:requestPathParameters requestRequiredParameters:nil requestTag:requestTag];
}

+(ServerAPI*)newRequestDataWithCompletion:(sap_requestCompletion)completion requestParameters:(NSDictionary*)requestParameters requestPathParameters:(NSDictionary*)requestPathParameters requestRequiredParameters:(NSDictionary*)requestRequiredParameters requestTag:(NSString*)requestTag{
    ServerAPI *api=[[self alloc] init];
    api.requestParameters=requestParameters;
    api.requestPathParameters=requestPathParameters;
    api.requestRequiredParameters=requestRequiredParameters;
    api.requestTag=requestTag;
    [api requestDataWithCompletion:completion];
    return api;
}

#pragma mark - Getter and Setter
-(NSString *)requestID{
    return _requestID;
}

-(NSString *)cacheID{
    if (_accessType==APIAccessType_Get||_accessType==APIAccessType_Post) {
        NSString *cacheLongID=_requestURL?_requestURL:self.fullRequestURL;
        
        NSURL *requestUrl=[NSURL URLWithString:cacheLongID];
        NSString *urlQuery=requestUrl.query;
        NSMutableArray *queryArr=[NSMutableArray arrayWithArray:[urlQuery componentsSeparatedByString:@"&"]];
        NSArray *sortQueryArr=[queryArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2 options:NSNumericSearch];
        }];
        
        urlQuery=[sortQueryArr componentsJoinedByString:@"&"];
        
        NSArray *requestUrlStrArr=[self.fullRequestURL componentsSeparatedByString:@"?"];
        
        
        cacheLongID=[NSString stringWithFormat:@"%@?%@",(requestUrlStrArr!=nil&&requestUrlStrArr.count>0)?requestUrlStrArr[0]:@"",urlQuery];
        
        if(!self || 0 == [cacheLongID length])
        {
            return nil;
        }
        
        const char *value = [cacheLongID UTF8String];
        
        unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
        CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
        
        NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
        for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++)
        {
            [outputString appendFormat:@"%02x",outputBuffer[count]];
        }
        
        return [outputString substringToIndex:8];
    }
    return self.requestID;
}

-(NSString *)fullRequestURL{
    NSString *_fullRequestURL=nil;
    
    if ([self.fullRequestPath hasPrefix:@"/"]||[self.requestHost hasSuffix:@"/"]) {
        _fullRequestURL=[NSString stringWithFormat:@"%@%@",self.requestHost?self.requestHost:@"",self.fullRequestPath];
    }
    else{
        _fullRequestURL=[NSString stringWithFormat:@"%@/%@",self.requestHost?self.requestHost:@"",self.fullRequestPath];
    }
    return _fullRequestURL;
}

-(NSString *)fullRequestPath{
    NSString *_fullRequestPath=self.requestPath?self.requestPath:@"";
    for (NSString *pathParameterKey in self.requestPathParameters.allKeys) {
        [_fullRequestPath stringByReplacingOccurrencesOfString:pathParameterKey withString:self.requestPathParameters[pathParameterKey]];
    }
    for (NSString *parameterKey in _requestParameters.allKeys) {
        if ([_fullRequestPath rangeOfString:@"?"].location==NSNotFound) {
            _fullRequestPath=[NSString stringWithFormat:@"%@?%@=%@",_fullRequestPath,parameterKey?parameterKey:@"",self.requestParameters[parameterKey]?self.requestParameters[parameterKey]:@""];
        }
        else{
            _fullRequestPath=[NSString stringWithFormat:@"%@&%@=%@",_fullRequestPath,parameterKey?parameterKey:@"",self.requestParameters[parameterKey]?self.requestParameters[parameterKey]:@""];
        }
    }
    return _fullRequestPath;
}

-(NSString*)requestURL{
    if (_requestURL) {
        return _requestURL;
    }
    
    NSString *requestURL=nil;
    if ([self.fullRequestPath hasPrefix:@"/"]||[self.requestHost hasSuffix:@"/"]) {
        requestURL=[NSString stringWithFormat:@"%@%@",self.requestHost?self.requestHost:@"",self.requestPath];
    }
    else{
        requestURL=[NSString stringWithFormat:@"%@/%@",self.requestHost?self.requestHost:@"",self.requestPath];
    }
    for (NSString *pathParameterKey in self.requestPathParameters.allKeys) {
        requestURL=[requestURL stringByReplacingOccurrencesOfString:pathParameterKey withString:self.requestPathParameters[pathParameterKey]];
    }
    
    return requestURL;
}

-(NSDictionary *)requestAllParameters{
    NSMutableDictionary *tmpRequestParameters=[NSMutableDictionary dictionaryWithDictionary:_requestParameters];
    NSArray *tmpUrlQuery=[self.requestURL componentsSeparatedByString:@"?"];
    if (tmpUrlQuery.count>1) {
        NSArray *tmpQuery=[tmpUrlQuery[1] componentsSeparatedByString:@"&"];
        for (NSString *keyValueString in tmpQuery) {
            NSArray *tmpKeyValue=[keyValueString componentsSeparatedByString:@"="];
            if (tmpKeyValue.count>1) {
                if (tmpRequestParameters[tmpKeyValue[0]]==nil) {
                    [tmpRequestParameters setObject:tmpKeyValue[1] forKey:tmpKeyValue[0]];
                }
            }
        }
    }
    return [NSDictionary dictionaryWithDictionary:tmpRequestParameters];
}

-(NSDate *)startDate{
    return _startDate;
}

@end
