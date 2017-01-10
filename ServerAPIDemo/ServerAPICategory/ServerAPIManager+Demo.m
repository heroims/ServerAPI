//
//  ServerAPIManager+Demo.m
//  ServerAPIDemo
//
//  Created by Zhao Yiqi on 2017/1/3.
//  Copyright © 2017年 Zhao Yiqi. All rights reserved.
//

#import "ServerAPIManager+Demo.h"
//#import "YYCache.h"
//
//#import "AFHTTPSessionManager.h"

@implementation ServerAPIManager (Demo)
//
//NSString * const apiCacheName = @"";
//
//static NSTimeInterval cacheTime = 1;
//
//static NSTimeInterval memoryCacheTime = 5*60;
//
//static NSInteger sessionManagerConcurrency = 30;
//
//AFHTTPSessionManager *sessionManager;
//AFSecurityPolicy *securityPolicy;
//AFJSONResponseSerializer *jsonResponseSerializer;
//AFHTTPResponseSerializer *httpResponseSerializer;
//AFXMLParserResponseSerializer *xmlParserResponseSerializer;
//AFJSONRequestSerializer *jsonRequestSerializer;
//AFHTTPRequestSerializer *httpRequestSerializer;

-(BOOL)fetchDataCacheWithAPI:(ServerAPI *)api completion:(sap_requestCompletion)completion error:(NSError*)error{
//    YYCache *cache=[[YYCache alloc] initWithName:[api isKindOfClass:NSClassFromString(@"AnalyticsAPI")]?apiStatCacheName:apiCacheName];
//    cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning=YES;
//    cache.memoryCache.autoTrimInterval=memoryCacheTime;
//    cache.diskCache.autoTrimInterval=[api isKindOfClass:NSClassFromString(@"AnalyticsAPI")]?statCacheTime:cacheTime;
//    
//    ServerResult *cacheData=nil;
//    @try {
//        cacheData=[NSKeyedUnarchiver unarchiveObjectWithData:(NSData*)[cache objectForKey:api.cacheID]];
//    } @catch (NSException *exception) {
//        
//    } @finally {
//        
//    }
//    
//    if (cacheData) {
//        cacheData.error=error;
//        [api responseFormatWithData:cacheData.originData error:error completion:completion cacheData:cacheData];
//        return true;
//    }
    return false;
}

-(void)saveDataCacheWithResult:(ServerResult *)result{
//    YYCache *cache=[[YYCache alloc] initWithName:[result.api isKindOfClass:NSClassFromString(@"AnalyticsAPI")]?apiStatCacheName:apiCacheName];
//    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:result];
//    
//    [cache setObject:data forKey:result.api.cacheID];
    
}

-(void)requestDataWithAPI:(ServerAPI *)api completion:(sap_requestCompletion)completion progressHandle:(sap_progressHandle)progressHandle{
    NSInteger retryTimes=api.retryTimes;
    [self requestDataWithAPI:api completion:completion progressHandle:progressHandle retryTimes:retryTimes];
}

