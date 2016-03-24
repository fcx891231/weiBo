//
//  AppDelegate.m
//  12.27  我的微博
//
//  Created by fanxi on 15/12/27.
//  Copyright (c) 2015年 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"
#import "FXTabBarController.h"
#import "FXNewFutureController.h"
#import "FXOauthViewController.h"
#import "FXAccountTool.h"
#import "FXWeiboTool.h"
#import "FXAccount.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[FXTabBarController alloc] init];
    [self.window makeKeyAndVisible];

    
//    NSString *key = @"CFBundleVersion";
//    NSUserDefaults *defauts = [NSUserDefaults standardUserDefaults];
//    NSString *lastVersion = [defauts stringForKey:key];
//    
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
//    
//    if ([currentVersion isEqualToString:lastVersion]) {
//        self.window.rootViewController = [[FXTabBarController alloc] init];
//        
//    }  else {
//       self.window.rootViewController = [[FXNewFutureController alloc] init];
//       
//        NSUserDefaults *defauts = [NSUserDefaults standardUserDefaults];
//        [defauts setObject:currentVersion forKey:key];
//        [defauts synchronize];
//        
//    }

    
    FXAccount *account = [FXAccountTool account];
    if (account) {
        [FXWeiboTool chooseRootController];
    } else {
        self.window.rootViewController = [[FXOauthViewController alloc] init];
    }
 
    
   
   
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
