//
//  FXHomeViewController.m
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "FXHomeViewController.h"
#import "FXBadgeButton.h"
#import "UIBarButtonItem+FX.h"
#import "FXTitleButton.h"
#import "AFNetworking.h"
#import "FXAccountTool.h"
#import "FXAccount.h"
#import "UIImageView+WebCache.h"
#import "FXStatus.h"
#import "FXUser.h"
#import "MJExtension.h"

@interface FXHomeViewController ()
@property (nonatomic, strong) NSArray *statuses;
@end

@implementation FXHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.设置导航栏的内容
    [self setupNavBar];
    
    // 2.加载微博数据
    [self setupStatusData];
}

/**
 *  加载微博数据
 */
- (void)setupStatusData
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [FXAccountTool account].access_token;
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          // 将字典数组转为模型数组(里面放的就是FXStatus模型)
          self.statuses = [FXStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
          
          // 刷新表格
          [self.tableView reloadData];
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          
      }];
}

/**
 *  设置导航栏的内容
 */
- (void)setupNavBar
{
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(findFriend)];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    // 中间按钮
    FXTitleButton *titleButton = [FXTitleButton titleButton];
    // 图标
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    // 文字
    [titleButton setTitle:@"哈哈哈哈" forState:UIControlStateNormal];
    // 位置和尺寸
    titleButton.frame = CGRectMake(0, 0, 100, 40);
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}

- (void)titleClick:(FXTitleButton *)titleButton
{
    if (titleButton.currentImage == [UIImage imageNamed:@"navigationbar_arrow_up"]) {
        [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    } else {
        [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    }
}

- (void)findFriend
{
    FXLog(@"findFriend");
}

- (void)pop
{
    FXLog(@"pop");
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    // 2.设置cell的数据
    // 微博的文字(内容)
    FXStatus *status = self.statuses[indexPath.row];
    cell.textLabel.text = status.text;
    
    // 微博作者的昵称
    FXUser *user = status.user;
    cell.detailTextLabel.text = user.name;
    
    // 微博作者的头像
    [cell.imageView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"tabbar_compose_button"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
