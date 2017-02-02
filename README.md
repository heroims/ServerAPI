# ServerAPI
## 快速集成的网络架构
####这个项目体现的是一个框架思想，只是提供了框架，缓存和网络请求根据项目需求随意更换


####体现了集约型和离散型网络架构的结合
```Objective-C
    //离散型API使用
    [NSClassFromString(@"DemoAPI") newRequestDataWithCompletion:^(ServerResult *result, NSError *errInfo) {
        
    } requestTag:NSStringFromClass([self class])];
    
    BaseServerAPI *discreteApi=[[NSClassFromString(@"DemoAPI") alloc] init];
    discreteApi.requestParameters=nil;
    discreteApi.requestTag=NSStringFromClass([self class]);
    [discreteApi requestDataWithCompletion:^(ServerResult *result, NSError *errInfo) {
        
    }];

    //集约型API使用  可以直接类扩展加静态方法设置
    ServerAPI *intensiveAPI=[[ServerAPI alloc] init];
    intensiveAPI.requestHost=@"http://xxx.xxx.xxx";
    intensiveAPI.requestParameters=nil;
    intensiveAPI.requestTag=NSStringFromClass([self class]);
    [intensiveAPI requestDataWithCompletion:^(ServerResult *result, NSError *errInfo) {
        
    }];
    
    //直接请求Url
    ServerAPI *urlAPI=[[ServerAPI alloc] init];
    urlAPI.requestURL=@"http://xxx.xxx.xxx";
    urlAPI.requestTag=NSStringFromClass([self class]);
    [urlAPI requestDataWithCompletion:^(ServerResult *result, NSError *errInfo) {
        
    }];

```
