//
//  FXStatus.h
//  12.27  我的微博
//
//  Created by fanxi on 16/1/10.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FXUser;

@interface FXStatus : NSObject
@property (nonatomic,copy) NSString *text;   //微博正文
@property (nonatomic,copy) NSString *source; // 微博来源
@property (nonatomic,copy) NSString *idstr;  // 微博id
@property (nonatomic,assign) int reposts_count;   //转发数
@property (nonatomic,assign) int comments_count;  //评论数

/**
 *  微博的时间
 */
@property (nonatomic, copy) NSString *created_at;

/**
 *  微博的配图(数组中装模型:IWPhoto)
 */
@property (nonatomic, strong) NSArray *pic_urls;

/**
 *  微博的单张配图
 */
@property (nonatomic, copy) NSString *thumbnail_pic;

/**
 *  微博的表态数(被赞数)
 */
@property (nonatomic, assign) int attitudes_count;

/**
 *  被转发的微博
 */
@property (nonatomic, strong) FXStatus *retweeted_status;





@property (nonatomic,strong)  FXUser  *user; //微博作者

//
//+ (instancetype)statusWithDict:(NSDictionary *)dict;
//
//- (instancetype)initWithDict:(NSDictionary *)dict;
//


@end
