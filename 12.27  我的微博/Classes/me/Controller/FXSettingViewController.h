//
//  FXSettingViewController.h
//  12.27  我的微博
//
//  Created by fanxi on 16/3/1.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FXSettingGroup;

@interface FXSettingViewController : UITableViewController

@property (nonatomic,strong)  NSMutableArray  *groups;

- (FXSettingGroup *)addGroup;


@end
