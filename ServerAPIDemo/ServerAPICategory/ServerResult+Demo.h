//
//  ServerResult+Demo.h
//  ServerAPIDemo
//
//  Created by Zhao Yiqi on 2017/1/3.
//  Copyright © 2017年 Zhao Yiqi. All rights reserved.
//

#import "ServerResult.h"

@interface ServerResult (Demo)
/**<
NSCoding
,NSCopying
>*/

@property(nonatomic,readonly)NSString *errorMessage;

@end
