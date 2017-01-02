//
//  APIManager.h
//  xgoods
//
//  Created by admin on 2016/11/29.
//  Copyright © 2016年 Look. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerResult.h"

typedef enum APIAccessType:NSInteger{
    APIAccessType_Get,
    APIAccessType_Post,
    APIAccessType_PostJSON,
    APIAccessType_Upload,
    APIAccessType_Download
}APIAccessType;

typedef enum APIResultFormat:NSInteger{
    APIResultFormat_JSON,
    APIResultFormat_Data,
    APIResultFormat_XML
}APIResultFormat;

@protocol ServerAPIDelegate <NSObject>

@optional
-(void)requestCompletion:(ServerResult*)result error:(NSError*)error;

-(void)requestSuccessHandle:(ServerResult*)result;
-(void)requestFailHandle:(ServerResult*)result error:(NSError*)error;

@end

typedef void  (^sap_requestCompletion)(ServerResult *result, NSError* errInfo);
typedef void  (^sap_progressHandle)(float progress);
typedef BOOL  (^sap_retryFilter)();

extern NSString *const UnkownRequestAPITag;

@interface ServerAPI : NSObject

@property(nonatomic,assign)APIAccessType accessType;
@property(nonatomic,assign)APIResultFormat resultFormat;
@property(nonatomic,assign)NSTimeInterval timeOut;
@property(nonatomic,assign)BOOL shouldCache;
@property(nonatomic,assign)NSInteger retryTimes;

@property(nonatomic,copy)sap_retryFilter retryFilter;

@property(nonatomic,strong)Class returnClass;
@property(nonatomic,strong)NSString *requestPath;
@property(nonatomic,strong)NSString *requestHost;

@property(nonatomic,strong)NSString *uploadFileName;
@property(nonatomic,strong)NSString *uploadFileType;
@property(nonatomic,strong)NSData   *uploadData;
@property(nonatomic,strong)NSString *downloadFilePath;

@property(nonatomic,weak)id<ServerAPIDelegate> delegate;

@property(nonatomic,readonly)NSString *fullRequestPath;//不带host带参数
@property(nonatomic,readonly)NSString *fullRequestURL;//带host带参数

@property(nonatomic,strong)NSString *requestURL;//发起请求的URL（host拼接path不带参数)

@property(nonatomic,readonly)NSString *requestID;//请求的唯一标示
@property(nonatomic,readonly)NSString *cacheID;//对fullRequestURL进行md5取前8位仅对键值参数的请求有效，键值按字母排序


/**
 发起请求的时间，自动记录
 */
@property(nonatomic,readonly)NSDate *startDate;

@property(nonatomic,strong)NSString *requestTag;//请求归类表示，方便cancel某一类请求

/**
 自定制请求实体 按个人需要传入 
 如 NSURLRequest ，NSURLConnection，NSURLSession，NSURLSessionTask
 方便个人定制功能
 */
@property(nonatomic,strong)id originRequest;


/**
 部分参数默认值设置
 */
@property(nonatomic,strong)NSDictionary *requestRequiredParameters;

/**
 用于处理url可变参 如：http://www.xxxx.com/api/user/{method}
 key:{method}
 value:getUser
 
 结果 http://www.xxxx.com/api/user/getUser
 */
@property(nonatomic,strong)NSDictionary *requestPathParameters;

/**
 请求参数 内部有自动转换机制 可拼接如get请求 可转换json
 */
@property(nonatomic,strong)NSDictionary *requestParameters;


/**
 请求队列 传入 如：dispatch_queue_create("xxx.serial", DISPATCH_QUEUE_SERIAL)  串行队列
            dispatch_queue_create("xxx.concurrent", DISPATCH_QUEUE_CONCURRENT)  并发队列
            dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) 系统生成的并发队列
            设置后回调block将不阻塞主线程
 */
@property(nonatomic,strong)dispatch_queue_t completionQueue;

/**
 统一处理队列完成后事件 传入 如：dispatch_group_create();
                   使用 ：  dispatch_group_notify(completionGroup, dispatch_get_global_queue(0,0), ^{
                                //所有请求完成后要做的事
                           });

 */
@property(nonatomic,strong)dispatch_group_t completionGroup;


/**
 发起网络请求

 @param completion 请求结束回调
 */
-(void)requestDataWithCompletion:(sap_requestCompletion)completion;

/**
 发起网络请求

 @param completion 请求结束回调
 @param progressHandle 下载或上传进度回调
 */
-(void)requestDataWithCompletion:(sap_requestCompletion)completion progressHandle:(sap_progressHandle)progressHandle;

/**
 取消当前网络请求，也就是ServerAPI最后一次发起的请求
 （特别提示用requestTag分类cancel或仅用ServerAPI发起一次请求才能保证精确）
 */
-(void)cancelRequest;

/**
 静态方法发起请求
 */
+(ServerAPI*)newRequestDataWithCompletion:(sap_requestCompletion)completion requestTag:(NSString*)requestTag;
+(ServerAPI*)newRequestDataWithCompletion:(sap_requestCompletion)completion requestParameters:(NSDictionary*)requestParameters requestTag:(NSString*)requestTag;
+(ServerAPI*)newRequestDataWithCompletion:(sap_requestCompletion)completion requestParameters:(NSDictionary*)requestParameters requestPathParameters:(NSDictionary*)requestPathParameters requestTag:(NSString*)requestTag;
+(ServerAPI*)newRequestDataWithCompletion:(sap_requestCompletion)completion requestParameters:(NSDictionary*)requestParameters requestPathParameters:(NSDictionary*)requestPathParameters requestRequiredParameters:(NSDictionary*)requestRequiredParameters requestTag:(NSString*)requestTag;


@end
