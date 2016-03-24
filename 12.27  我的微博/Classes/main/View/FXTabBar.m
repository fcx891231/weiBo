//
//  FXTabBar.m
//  12.27  我的微博
//
//  Created by fanxi on 15/12/27.
//  Copyright (c) 2015年 fanxi. All rights reserved.
//

#import "FXTabBar.h"
#import "FXTabBarButton.h"

@interface FXTabBar ()

@property (nonatomic,weak) FXTabBarButton *selectedButton;
@property (nonatomic,strong) NSMutableArray *tabBarButtons;
@property (nonatomic,weak) UIButton *plusButton;
@end

@implementation FXTabBar

- (NSMutableArray *)tabBarButtons
{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }

    return _tabBarButtons;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//      self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
      
        UIButton *plusButton = [[UIButton alloc] init];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_os7"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted_os7"] forState:UIControlStateHighlighted];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusButton.bounds = CGRectMake(0, 0, plusButton.currentBackgroundImage.size.width, plusButton.currentBackgroundImage.size.height);
        [plusButton addTarget:self action:@selector(plusButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusButton];
        self.plusButton = plusButton;
        
    }
    return self;
}

- (void)addTabBarButtonWithitem:(UITabBarItem *)item
{

    FXTabBarButton *button = [[FXTabBarButton alloc] init];
    [self addSubview:button];
    [self.tabBarButtons addObject:button];
    
    button.item = item;
    
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    if (self.subviews.count == 1) {
        [self buttonClick:button];
        
    }

}

- (void)plusButtonClick
{
    if ([self.delegete respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegete tabBarDidClickPlusButton:self];
    }

}

- (void)buttonClick:(FXTabBarButton *)button
{

    if ([self.delegete respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegete tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:button.tag];
    }
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    

}

- (void)layoutSubviews
{

    [super layoutSubviews];
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    self.plusButton.center = CGPointMake(w*0.5, h*0.5);
    
    CGFloat buttonY = 0;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonW = self.frame.size.width/self.subviews.count;
    
    for (int index =0; index<self.tabBarButtons.count; index++) {
        FXTabBarButton *button = self.tabBarButtons[index];
        CGFloat buttonX = index * buttonW;
        if (index >1) {
            buttonX += buttonW;
        }
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.tag = index;
        
    }



}
@end
