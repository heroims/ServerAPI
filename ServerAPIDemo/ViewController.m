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
    
    [NSClassFromString(@"DemoAPI") newRequestDataWithCompletion:^(ServerResult *result, NSError *errInfo) {
        
    } requestTag:NSStringFromClass([self class])];
    
    BaseServerAPI *api=[[NSClassFromString(@"DemoAPI") alloc] init];
    api.requestParameters=nil;
    api.requestTag=NSStringFromClass([self class]);
    [api requestDataWithCompletion:^(ServerResult *result, NSError *errInfo) {
        
    }];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
