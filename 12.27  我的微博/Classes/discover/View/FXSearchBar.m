//
//  FXSearchBar.m
//  12.27  我的微博
//
//  Created by fanxi on 16/1/2.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXSearchBar.h"
#import "UIImage+FX.h"

@implementation FXSearchBar


+ (instancetype)searchBar
{
    return  [[self alloc] init];

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //背景
        self.background = [UIImage resizedImageWithName:@"searchbar_textfield_background"];
        
        //左边放大镜
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        iconView.contentMode = UIViewContentModeCenter;
    
        self.leftView = iconView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        self.font = [UIFont systemFontOfSize:13];
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        //设置提醒数字
        self.placeholder = @"搜索";
        
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;
        
     
        
        
    }
    return self;
}
- (void)layoutSubviews

{
    [super layoutSubviews];
    self.leftView.frame = CGRectMake(0, 0, 30,self.frame.size.height);
}

- (BOOL)endEditing:(BOOL)force
{

    return YES;
}

@end
