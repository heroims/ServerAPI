# ServerAPI
## 快速集成的网络架构
###这个项目体现的是一个框架思想，只是提供了框架，缓存和网络请求根据项目需求随意更换
通过Category完成对个人项目的定制
ServerAPI创建Category需要实现ServerAPIResponseProtocol的协议，这个协议主要实现对请求返回的数据格式化详见demo
```Objective-C
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
```
顺便说一下responseCustomDoInCategoryWithResult的使用可以在继承ServerAPI的DemoAPI上做Category这样侵入性才最小，针对不同的API做不同的业务逻辑

ServerAPIManager创建Category需要实现ServerAPIManagerRequestProtocol的协议
```Objective-C
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
```
requestDataWithAPI里面去写对应的请求发起包括用不用一个NSURLSession各种请求定制在这完成
还有ServerAPIManagerCacheProtocol这个协议则是管理缓存逻辑可以不去实现也可以实现
```Objective-C
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
```
其中fetchDataCacheWithAPI调用在requestDataWithAPI里写而saveDataCacheWithResult调用在responseFormatWithData里写
上边的这些就是对请求的整体定制化，至于属性添加，就直接runtime吧
###体现了集约型和离散型网络架构的结合
```Objective-C
    //离散型API使用  一个请求是一个API类，用NSClassFromString主要为了省头文件引用懒得加头文件。。。           
    [NSClassFromString(@"DemoAPI") newRequestDataWithCompletion:^(ServerResult *result, NSError *errInfo) {
        
    } requestParameters:nil requestTag:NSStringFromClass([self class])];
    
    ServerAPI *discreteApi=[[NSClassFromString(@"DemoAPI") alloc] init];
    discreteApi.requestParameters=nil;
    discreteApi.requestTag=NSStringFromClass([self class]);
    [discreteApi requestDataWithCompletion:^(ServerResult *result, NSError *errInfo) {
        
    }];

    //集约型API使用  可以直接类扩展加静态方法设置，可以自行类扩展个更简洁通用的方法这里只距离
    ServerAPI *intensiveAPI=[[ServerAPI alloc] init];
    intensiveAPI.requestHost=@"http://xxx.xxx.xxx";
    intensiveAPI.requestPath=@"xxx";
    intensiveAPI.requestParameters=nil;
    intensiveAPI.requestTag=NSStringFromClass([self class]);
    intensiveAPI.accessType=APIAccessType_Get;
    intensiveAPI.resultFormat=APIResultFormat_JSON;
    intensiveAPI.timeOut=30;
    intensiveAPI.retryTimes=2;
    [intensiveAPI requestDataWithCompletion:^(ServerResult *result, NSError *errInfo) {
        
    }];
    
    //直接请求Url
    ServerAPI *urlAPI=[[ServerAPI alloc] init];
    urlAPI.requestURL=@"http://xxx.xxx.xxx";
    urlAPI.requestTag=NSStringFromClass([self class]);
    [urlAPI requestDataWithCompletion:^(ServerResult *result, NSError *errInfo) {
        
    }];

```
