//
//  FXTitleButton.m
//  12.27  我的微博
//
//  Created by fanxi on 16/1/2.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXTitleButton.h"
#import "UIImage+FX.h"
#define FXTitleButtonWidth  10

@implementation FXTitleButton



+ (instancetype)titleButton
{
    return  [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.adjustsImageWhenHighlighted = NO;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        
//        [self setBackgroundImage:[UIImage resizedImageWithName:@"navigationbar_filter_background_highlighted_os7"] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{   CGFloat imageY = 0;
    CGFloat imageW = FXTitleButtonWidth;
    CGFloat imageH = contentRect.size.height;
    CGFloat imageX = contentRect.size.width- imageW;
    
    
    return CGRectMake(imageX, imageY, imageW, imageH);
    
    
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect
{

    CGFloat titleY = 0;
    CGFloat titleW = contentRect.size.width - FXTitleButtonWidth;
    CGFloat titleH = contentRect.size.height;
    CGFloat titleX = 0;
    
    return CGRectMake(titleX, titleY, titleW, titleH);


}

//- (void)setTitle:(NSString *)title forState:(UIControlState)state
//{
//    // 根据title计算自己的宽度
//    CGFloat titleW = [title sizeWithFont:self.titleLabel.font].width;
//    
//    CGRect frame = self.frame;
//    frame.size.width = titleW + FXTitleButtonWidth + 5;
//    self.frame = frame;
//    
//    [super setTitle:title forState:state];
//
//}

@end
