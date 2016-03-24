//
//  FXSettingGroup.h
//  12.27  我的微博
//
//  Created by fanxi on 16/3/1.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXSettingGroup : NSObject

@property (nonatomic,strong)  NSArray  *items;
@property (nonatomic,copy) NSString *header;
@property (nonatomic,copy) NSString *footer;

+ (instancetype)group;

@end