-(void)requestDataWithAPI:(ServerAPI *)api completion:(sap_requestCompletion)completion progressHandle:(sap_progressHandle)progressHandle retryTimes:(NSInteger)retryTimes {
//    [self getSessionManager];
//    
//    [sessionManager setSecurityPolicy:securityPolicy];
//    sessionManager.requestSerializer.timeoutInterval = api.timeOut;
//    [self addHttpHeaders:sessionManager api:api];
//    
//    switch (api.resultFormat) {
//        case APIResultFormat_JSON:
//            sessionManager.responseSerializer = jsonResponseSerializer;
//            break;
//        case APIResultFormat_Data:
//            sessionManager.responseSerializer = httpResponseSerializer;
//            break;
//        case APIResultFormat_XML:
//            sessionManager.responseSerializer = xmlParserResponseSerializer;
//        default:
//            sessionManager.responseSerializer = httpResponseSerializer;
//            break;
//    }
//    
//    if (api.completionQueue) {
//        sessionManager.completionQueue=api.completionQueue;
//    }
//    if (api.completionGroup) {
//        sessionManager.completionGroup=api.completionGroup;
//    }
//    if (api.completionGroup) {
//        dispatch_group_enter(api.completionGroup);
//    }
//    
//    if (api.shouldCache) {
//        if ([self fetchDataCacheWithAPI:api completion:completion error:nil]) {
//            return;
//        }
//    }
//    
//    __block NSInteger tmpRetryTimes=retryTimes;
//    
//    @autoreleasepool {
//        __block ServerAPI *copyApi=[api copy];
//        
//        [self addRequestWithServerAPI:copyApi];
//        
//        switch (copyApi.accessType) {
//            case APIAccessType_Get:{
//                copyApi.originRequest=[sessionManager GET:copyApi.requestURL parameters:copyApi.requestParameters progress:^(NSProgress * _Nonnull downloadProgress) {
//                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                    [copyApi responseFormatWithData:responseObject error:nil completion:completion cacheData:nil];
//                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                    if (error.code==NSURLErrorBadURL) {
//                        if (tmpRetryTimes>0) {
//                            tmpRetryTimes--;
//                            [self requestDataWithAPI:copyApi completion:completion progressHandle:progressHandle retryTimes:tmpRetryTimes];
//                            return ;
//                        }
//                        if (copyApi.retryFilter) {
//                            if (copyApi.retryFilter()) {
//                                [self requestDataWithAPI:copyApi completion:completion progressHandle:progressHandle];
//                                return;
//                            }
//                        }
//                    }
//                    
//                    if (copyApi.shouldCache) {
//                        if ([self fetchDataCacheWithAPI:copyApi completion:completion error:error]) {
//                            return;
//                        }
//                    }
//                    
//                    [copyApi responseFormatWithData:nil error:error completion:completion cacheData:nil];
//                }];
//                
//                break;
//            }
//            case APIAccessType_Post:{
//                copyApi.originRequest=[sessionManager POST:copyApi.requestURL parameters:copyApi.requestParameters progress:^(NSProgress * _Nonnull uploadProgress) {
//                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                    [copyApi responseFormatWithData:responseObject error:nil completion:completion cacheData:nil];
//                    
//                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                    if (error.code==NSURLErrorBadURL) {
//                        if (tmpRetryTimes>0) {
//                            tmpRetryTimes--;
//                            [self requestDataWithAPI:copyApi completion:completion progressHandle:progressHandle retryTimes:tmpRetryTimes];
//                            return ;
//                        }
//                        if (copyApi.retryFilter) {
//                            if (copyApi.retryFilter()) {
//                                [self requestDataWithAPI:copyApi completion:completion progressHandle:progressHandle];
//                                return;
//                            }
//                        }
//                    }
//                    
//                    if (copyApi.shouldCache) {
//                        if ([self fetchDataCacheWithAPI:copyApi completion:completion error:error]) {
//                            return;
//                        }
//                    }
//                    
//                    [copyApi responseFormatWithData:nil error:error completion:completion cacheData:nil];
//                }];
//                
//                break;
//            }
//            case APIAccessType_PostJSON:{
//                copyApi.originRequest=[sessionManager POST:copyApi.requestURL parameters:copyApi.requestParameters progress:^(NSProgress * _Nonnull uploadProgress) {
//                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                    [copyApi responseFormatWithData:responseObject error:nil completion:completion cacheData:nil];
//                    
//                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                    if (error.code==NSURLErrorBadURL) {
//                        if (tmpRetryTimes>0) {
//                            tmpRetryTimes--;
//                            [self requestDataWithAPI:copyApi completion:completion progressHandle:progressHandle retryTimes:tmpRetryTimes];
//                            return ;
//                        }
//                        if (copyApi.retryFilter) {
//                            if (copyApi.retryFilter()) {
//                                [self requestDataWithAPI:copyApi completion:completion progressHandle:progressHandle];
//                                return;
//                            }
//                        }
//                    }
//                    
//                    if (copyApi.shouldCache) {
//                        if ([self fetchDataCacheWithAPI:copyApi completion:completion error:error]) {
//                            return;
//                        }
//                    }
//                    
//                    [copyApi responseFormatWithData:nil error:error completion:completion cacheData:nil];
//                }];
//                
//                break;
//            }
//            case APIAccessType_Upload:{
//                copyApi.originRequest=[sessionManager POST:copyApi.requestURL parameters:copyApi.requestParameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//                    [formData appendPartWithFileData:[(BaseServerAPI*)copyApi uploadData] name:[(BaseServerAPI*)copyApi uploadFileName] fileName:[(BaseServerAPI*)copyApi uploadFileName] mimeType:[(BaseServerAPI*)copyApi uploadFileType]];
//                    
//                } progress:^(NSProgress * _Nonnull uploadProgress) {
//                    if (progressHandle!=nil&&uploadProgress!=nil) {
//                        progressHandle(1.*uploadProgress.totalUnitCount/uploadProgress.completedUnitCount);
//                    }
//                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                    [copyApi responseFormatWithData:responseObject error:nil completion:completion cacheData:nil];
//                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                    [copyApi responseFormatWithData:nil error:error completion:completion cacheData:nil];
//                }];
//                break;
//            }
//            case APIAccessType_Download:{
//                NSURLRequest*request = [NSURLRequest requestWithURL:[NSURL URLWithString:copyApi.fullRequestURL]];
//                copyApi.originRequest=[sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//                    if (progressHandle!=nil&&downloadProgress!=nil) {
//                        progressHandle(1.*downloadProgress.totalUnitCount/downloadProgress.completedUnitCount);
//                    }
//                } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//                    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:response.suggestedFilename];
//                    return [NSURL fileURLWithPath:path];
//                } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//                    NSData *fileData=[NSData dataWithContentsOfURL:filePath];
//                    NSString *downloadPath=[(BaseServerAPI*)copyApi downloadFilePath];
//                    if ([[NSFileManager defaultManager] fileExistsAtPath:downloadPath]) {
//                        [[NSFileManager defaultManager] removeItemAtPath:downloadPath error:nil];
//                    }
//                    [fileData writeToFile:downloadPath atomically:NO];
//                    [[NSFileManager defaultManager] removeItemAtPath:filePath.path error:nil];
//                    [copyApi responseFormatWithData:fileData error:error completion:completion cacheData:nil];
//                    
//                }];
//                [copyApi.originRequest resume];
//                break;
//            }
//            default:
//                break;
//        }
//    }
}

