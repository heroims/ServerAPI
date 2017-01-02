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
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
