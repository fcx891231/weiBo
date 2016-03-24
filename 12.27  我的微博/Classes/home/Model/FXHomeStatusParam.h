//
//  FXHomeStatusParam.h
//  12.27  我的微博
//
//  Created by fanxi on 16/2/13.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXBaseParam.h"


@interface FXHomeStatusParam :FXBaseParam

//@property (nonatomic,copy) NSString *access_token;

@property (nonatomic,assign)  NSNumber *since_id;

@property (nonatomic,assign) NSNumber *max_id;

@property (nonatomic,strong)  NSNumber  *count;





@end
