//
//  FXUser.h
//  12.27  我的微博
//
//  Created by fanxi on 16/1/10.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXUser : NSObject

@property (nonatomic,copy) NSString *idstr;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *profile_image_url;

/**
 *  会员等级
 */
@property (nonatomic, assign) int mbrank;
/**
 *  会员类型
 */
@property (nonatomic, assign) int mbtype;

+ (instancetype)userWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;



@end
