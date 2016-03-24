//
//  FXSettingArrowItem.m
//  12.27  我的微博
//
//  Created by fanxi on 16/3/1.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXSettingArrowItem.h"

@implementation FXSettingArrowItem


+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass
{
    FXSettingArrowItem *item = [FXSettingArrowItem item];
    item.icon = icon;
    item.title = title;
    item.destVcClass = destVcClass;
    
    return item;

}

+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass
{

    return [self itemWithIcon:nil title:title destVcClass:destVcClass];

}





@end
