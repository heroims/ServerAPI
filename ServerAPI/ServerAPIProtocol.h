//
//  ServerAPIProtocol.h
//  ServerAPIDemo
//
//  Created by Zhao Yiqi on 2016/12/1.
//  Copyright © 2016年 Zhao Yiqi. All rights reserved.
//

//通过Category对ServerAPI实现对应的协议

@class ServerAPI;
@class ServerResult;
@class ServerError;

typedef void  (^sap_requestFailHandle)(ServerResult *result, NSError* errInfo);
typedef void  (^sap_requestSuccessHandle)(ServerResult *result);

#pragma mark - 必须实现的协议
@protocol ServerAPIManagerRequestProtocol <NSObject>

@required

/**
 发起请求逻辑实现 方便用AFN，ASI或自己写
 
 @param api 请求描述的ServerAPI
 @param completion 请求回调
 @param progressHandle 请求进度
 */
-(void)requestDataWithAPI:(ServerAPI*)api completion:(sap_requestCompletion)completion progressHandle:(sap_progressHandle)progressHandle;

/**
 取消一个请求
 
 @param api 请求描述的ServerAPI
 */
-(void)cancelRequestWithAPI:(ServerAPI*)api;

@optional

/**
 发起请求逻辑实现 方便用AFN，ASI或自己写
 
 @param api 请求描述的ServerAPI
 @param successHandle 请求成功回调
 @param failHandle 请求失败回调
 @param progressHandle 请求进度
 */
-(void)requestDataWithAPI:(ServerAPI*)api successHandle:(sap_requestSuccessHandle)successHandle failHandle:(sap_requestFailHandle)failHandle progressHandle:(sap_progressHandle)progressHandle;


/**
 根据requestID取消一个请求
 
 @param requestID 请求唯一ID
 */
-(void)cancelRequestWithRequestID:(NSString*)requestID;

/**
 根据requestsTag取消某一类表示的请求
 
 @param requestsTag 请求分类标识
 */
-(void)cancelRequestWithRequestsTag:(NSString*)requestsTag;

/**
 根据requestID数组取消相关请求
 
 @param requestList requestID的数组
 */
-(void)cancelRequestWithRequestIDList:(NSArray*)requestList;

/**
 根据ServerAPI数组取消相关请求
 
 @param requestList ServerAPI的数组
 */
-(void)cancelRequestWithAPIList:(NSArray*)requestList;

/**
 取消最后一个请求
 */
-(void)cancelLastRequest;

/**
 取消第一个请求
 */
-(void)cancelFirstRequest;

@end

@protocol ServerErrorFormatProtocol <NSObject>

/**
 初始化服务器错误实体
 
 @param data 服务器错误数据源
 @return 服务器错误实体
 */
-(ServerError*)initFormatServerErrorWithData:(id)data;

@end

@protocol ServerErrorBaseToDoProtocol <NSObject>


/**
 服务器错误基础处理
 */
-(void)serverErrorBaseToDo;

@end


@protocol ServerAPIResponseProtocol <NSObject>

@required

/**
 请求结束时间   最好设置时放到responseFormatWithData方法内
 
 @return 请求结束时间
 */
-(NSDate *)endDate;

/**
 数据格式化处理
 
 @param data 数据源
 @param error 错误源
 @param completion 请求回调
 @param cacheData 缓存数据
 */
-(void)responseFormatWithData:(id)data error:(NSError*)error completion:(sap_requestCompletion)completion cacheData:(id)cacheData;
@optional

/**
 数据格式化后的处理 用于对ServerAPI实现Category加入部分业务逻辑
 
 @param result 格式化数据
 */
-(void)responseCustomDoInCategoryWithResult:(ServerResult*)result;

@end

#pragma mark - 可选协议
@protocol ServerAPIManagerCacheProtocol <NSObject>

@optional

/**
 拉取缓存数据
 
 @param api 请求描述的ServerAPI
 @param completion 请求回调
 @param error 错误信息
 @return 缓存有无
 */
-(BOOL)fetchDataCacheWithAPI:(ServerAPI*)api completion:(sap_requestCompletion)completion error:(NSError*)error;

/**
 拉取缓存数据
 
 @param api 请求描述的ServerAPI
 @param successHandle 请求成功回调
 @param failHandle 请求失败回调
 @param error 错误信息
 @return 缓存有无
 */
-(BOOL)fetchDataCacheWithAPI:(ServerAPI*)api successHandle:(sap_requestCompletion)successHandle failHandle:(sap_requestFailHandle)failHandle error:(NSError*)error;

/**
 保存缓存
 
 @param api 请求描述的ServerAPI
 */
-(void)saveDataCacheWithResult:(ServerAPI*)api;
@end

/**
 与ServerAPIRequstProtocol的协议有重叠主要用于内部封装逻辑
 */
@protocol ServerAPIRequstOptionalProtocol <NSObject>

@optional
-(void)requestDataWithSuccessHandle:(sap_requestCompletion)successHandle failHandle:(sap_requestFailHandle)failHandle;

+(ServerAPI*)newRequestDataWithSuccessHandle:(sap_requestSuccessHandle)successHandle failHandle:(sap_requestFailHandle)failHandle;

@end

/**
 与ServerAPIManagerRequestProtocol的协议有重叠主要用于内部封装逻辑
 */
@protocol ServerAPIManagerRequestOptionalProtocol <NSObject>

@optional
-(void)requestDataWithAPI:(ServerAPI*)api completion:(sap_requestCompletion)completion progressHandle:(sap_progressHandle)progressHandle;

-(void)requestDataWithAPI:(ServerAPI*)api successHandle:(sap_requestSuccessHandle)successHandle failHandle:(sap_requestFailHandle)failHandle;

-(void)cancelRequestWithAPI:(ServerAPI*)api;
-(void)cancelRequestWithRequestID:(NSString*)requestID;
-(void)cancelRequestWithRequestsTag:(NSString*)requestsTag;
-(void)cancelRequestWithRequestIDList:(NSArray*)requestList;
-(void)cancelRequestWithAPIList:(NSArray*)requestList;
-(void)cancelLastRequest;
-(void)cancelFirstRequest;

@end
