//
//  UIImage+FX.m
//  12.27  我的微博
//
//  Created by fanxi on 16/1/2.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "UIImage+FX.h"

@implementation UIImage (FX)

+ (UIImage *)resizedImageWithName:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];


}


+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{

    UIImage *image = [UIImage imageNamed:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width*left topCapHeight:image.size.width*top];
    

}
@end
