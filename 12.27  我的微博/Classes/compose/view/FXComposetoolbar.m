//
//  FXComposetoolbar.m
//  12.27  我的微博
//
//  Created by fanxi on 16/2/10.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXComposetoolbar.h"

@implementation FXComposetoolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background_os7"]];
        
        [self addButtonWithIcon:@"compose_camerabutton_background_os7"  highIcon:@"compose_camerabutton_background_highlighted" tag:FXComposetoolbarButtonTypeCamera];
        [self addButtonWithIcon:@"compose_toolbar_picture_os7" highIcon:@"compose_toolbar_picture_highlighted" tag:FXComposetoolbarButtonTypePicture];
        [self addButtonWithIcon:@"compose_mentionbutton_background_os7" highIcon:@"compose_mentionbutton_background_highlighted" tag:FXComposetoolbarButtonTypeMention];
        [self addButtonWithIcon:@"compose_trendbutton_background_os7"  highIcon:@"compose_trendbutton_background_highlighted" tag:FXComposetoolbarButtonTypeTrend];
        [self addButtonWithIcon:@"compose_emoticonbutton_background_os7"  highIcon:@"compose_emoticonbutton_background_highlighted"  tag:FXComposetoolbarButtonTypeEmotion];
        
        
        
    }
    return self;
}


- (void)addButtonWithIcon:(NSString *)icon highIcon:(NSString *)highIcon tag:(int)tag
{
//    UIButton *button = [[UIButton alloc] init];
//    button.tag = tag;
//    
//    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
//    
//    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self addSubview:button];
    
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    [self addSubview:button];
}

- (void)buttonClick:(UIButton *)button
{

    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickedButton:)]) {
        [self.delegate composeToolbar:self didClickedButton:button.tag];
    }


}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonW = self.frame.size.width/(self.subviews.count);
    CGFloat buttonY = 0;
  
    for (int i=0; i<self.subviews.count; i++) {
      
        UIButton *button = self.subviews[i];
        CGFloat  buttonX = i * buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        
    }


}
@end
