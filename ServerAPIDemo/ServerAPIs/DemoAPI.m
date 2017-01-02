//
//  DemoAPI.m
//  ServerAPIDemo
//
//  Created by Zhao Yiqi on 2017/1/3.
//  Copyright © 2017年 Zhao Yiqi. All rights reserved.
//

#import "DemoAPI.h"

@implementation DemoAPI

-(APIAccessType)accessType{
    return APIAccessType_Get;
}

-(NSString*)requestPath{
    return @"api/server/startup";
}

@end
