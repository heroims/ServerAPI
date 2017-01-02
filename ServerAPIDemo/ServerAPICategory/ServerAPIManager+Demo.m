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

-(BOOL)fetchDataCacheWithAPI:(ServerAPI *)api completion:(sap_requestCompletion)completion error:(NSError*)error{
//    YYCache *cache=[[YYCache alloc] initWithName:apiCacheName];
//    cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning=YES;
//    ServerResult *cacheData=[ServerResult yy_modelWithJSON:[cache objectForKey:api.cacheID]];
//    if (error==nil) {
//        if ([api.startDate timeIntervalSince1970]-[cacheData.api.endDate timeIntervalSince1970]>cacheTime) {
//            return false;
//        }
//    }
//    if (cacheData) {
//        cacheData.error=error;
//        [api responseFormatWithData:cacheData.originData error:error completion:completion cacheData:cacheData];
//        return true;
//    }
    return false;
}

-(void)saveDataCacheWithResult:(ServerResult *)result{
//    YYCache *cache=[[YYCache alloc] initWithName:apiCacheName];
//    [cache setObject:[result yy_modelToJSONData] forKey:result.api.cacheID];
    
}

-(void)requestDataWithAPI:(ServerAPI *)api completion:(sap_requestCompletion)completion progressHandle:(sap_progressHandle)progressHandle{
    NSInteger retryTimes=api.retryTimes;
    [self requestDataWithAPI:api completion:completion progressHandle:progressHandle retryTimes:retryTimes];
}

