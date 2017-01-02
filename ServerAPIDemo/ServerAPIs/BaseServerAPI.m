//
//  BaseServerAPI.m
//  xgoods
//
//  Created by admin on 2016/12/5.
//  Copyright © 2016年 Look. All rights reserved.
//

#import "BaseServerAPI.h"

@implementation BaseServerAPI

#pragma mark - Getter and Setter

-(NSString*)requestHost{
    return BASE_URL;
}

-(APIResultFormat)resultFormat{
    return APIResultFormat_JSON;
}

-(NSInteger)retryTimes{
    return 0;
}

-(NSTimeInterval)timeOut{
    return TIMEOUT_HTTPREQUEST;
}

-(BOOL)shouldCache{
    return NO;
}

@end