-(void)cancelRequestWithAPI:(ServerAPI*)api{
    [(NSURLSessionTask*)api.originRequest cancel];
}



#pragma mark - 加密
//-(void)addHttpHeaders:(AFHTTPSessionManager*)manager api:(ServerAPI*)api{
//    switch (api.accessType) {
//        case APIAccessType_PostJSON:
//            manager.requestSerializer = jsonRequestSerializer;
//            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//            break;
//            
//        default:
//            manager.requestSerializer = httpRequestSerializer;
//            break;
//    }
//    
//    
//}

#pragma mark - AFNetWorking 对象创建条件优化
//-(AFHTTPSessionManager*)getSessionManager{
//    if (!sessionManager||self.apiRequestIDs.count>sessionManagerConcurrency) {
//        sessionManager = [AFHTTPSessionManager manager];
//    }
//    
//    [self getSecurityPolicy];
//    [self getHttpResponseSerializer];
//    [self getJsonResponseSerializer];
//    [self getXmlParserResponseSerializer];
//    [self getJsonRequestSerializer];
//    [self getHttpRequestSerializer];
//    
//    sessionManager.completionQueue=nil;
//    sessionManager.completionGroup=nil;
//    
//    return sessionManager;
//}
//
//-(AFSecurityPolicy*)getSecurityPolicy{
//    if (!securityPolicy||self.apiRequestIDs.count>sessionManagerConcurrency) {
//        securityPolicy = [AFSecurityPolicy defaultPolicy];
//    }
//    return securityPolicy;
//}
//
//-(AFJSONResponseSerializer*)getJsonResponseSerializer{
//    if (!jsonResponseSerializer||self.apiRequestIDs.count>sessionManagerConcurrency) {
//        jsonResponseSerializer = [AFJSONResponseSerializer serializer];
//    }
//    return jsonResponseSerializer;
//}
//
//-(AFHTTPResponseSerializer*)getHttpResponseSerializer{
//    if (!httpResponseSerializer||self.apiRequestIDs.count>sessionManagerConcurrency) {
//        httpResponseSerializer = [AFHTTPResponseSerializer serializer];
//    }
//    return httpResponseSerializer;
//}
//
//-(AFXMLParserResponseSerializer*)getXmlParserResponseSerializer{
//    if (!xmlParserResponseSerializer||self.apiRequestIDs.count>sessionManagerConcurrency) {
//        xmlParserResponseSerializer = [AFXMLParserResponseSerializer serializer];
//    }
//    return xmlParserResponseSerializer;
//}
//
//-(AFJSONRequestSerializer*)getJsonRequestSerializer{
//    if (!jsonRequestSerializer||self.apiRequestIDs.count>sessionManagerConcurrency) {
//        jsonRequestSerializer = [AFJSONRequestSerializer serializer];
//    }
//    return jsonRequestSerializer;
//}
//
//-(AFHTTPRequestSerializer*)getHttpRequestSerializer{
//    if (!httpRequestSerializer||self.apiRequestIDs.count>sessionManagerConcurrency) {
//        httpRequestSerializer = [AFHTTPRequestSerializer serializer];
//    }
//    return httpRequestSerializer;
//}

@end
