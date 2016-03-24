//
//  FXStatusCell.h
//  12.27  我的微博
//
//  Created by fanxi on 16/1/16.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FXStatusFrame;

@interface FXStatusCell : UITableViewCell



+ (instancetype)cellWithTableview:(UITableView *)tableView;


@property (nonatomic,strong)  FXStatusFrame  *statusFrame;





@end
