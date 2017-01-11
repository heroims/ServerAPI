//
//  ViewController.m
//  ServerAPIDemo
//
//  Created by Zhao Yiqi on 2016/12/26.
//  Copyright © 2016年 Zhao Yiqi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

    //重复使用内部不会混乱 前提category自己实现的没问题，这块可参考demo写法
    for (NSInteger i=0; i<10; i++) {
        ServerAPI *subUrlAPI=[[ServerAPI alloc] init];
        subUrlAPI.requestURL=@"http://xxx.xxx.xxx";
        subUrlAPI.requestTag=NSStringFromClass([self class]);
        NSLog(@"start requestID:%@",subUrlAPI.requestID);
        [subUrlAPI requestDataWithCompletion:^(ServerResult *result, NSError *errInfo) {
            NSLog(@"end requestID:%@",result.api.requestID);
        }];
    }
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
