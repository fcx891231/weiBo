//
//  FXMeViewController.m
//  12.27  我的微博
//
//  Created by fanxi on 15/12/27.
//  Copyright (c) 2015年 fanxi. All rights reserved.
//

#import "FXMeViewController.h"
#import "FXSystemSettingViewController.h"
#import "FXSettingArrowItem.h"
#import "FXSettingGroup.h"

@interface FXMeViewController ()

@end

@implementation FXMeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
    
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
}

- (void)setting
{
    FXSystemSettingViewController *sys = [[FXSystemSettingViewController alloc] init];
    
    [self.navigationController pushViewController:sys animated:YES];

}

- (void)setupGroup0
{
    FXSettingGroup *group = [self addGroup];
    
    FXSettingArrowItem *newFriend = [FXSettingArrowItem itemWithIcon:@"new_friend" title:@"新的好友" destVcClass:nil];
    
    newFriend.badgeValue = @"10";
    group.items = @[newFriend];

}

- (void)setupGroup1
{
    
     FXSettingGroup *group = [self addGroup];
    
    FXSettingArrowItem *album = [FXSettingArrowItem itemWithIcon:@"album" title:@"我的相册" destVcClass:nil];
    album.subtitle = @"(109)";
    
    FXSettingArrowItem *collect = [FXSettingArrowItem itemWithIcon:@"collect" title:@"我的收藏" destVcClass:nil];
    collect.subtitle = @"(0)";
    
    FXSettingArrowItem *like = [FXSettingArrowItem itemWithIcon:@"like" title:@"赞" destVcClass:nil];
    like.badgeValue = @"1";
    like.subtitle = @"(35)";
    
    group.items = @[album,collect,like];
    
}

- (void)setupGroup2
{
   FXSettingGroup *group = [self addGroup];
    
    FXSettingArrowItem *pay = [FXSettingArrowItem itemWithIcon:@"pay" title:@"我的支付" destVcClass:nil];
    FXSettingArrowItem *vip = [FXSettingArrowItem itemWithIcon:@"vip" title:@"会员中心" destVcClass:nil];
    
    group.items = @[pay,vip];
    
    
}

- (void)setupGroup3
{
    FXSettingGroup *group = [self addGroup];
    
    FXSettingArrowItem *card = [FXSettingArrowItem itemWithIcon:@"card" title:@"我的名片" destVcClass:nil];
    FXSettingArrowItem *draft = [FXSettingArrowItem itemWithIcon:@"draft" title:@"草稿箱" destVcClass:nil];
    group.items = @[card, draft];
    
    
}

@end
