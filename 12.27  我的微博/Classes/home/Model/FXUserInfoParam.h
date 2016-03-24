//
//  FXUserInfoParam.h
//  12.27  我的微博
//
//  Created by fanxi on 16/2/13.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXBaseParam.h"

@interface FXUserInfoParam : FXBaseParam

/**
 *  需要查询的用户ID。
 */
@property (nonatomic, strong) NSNumber *uid;

/**
 *  需要查询的用户昵称。
 */
@property (nonatomic, copy) NSString *screen_name;

@end
