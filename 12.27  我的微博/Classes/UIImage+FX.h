//
//  UIImage+FX.h
//  12.27  我的微博
//
//  Created by fanxi on 16/1/2.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FX)

+ (UIImage *)resizedImageWithName:(NSString *)name;

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;


@end
