//
//  FXTabBar.h
//  12.27  我的微博
//
//  Created by fanxi on 15/12/27.
//  Copyright (c) 2015年 fanxi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FXTabBar;

@protocol FXTabBarDelgegete <NSObject>

@optional
- (void)tabBar:(FXTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;
- (void)tabBarDidClickPlusButton:(FXTabBar *)tabBar;


@end

@interface FXTabBar : UIView

@property (nonatomic,weak) id <FXTabBarDelgegete>delegete;
- (void)addTabBarButtonWithitem:(UITabBarItem *)item;

@end
