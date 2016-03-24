//
//  FXAccountTool.h
//  12.27  我的微博
//
//  Created by fanxi on 16/1/10.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXAccessTokenParam.h"
#import "FXAccessTokenResult.h"
@class FXAccount;

@interface FXAccountTool : NSObject
+ (void)saveAccount:(FXAccount *)account;

+ (FXAccount *)account;


+ (void)accessTokenWithParam:(FXAccessTokenParam *)param success:(void (^)(FXAccessTokenResult *result))success failure:(void (^)(NSError *error))failure;


@end
