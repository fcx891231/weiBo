//
//  FXSettingArrowItem.h
//  12.27  我的微博
//
//  Created by fanxi on 16/3/1.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXSettingItem.h"

@interface FXSettingArrowItem : FXSettingItem
@property (nonatomic,assign) Class destVcClass;


+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass;

+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass;




@end
