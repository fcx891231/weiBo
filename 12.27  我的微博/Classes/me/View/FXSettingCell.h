//
//  FXSettingCell.h
//  12.27  我的微博
//
//  Created by fanxi on 16/3/1.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FXSettingItem;
@interface FXSettingCell : UITableViewCell

@property (nonatomic,strong)  FXSettingItem  *item;
@property (nonatomic,strong)  NSIndexPath  *indexPath;

+ (instancetype)cellWithTableView:(UITableView *)tableView;



@end
