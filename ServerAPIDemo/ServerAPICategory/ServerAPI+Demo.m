//
//  ServerAPI+Demo.m
//  ServerAPIDemo
//
//  Created by Zhao Yiqi on 2017/1/3.
//  Copyright © 2017年 Zhao Yiqi. All rights reserved.
//

#import "ServerAPI+Demo.h"
#import "ServerResult.h"
#import "ServerAPIManager+Demo.h"

@implementation ServerAPI (Demo)


NSDate *_endDate;

-(NSDate *)endDate{
    return _endDate;
}

-(void)responseFormatWithData:(id)data error:(NSError *)error completion:(sap_requestCompletion)completion cacheData:(id)cacheData{
    NSLog(@"%@  response begin============\n%@\n%@  response end============",NSStringFromClass([self class]),data,NSStringFromClass([self class]));
    [[ServerAPIManager sharedServerAPIManager] removeRequestWithServerAPI:self];
    
    ServerResult *result=[[ServerResult alloc] init];
    
    if (cacheData) {
        result=cacheData;
    }
    else{
        _endDate=[NSDate date];
        
        if (data!=nil) {
            result.originData=data;
            
            if (self.returnClass!=nil) {
                
//                result.formatData=[self.returnClass yy_modelWithJSON:data];
            }
            
        }
        
        if (error!=nil) {
            result.error=error;
        }
        
        result.api=self;
        
        if (self.shouldCache&&result.status==ServerResultStatus_Success) {
            [[ServerAPIManager sharedServerAPIManager] saveDataCacheWithResult:(id)result];
        }
        
    }
    
    if ([self respondsToSelector:@selector(responseCustomDoInCategoryWithResult:)]) {
        [self responseCustomDoInCategoryWithResult:result];
    }
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(requestCompletion:error:)]) {
            [self.delegate requestCompletion:result error:error];
        }
        if (error!=nil&&[self.delegate respondsToSelector:@selector(requestFailHandle:error:)]) {
            [self.delegate requestFailHandle:result error:error];
        }
        if (error==nil&&[self.delegate respondsToSelector:@selector(requestSuccessHandle:)]) {
            [self.delegate requestSuccessHandle:result];
        }
    }
    
    if (completion) {
        completion(result,error);
    }
    
    if (self.completionGroup) {
        dispatch_group_leave(self.completionGroup);
    }
}

//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [self yy_modelEncodeWithCoder:aCoder];
//}
//
//- (id)initWithCoder:(NSCoder *)aDecoder {
//    return [self yy_modelInitWithCoder:aDecoder];
//}

@end
