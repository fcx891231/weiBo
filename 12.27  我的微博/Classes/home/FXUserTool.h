//
//  FXUserTool.h
//  12.27  我的微博
//
//  Created by fanxi on 16/2/13.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXUserInfoResult.h"
#import "FXUserInfoParam.h"

@interface FXUserTool : NSObject

+ (void)userInfoWithParam:(FXUserInfoParam *)param success:(void (^)(FXUserInfoResult *resutl))success failure:(void (^)(NSError *error))failure;



@end
