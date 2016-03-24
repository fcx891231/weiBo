//
//  FXStatusCacheTool.h
//  12.27  我的微博
//
//  Created by fanxi on 16/2/28.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXHomeStatusParam.h"
@class FXStatus;

@interface FXStatusCacheTool : NSObject

/**
 *  缓存一条微博
 *
 *  @param dict 需要缓存的微博
 */
+ (void)addStatus:(FXStatus *)status;


/**
 *  缓存n条微博
 *
 *  @param dictArray 需要缓存的微博
 */
+ (void)addstatuses:(NSArray *)statusArray;


/**
 *  根据请求参数活的微博
 *
 *  @param param 请求参数
 *
 *  @return 微博数组
 */
+ (NSArray *)statusesWithParam:(FXHomeStatusParam *)param;







@end
