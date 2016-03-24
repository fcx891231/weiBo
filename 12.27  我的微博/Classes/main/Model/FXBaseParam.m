//
//  FXBaseParam.m
//  12.27  我的微博
//
//  Created by fanxi on 16/2/13.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXBaseParam.h"
#import "FXAccount.h"
#import "FXAccountTool.h"

@implementation FXBaseParam

- (id)init
{
    if (_access_token == nil) {
       _access_token = [FXAccountTool account].access_token;
    }
    return self;
}

+ (instancetype)param
{
    return  [[self alloc] init];

}


@end
