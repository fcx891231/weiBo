//
//  FXTabBarController.m
//  12.27  我的微博
//
//  Created by fanxi on 15/12/27.
//  Copyright (c) 2015年 fanxi. All rights reserved.
//

#import "FXTabBarController.h"
#import "FXHomeViewController.h"
#import "FXMessageViewController.h"
#import "FXDiscoverViewController.h"
#import "FXMeViewController.h"
#import "FXTabBar.h"
#import "FXNavigationController.h"
#import "FXComposeViewController.h"

@interface FXTabBarController () <FXTabBarDelgegete,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic,weak) FXTabBar *customTabBar;


@end

@implementation FXTabBarController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTabBar];
    [self setupAllChildViewControllers];
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView *child  in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }

}

- (void)setupTabBar
{
    FXTabBar *customTabBar = [[FXTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegete = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
    
}

- (void)tabBar:(FXTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to
{

    self.selectedIndex = to;

}

- (void)tabBarDidClickPlusButton:(FXTabBar *)tabBar
{
    FXComposeViewController *compose = [[FXComposeViewController alloc] init];
    FXNavigationController *nav = [[FXNavigationController alloc] initWithRootViewController:compose];
    
    [self presentViewController:nav animated:YES completion:nil];
    
    
}


- (void)setupAllChildViewControllers
{
    FXHomeViewController *home = [[FXHomeViewController alloc] init];
//       home.tabBarItem.badgeValue = @"10";
    [self addChildViewController:home title:@"首页" image:@"tabbar_home_os7" selectedImage:@"tabbar_home_selected_os7"];
 
    
    
    FXMessageViewController *message = [[FXMessageViewController alloc] init];
//      message.tabBarItem.badgeValue = @"235";
    [self addChildViewController:message title:@"消息" image:@"tabbar_message_center_os7" selectedImage:@"tabbar_message_center_selected_os7"];
  
    
    FXDiscoverViewController *discover = [[FXDiscoverViewController alloc] init];
    [self addChildViewController:discover title:@"发现" image:@"tabbar_discover_os7" selectedImage:@"tabbar_discover_selected_os7"];
    
    FXMeViewController *me = [[FXMeViewController alloc] init];
    [self addChildViewController:me title:@"我" image:@"tabbar_profile_os7" selectedImage:@"tabbar_profile_selected_os7"];
    
    
    
}

- (void)addChildViewController:(UIViewController *)child title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    child.title = title;
    child.tabBarItem.image = [UIImage imageNamed:image];
    //选中图标不要渲染成蓝色
    child.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    FXNavigationController *nav = [[FXNavigationController alloc] initWithRootViewController:child];
    [self addChildViewController:nav];
    
    [self.customTabBar addTabBarButtonWithitem:child.tabBarItem];
}

@end
