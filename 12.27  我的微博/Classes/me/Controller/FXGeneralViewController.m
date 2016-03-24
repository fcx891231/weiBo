//
//  FXGeneralViewController.m
//  12.27  我的微博
//
//  Created by fanxi on 16/3/1.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXGeneralViewController.h"
#import "FXSettingArrowItem.h"
#import "FXSettingSwitchItem.h"
#import "SDWebImageManager.h"
#import "MBProgressHUD+MJ.h"
#import "FXSettingGroup.h"

@interface FXGeneralViewController ()

@end

@implementation FXGeneralViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
    [self setupGroup4];
}

- (void)setupGroup0
{
    FXSettingGroup *group = [self addGroup];
    FXSettingArrowItem *read = [FXSettingArrowItem itemWithTitle:@"阅读模式" destVcClass:nil];
    FXSettingArrowItem *font = [FXSettingArrowItem itemWithTitle:@"字体大小" destVcClass:nil];
    FXSettingSwitchItem *mark = [FXSettingSwitchItem itemWithTitle:@"显示备注"];
    
    group.items = @[read,font,mark];
    

}

- (void)setupGroup1
{
     FXSettingGroup *group = [self addGroup];
     FXSettingArrowItem *picture = [FXSettingArrowItem itemWithTitle:@"图片质量设置" destVcClass:nil];
    
      group.items = @[picture];
}

- (void)setupGroup2
{
     FXSettingGroup *group = [self addGroup];
    
     FXSettingSwitchItem *voice = [FXSettingSwitchItem itemWithTitle:@"声音"];
  
     group.items = @[voice];
    
}

- (void)setupGroup3
{
     FXSettingGroup *group = [self addGroup];
     FXSettingSwitchItem *language = [FXSettingSwitchItem itemWithTitle:@"多语言环境"];
   
     group.items = @[language];
    
}

- (void)setupGroup4
{
     FXSettingGroup *group = [self addGroup];
    
    FXSettingArrowItem *clearCache = [FXSettingArrowItem itemWithTitle:@"清除图片缓存"];
    clearCache.operation = ^{
        [MBProgressHUD showMessage:@"哥正在拼命帮你清理中"];
        
        NSFileManager *mgr = [NSFileManager defaultManager];
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        
        [mgr removeItemAtPath:cachePath error:nil];
        [MBProgressHUD hideHUD];
    };
    
    FXSettingArrowItem *history = [FXSettingArrowItem itemWithTitle:@"清空搜索历史"];
 
    group.items = @[clearCache,history];
}


@end
