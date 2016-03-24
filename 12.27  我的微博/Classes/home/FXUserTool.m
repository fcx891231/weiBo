//
//  FXUserTool.m
//  12.27  我的微博
//
//  Created by fanxi on 16/2/13.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXUserTool.h"
#import "FXHttpTool.h"
#import "MJExtension.h"

@implementation FXUserTool


+ (void)userInfoWithParam:(FXUserInfoParam *)param success:(void (^)(FXUserInfoResult *))success failure:(void (^)(NSError *))failure
{
   [FXHttpTool getWithURL:@"https://api.weibo.com/2/users/show.json"  params:param.keyValues success:^(id jason) {
       if (success) {
           FXUserInfoResult *result = [FXUserInfoResult objectWithKeyValues:jason];
           success(result);
       }
       
   } failure:^(NSError *error) {
       if (error) {
           failure(error);
       }
   }];


}

@end
