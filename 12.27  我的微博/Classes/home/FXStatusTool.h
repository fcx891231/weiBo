//
//  FXSatusTool.h
//  12.27  我的微博
//
//  Created by fanxi on 16/2/13.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXHomeStatusParam.h"
#import "FXHomeStatusResult.h"
#import "FXSendSatusParam.h"
#import "FXSendStatusResult.h"

@interface FXStatusTool : NSObject

/**
 *  加载首页的微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)homeStatusWithParam:(FXHomeStatusParam *)param success:(void (^)(FXHomeStatusResult *result))success failure:(void (^)(NSError *error))failure;


/**
 *  发送一条微博
 */
+ (void)sendStatusWithParam:(FXSendSatusParam*)param success:(void (^)(FXSendStatusResult *result))success failure:(void (^)(NSError *error))failure;


@end
