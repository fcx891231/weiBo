//
//  FXUser.m
//  12.27  我的微博
//
//  Created by fanxi on 16/1/10.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXUser.h"
#import "MJExtension.h"

@implementation FXUser

MJCodingImplementation


+ (instancetype)userWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}

- (instancetype)initWithDict:(NSDictionary *)dict
{

    if (self = [super init]) {
        self.idstr = dict[@"idstr"];
        self.name = dict[@"name"];
        self.profile_image_url = dict[@"profile_image_url"];
    }
    return self;
}
@end
