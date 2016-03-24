//
//  FXSettingItem.h
//  12.27  我的微博
//
//  Created by fanxi on 16/3/1.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^FXSettingItemOperation)();

@interface FXSettingItem : NSObject

@property (nonatomic,copy)  NSString  *icon;
@property (nonatomic,copy)  NSString  *title;
@property (nonatomic,copy) NSString *subtitle;
@property (nonatomic,copy) NSString *badgeValue;

@property (nonatomic,copy) FXSettingItemOperation operation;


+ (instancetype)item;

+ (instancetype)itemWithTitle:(NSString *)title;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;



@end
