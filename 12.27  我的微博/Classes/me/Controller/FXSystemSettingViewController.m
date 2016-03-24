//
//  FXSystemSettingViewController.m
//  12.27  我的微博
//
//  Created by fanxi on 16/3/1.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//
/** 表格的边框宽度 */
#define FXStatusTableBorder 5


#import "FXSystemSettingViewController.h"
#import "FXSettingGroup.h"
#import "FXSettingArrowItem.h"
#import "FXGeneralViewController.h"
#import "UIImage+FX.h"
#import "FXOauthViewController.h"

@interface FXSystemSettingViewController ()

@end

@implementation FXSystemSettingViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"设置";
    
    [self setupFooter];
    
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
}

- (void)setupFooter
{
    UIButton *logoutButton = [[UIButton alloc] init];
    
    CGFloat logoutX = FXStatusTableBorder +2;
    CGFloat logoutY = 10;
    CGFloat logoutW = self.tableView.frame.size.width - 2*logoutX;
    CGFloat logoutH = 44;
    
    logoutButton.frame = CGRectMake(logoutX, logoutY, logoutW, logoutH);
    
    [logoutButton setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [logoutButton setBackgroundImage:[UIImage resizedImageWithName:@"common_button_red"] forState:UIControlStateNormal];
    [logoutButton setBackgroundImage:[UIImage resizedImageWithName:@"common_button_red_highlighted"] forState:UIControlStateHighlighted];
    [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logoutButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [logoutButton addTarget:self action:@selector(popToOauthViewController) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *footer = [[UIView alloc] init];
    CGFloat footerH = logoutH + 20;
    footer.frame = CGRectMake(0, 0, 0, footerH);
    
    self.tableView.tableFooterView = footer;
    [footer addSubview:logoutButton];
}

- (void)popToOauthViewController
{
 [UIApplication sharedApplication].keyWindow.rootViewController = [[FXOauthViewController alloc] init];
  

}

- (void)setupGroup0
{
    FXSettingGroup *group = [self addGroup];
    
    FXSettingArrowItem *account = [FXSettingArrowItem itemWithTitle:@"帐号管理"];
    group.items = @[account];
}

- (void)setupGroup1
{
    FXSettingGroup *group = [self addGroup];
    
    FXSettingArrowItem *theme = [FXSettingArrowItem itemWithTitle:@"主题、背景" destVcClass:nil];
    group.items = @[theme];
}

- (void)setupGroup2
{
    FXSettingGroup *group = [self addGroup];
    
    FXSettingArrowItem *notice = [FXSettingArrowItem itemWithTitle:@"通知和提醒"];
    FXSettingArrowItem *general = [FXSettingArrowItem itemWithTitle:@"通用设置" destVcClass:[FXGeneralViewController class]];
    FXSettingArrowItem *safe = [FXSettingArrowItem itemWithTitle:@"隐私与安全"];
    group.items = @[notice, general, safe];
}

- (void)setupGroup3
{
    FXSettingGroup *group = [self addGroup];
    
    FXSettingArrowItem *opinion = [FXSettingArrowItem itemWithTitle:@"意见反馈"];
    FXSettingArrowItem *about = [FXSettingArrowItem itemWithTitle:@"关于微博"];
    group.items = @[opinion, about];
}

@end
