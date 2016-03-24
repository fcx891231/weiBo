//
//  FXAccount.h
//  12.27  我的微博
//
//  Created by fanxi on 16/1/10.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXAccount : NSObject <NSCoding>

@property (nonatomic, copy) NSString *access_token;
// 如果服务器返回的数字很大, 建议用long long(比如主键, ID)
@property (nonatomic, strong) NSDate *expiresTime; // 账号的过期时间
@property (nonatomic, assign) long long expires_in;
@property (nonatomic, assign) long long remind_in;
@property (nonatomic, assign) long long uid;

@property (nonatomic,copy) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;




@end
