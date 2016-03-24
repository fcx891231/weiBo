//
//  FXSatusTool.m
//  12.27  我的微博
//
//  Created by fanxi on 16/2/13.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXStatusTool.h"
#import "FXHttpTool.h"
#import "MJExtension.h"
#import "FXHomeStatusParam.h"
#import "FXStatusCacheTool.h"

@implementation FXStatusTool

+ (void)homeStatusWithParam:(FXHomeStatusParam *)param success:(void (^)(FXHomeStatusResult *))success failure:(void (^)(NSError *))failure
{
    

    
    // 1.先从缓存里面加载
    NSArray *statusArray = [FXStatusCacheTool statusesWithParam:param];
    if (statusArray.count) { // 有缓存
        // 传递了block
        if (success) {
            FXHomeStatusResult *result = [[FXHomeStatusResult alloc] init];
            
            result.statuses = statusArray;
            
            success(result);
        }

    }  else  { //从网络加载
    
        [FXHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:param.keyValues success:^(id jason) {
            FXHomeStatusResult *result = [FXHomeStatusResult objectWithKeyValues:jason];
           
            [FXStatusCacheTool addstatuses:result.statuses];//缓存模型
            
            if (success) {
               
                success(result);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    
    }
    
    



}

+ (void)sendStatusWithParam:(FXSendSatusParam *)param success:(void (^)(FXSendStatusResult *))success failure:(void (^)(NSError *))failure
{

    
    [FXHttpTool getWithURL:@"https://api.weibo.com/2/statuses/update.json" params:param.keyValues success:^(id jason) {
        if (success) {
            FXSendStatusResult *result = [FXSendStatusResult objectWithKeyValues:jason];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];


}

@end
