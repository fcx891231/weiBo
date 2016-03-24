//
//  FXTabBarButton.m
//  12.27  我的微博
//
//  Created by fanxi on 15/12/28.
//  Copyright (c) 2015年 fanxi. All rights reserved.
//

#import "FXTabBarButton.h"
#import "FXBadgeButton.h"



@interface FXTabBarButton ()
@property (nonatomic,weak) FXBadgeButton *badgeButton;

@end
@implementation FXTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        
        FXBadgeButton *badgeButton = [[FXBadgeButton alloc] init];
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        self.badgeButton.badgeValue = self.item.badgeValue;
       
      
        
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
        
        
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{



}

- (void)setItem:(UITabBarItem *)item
{
     _item = item;
    
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
    
    //设置提醒数字的位置
    CGFloat badgY = 5;
    CGFloat badgX = self.frame.size.width - self.badgeButton.frame.size.width - 10;
    CGRect badgF = self.badgeButton.frame;
    badgF.origin.x = badgX;
    badgF.origin.y = badgY;
    self.badgeButton.frame = badgF;
//    self.badgeButton.badgeValue = item.badgeValue;
    
    
    
    
//    [self setImage:self.item.image forState:UIControlStateNormal];
//    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
//    //    [button setBackgroundImage:[UIImage imageNamed:@"tabbar_slider"] forState:UIControlStateSelected];
//    [self setTitle:self.item.title forState:UIControlStateNormal];
//    [self setTitle:self.item.title forState:UIControlStateSelected];

}

- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    
    



}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{

   //设置文字
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setTitle:self.item.title forState:UIControlStateSelected];
    
    //设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    //设置提醒数字
   self.badgeButton.badgeValue = self.item.badgeValue;



}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height*0.7;
  

    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleY = contentRect.size.height *0.7;
    CGFloat titleH = contentRect.size.height - titleY;

    return CGRectMake(titleX, titleY, titleW, titleH);
}
@end
