//
//  FXTextView.m
//  12.27  我的微博
//
//  Created by fanxi on 16/2/10.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXTextView.h"

@interface FXTextView ()

@property (nonatomic,weak) UILabel *placeholderLabel;

@end

@implementation FXTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.textColor = [UIColor lightGrayColor];       //文字颜色
        placeholderLabel.numberOfLines = 0;                          //自动换行
        placeholderLabel.backgroundColor = [UIColor clearColor];     //背景颜色
        placeholderLabel.font = self.font;                           //字体
        [self insertSubview:placeholderLabel atIndex:0];             //插到最前面
        self.placeholderLabel = placeholderLabel;
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];                                        // 监听文字改变
        
        
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
  
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;
   
    if (placeholder.length) {
        self.placeholderLabel.hidden = NO;
        
        CGFloat placeholderX = 5;
        CGFloat placeholderY = 7;
        CGFloat maxW = self.frame.size.width - 2*placeholderX;
        CGFloat maxH = self.frame.size.height - 2*placeholderY;
      CGSize placeholderSize = [placeholder sizeWithFont:self.placeholderLabel.font constrainedToSize:CGSizeMake(maxW, maxH)];
        self.placeholderLabel.frame = CGRectMake(placeholderX, placeholderY, placeholderSize.width, placeholderSize.height);
        
    } else {
        self.placeholderLabel.hidden = YES;
    }

}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;

}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    self.placeholder = self.placeholder;

}

- (void)textDidChange
{
    self.placeholderLabel.hidden = (self.text.length != 0);

}

@end
