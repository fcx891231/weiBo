//
//  FXBaseParam.h
//  12.27  我的微博
//
//  Created by fanxi on 16/2/13.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXBaseParam : NSObject

@property (nonatomic,copy) NSString *access_token;

+ (instancetype)param;


@end
