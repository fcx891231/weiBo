//
//  FXHttpTool.h
//  12.27  我的微博
//
//  Created by fanxi on 16/2/13.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXHttpTool : NSObject

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id jason))success
            failure:(void (^)(NSError *error))failure;




/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param formDataArray    上传的文件路径
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id jason))success
            failure:(void (^)(NSError *error))failure;




/**
 *  发送一个get请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id jason))success
            failure:(void (^)(NSError *error))failure;



@end

/**
 *  用来封装文件数据
 */
@interface FXFormData : NSObject

@property (nonatomic,copy)  NSString  *name;      //参数名

@property (nonatomic,copy) NSString *fileName;    //文件名

@property (nonatomic,copy) NSString *mimeType;    //文件类型

@property (nonatomic,strong)  NSData  *data;      //文件数据







@end
