//
//  FXSettingItem.m
//  12.27  我的微博
//
//  Created by fanxi on 16/3/1.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXSettingItem.h"

@implementation FXSettingItem

+ (instancetype)item
{
    return [[self alloc] init];


}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithIcon:nil title:title];

}

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    FXSettingItem *item = [self item];
    item.icon = icon;
    item.title = title;

    return item;
}

@end
