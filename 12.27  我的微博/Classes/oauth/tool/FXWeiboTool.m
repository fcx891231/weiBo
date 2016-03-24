//
//  FXWeiboTool.m
//  12.27  我的微博
//
//  Created by fanxi on 16/1/10.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXWeiboTool.h"
#import "FXTabBarController.h"
#import "FXNewFutureController.h"

@implementation FXWeiboTool


+ (void)chooseRootController
{

  NSString *key = @"CFBundleVersion";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        [UIApplication sharedApplication].statusBarHidden = NO;
        [UIApplication sharedApplication].keyWindow.rootViewController = [[FXTabBarController alloc] init];
        
    }  else  {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[FXNewFutureController alloc] init];
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    
    
    }


}

@end
