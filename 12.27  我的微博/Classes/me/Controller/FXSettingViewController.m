//
//  FXSettingViewController.m
//  12.27  我的微博
//
//  Created by fanxi on 16/3/1.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXSettingViewController.h"
#import "FXSettingGroup.h"
#import "FXSettingArrowItem.h"
#import "FXSettingCell.h"

@interface FXSettingViewController ()

@end

@implementation FXSettingViewController

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (FXSettingGroup *)addGroup
{
    FXSettingGroup *group = [FXSettingGroup group];
    [self.groups addObject:group];
    return group;

}

- (id)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = FXColor(226, 226, 226);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.sectionHeaderHeight = 5;
    self.tableView.sectionFooterHeight = 0;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    FXSettingGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FXSettingCell *cell = [FXSettingCell cellWithTableView:tableView];
    FXSettingGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    cell.indexPath = indexPath;
//    cell.contentView.backgroundColor = [UIColor redColor];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   
    FXSettingGroup *group = self.groups[section];
    return group.header;

}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{

    FXSettingGroup *group = self.groups[section];
    return group.footer;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
   //1.取出模型
    FXSettingGroup *group = self.groups[indexPath.section];
    FXSettingItem *item = group.items[indexPath.row];
    
    //2.操作
    if (item.operation) {
        item.operation();
    }
    
    //3.跳转
    if ([item isKindOfClass:[FXSettingArrowItem class]]) {
        FXSettingArrowItem *arrowItem = (FXSettingArrowItem *)item;
        
        if (arrowItem.destVcClass) {
            UIViewController *destVc = [[arrowItem.destVcClass alloc] init];
            destVc.title = item.title;
            [self.navigationController pushViewController:destVc animated:YES];
        }
        
    }


}


@end