-(void)requestDataWithAPI:(ServerAPI *)api completion:(sap_requestCompletion)completion progressHandle:(sap_progressHandle)progressHandle retryTimes:(NSInteger)retryTimes {
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    [manager setSecurityPolicy:[AFSecurityPolicy defaultPolicy]];
//    manager.requestSerializer.timeoutInterval = api.timeOut;
//    [self addHttpHeaders:manager api:api];
//    [self addRequestWithServerAPI:api];
//    
//    switch (api.resultFormat) {
//            case APIResultFormat_JSON:
//            manager.responseSerializer = [AFJSONResponseSerializer serializer];
//            break;
//            case APIResultFormat_Data:
//            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//            break;
//            case APIResultFormat_XML:
//            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
//        default:
//            break;
//    }
//    
//    if (api.completionQueue) {
//        manager.completionQueue=api.completionQueue;
//    }
//    if (api.completionGroup) {
//        manager.completionGroup=api.completionGroup;
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
//    switch (api.accessType) {
//            case APIAccessType_Get:{
//                api.originRequest=[manager GET:api.requestURL parameters:api.requestParameters progress:^(NSProgress * _Nonnull downloadProgress) {
//                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                    [api responseFormatWithData:responseObject error:nil completion:completion cacheData:nil];
//                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                    if (error.code==NSURLErrorBadURL) {
//                        if (tmpRetryTimes>0) {
//                            tmpRetryTimes--;
//                            [self requestDataWithAPI:api completion:completion progressHandle:progressHandle retryTimes:tmpRetryTimes];
//                            return ;
//                        }
//                        if (api.retryFilter) {
//                            if (api.retryFilter()) {
//                                [self requestDataWithAPI:api completion:completion progressHandle:progressHandle];
//                                return;
//                            }
//                        }
//                    }
//                    
//                    if (api.shouldCache) {
//                        if ([self fetchDataCacheWithAPI:api completion:completion error:error]) {
//                            return;
//                        }
//                    }
//                    
//                    [api responseFormatWithData:nil error:error completion:completion cacheData:nil];
//                }];
//                
//                break;
//            }
//            case APIAccessType_Post:{
//                api.originRequest=[manager POST:api.requestURL parameters:api.requestParameters progress:^(NSProgress * _Nonnull uploadProgress) {
//                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                    [api responseFormatWithData:responseObject error:nil completion:completion cacheData:nil];
//                    
//                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                    if (error.code==NSURLErrorBadURL) {
//                        if (tmpRetryTimes>0) {
//                            tmpRetryTimes--;
//                            [self requestDataWithAPI:api completion:completion progressHandle:progressHandle retryTimes:tmpRetryTimes];
//                            return ;
//                        }
//                        if (api.retryFilter) {
//                            if (api.retryFilter()) {
//                                [self requestDataWithAPI:api completion:completion progressHandle:progressHandle];
//                                return;
//                            }
//                        }
//                    }
//                    
//                    if (api.shouldCache) {
//                        if ([self fetchDataCacheWithAPI:api completion:completion error:error]) {
//                            return;
//                        }
//                    }
//                    
//                    [api responseFormatWithData:nil error:error completion:completion cacheData:nil];
//                }];
//                
//                break;
//            }
//            case APIAccessType_PostJSON:{
//                api.originRequest=[manager POST:api.requestURL parameters:api.requestParameters progress:^(NSProgress * _Nonnull uploadProgress) {
//                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                    [api responseFormatWithData:responseObject error:nil completion:completion cacheData:nil];
//                    
//                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                    if (error.code==NSURLErrorBadURL) {
//                        if (tmpRetryTimes>0) {
//                            tmpRetryTimes--;
//                            [self requestDataWithAPI:api completion:completion progressHandle:progressHandle retryTimes:tmpRetryTimes];
//                            return ;
//                        }
//                        if (api.retryFilter) {
//                            if (api.retryFilter()) {
//                                [self requestDataWithAPI:api completion:completion progressHandle:progressHandle];
//                                return;
//                            }
//                        }
//                    }
//                    
//                    if (api.shouldCache) {
//                        if ([self fetchDataCacheWithAPI:api completion:completion error:error]) {
//                            return;
//                        }
//                    }
//                    
//                    [api responseFormatWithData:nil error:error completion:completion cacheData:nil];
//                }];
//                
//                break;
//            }
//            case APIAccessType_Upload:{
//                api.originRequest=[manager POST:api.requestURL parameters:api.requestParameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//                    [formData appendPartWithFileData:[(BaseServerAPI*)api uploadData] name:[(BaseServerAPI*)api uploadFileName] fileName:[(BaseServerAPI*)api uploadFileName] mimeType:[(BaseServerAPI*)api uploadFileType]];
//                    
//                } progress:^(NSProgress * _Nonnull uploadProgress) {
//                    if (progressHandle!=nil&&uploadProgress!=nil) {
//                        progressHandle(1.*uploadProgress.totalUnitCount/uploadProgress.completedUnitCount);
//                    }
//                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                    [api responseFormatWithData:responseObject error:nil completion:completion cacheData:nil];
//                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                    [api responseFormatWithData:nil error:error completion:completion cacheData:nil];
//                }];
//                break;
//            }
//            case APIAccessType_Download:{
//                NSURLRequest*request = [NSURLRequest requestWithURL:[NSURL URLWithString:api.fullRequestURL]];
//                api.originRequest=[manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//                    if (progressHandle!=nil&&downloadProgress!=nil) {
//                        progressHandle(1.*downloadProgress.totalUnitCount/downloadProgress.completedUnitCount);
//                    }
//                } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//                    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:response.suggestedFilename];
//                    return [NSURL fileURLWithPath:path];
//                } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//                    NSData *fileData=[NSData dataWithContentsOfURL:filePath];
//                    NSString *downloadPath=[(BaseServerAPI*)api downloadFilePath];
//                    if ([[NSFileManager defaultManager] fileExistsAtPath:downloadPath]) {
//                        [[NSFileManager defaultManager] removeItemAtPath:downloadPath error:nil];
//                    }
//                    [fileData writeToFile:downloadPath atomically:NO];
//                    [[NSFileManager defaultManager] removeItemAtPath:filePath.path error:nil];
//                    [api responseFormatWithData:fileData error:error completion:completion cacheData:nil];
//                    
//                }];
//                [api.originRequest resume];
//                break;
//            }
//        default:
//            break;
//    }
}

-(void)cancelRequestWithAPI:(ServerAPI*)api{
    [(NSURLSessionTask*)api.originRequest cancel];
}



#pragma mark - 加密
//-(void)addHttpHeaders:(AFHTTPSessionManager*)manager api:(ServerAPI*)api{
//    switch (api.accessType) {
//            case APIAccessType_PostJSON:
//            manager.requestSerializer = [AFJSONRequestSerializer serializer];
//            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//            break;
//            
//        default:
//            break;
//    }
//    
//    //加密需要放入hedaer--begin--

//    //加密需要放入hedaer--end--
//    
//
//
//}

@end
