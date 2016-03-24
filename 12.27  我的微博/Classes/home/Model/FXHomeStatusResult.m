//
//  FXHomeStatusResult.m
//  12.27  我的微博
//
//  Created by fanxi on 16/2/13.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXHomeStatusResult.h"
#import "MJExtension.h"
#import "FXStatus.h"

@implementation FXHomeStatusResult

- (NSDictionary *)objectClassInArray
{

    return   @{@"statuses": [FXStatus class]};

}


@end
