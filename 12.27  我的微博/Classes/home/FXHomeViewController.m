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
//#import "AFNetworking.h"
#import "FXAccountTool.h"
#import "FXAccount.h"
#import "UIImageView+WebCache.h"
#import "FXStatus.h"
#import "FXUser.h"
#import "MJExtension.h"
#import "FXStatusCell.h"
#import "FXStatusFrame.h"
#import "MJRefresh.h"
#import "UIImage+FX.h"
#import "MJRefresh.h"
#import "FXHttpTool.h"
//#import "FXHomeStatusParam.h"
#import "FXStatusTool.h"
#import "FXUserTool.h"

@interface FXHomeViewController () <MJRefreshBaseViewDelegate>
@property (nonatomic, weak) FXTitleButton *titleButton;
@property (nonatomic, strong) NSMutableArray *statusFrames;
@property (nonatomic, weak) MJRefreshFooterView *footer;
@property (nonatomic, weak) MJRefreshHeaderView *header;




@end

@implementation FXHomeViewController

- (NSMutableArray *)statusFrames
{
    
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
        
    }
    return _statusFrames;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.设置导航栏的内容
    [self setupNavBar];
    
    // 2.加载微博数据
//    [self setupStatusData];
    
    [self setupRefreshView];
    [self setupUserData];
}



/**
 *  获得用户信息
 */
- (void)setupUserData
{

    FXUserInfoParam *param = [FXUserInfoParam param];
    param.uid = @([FXAccountTool account].uid);
    
    [FXUserTool userInfoWithParam:param success:^(FXUserInfoResult *result) {
        [self.titleButton setTitle:result.name forState:UIControlStateNormal];
        FXAccount *account = [FXAccountTool account];
        account.name = result.name;
        [FXAccountTool saveAccount:account];
        
    } failure:^(NSError *error) {
        
    }];
    
}


/**
 *  集成刷新控件
 */
- (void)setupRefreshView
{
    // 1.下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    // 自动进入刷新状态
    [header beginRefreshing];
    self.header = header;
    
    // 2.上拉刷新(上拉加载更多数据)
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.delegate = self;
    self.footer = footer;
    //    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView){
    //        FXLog(@"refreshing.....");
    //    };
}

- (void)dealloc
{
    // 释放内存
    [self.header free];
    [self.footer free];
}

/**
 *  刷新控件进入开始刷新状态的时候调用
 */
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) { // 上拉刷新
        [self loadMoreData];
    } else { // 下拉刷新
        [self loadNewData];
    }
}



- (void)loadMoreData
{
    // 1.封装请求参数
    FXHomeStatusParam *param = [FXHomeStatusParam param];
    if (self.statusFrames.count) {
        FXStatusFrame *statusFrame = [self.statusFrames lastObject];
        // 加载ID <= max_id的微博
        param.max_id = @([statusFrame.status.idstr longLongValue] - 1);
    }
    
    // 2.发送请求
    [FXStatusTool homeStatusWithParam:param success:^(FXHomeStatusResult *result) {
        // 创建frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (FXStatus *status in result.statuses) {
            FXStatusFrame *statusFrame = [[FXStatusFrame alloc] init];
            // 传递微博模型数据
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        
        // 添加新数据到旧数据的后面
        [self.statusFrames addObjectsFromArray:statusFrameArray];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让刷新控件停止显示刷新状态
        [self.footer endRefreshing];
    } failure:^(NSError *error) {
        // 让刷新控件停止显示刷新状态
        [self.footer endRefreshing];
    }];
}

/**
 *  // 刷新数据(向新浪获取更新的微博数据)
 */
- (void)loadNewData
{
    // 0.清除提醒数字
    self.tabBarItem.badgeValue = nil;
    
    // 1.封装请求参数
    FXHomeStatusParam *param = [FXHomeStatusParam param];
    if (self.statusFrames.count) {
        FXStatusFrame *statusFrame = self.statusFrames[0];
        param.since_id = @([statusFrame.status.idstr longLongValue]);
    }
    
    // 2.发送请求
    [FXStatusTool homeStatusWithParam:param success:^(FXHomeStatusResult *result) {
        // 创建frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (FXStatus *status in result.statuses) {
            FXStatusFrame *statusFrame = [[FXStatusFrame alloc] init];
            // 传递微博模型数据
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        
        // 将最新的数据追加到旧数据的最前面
        // 旧数据: self.statusFrames
        // 新数据: statusFrameArray
        NSMutableArray *tempArray = [NSMutableArray array];
        // 添加statusFrameArray的所有元素 添加到 tempArray中
        [tempArray addObjectsFromArray:statusFrameArray];
        // 添加self.statusFrames的所有元素 添加到 tempArray中
        [tempArray addObjectsFromArray:self.statusFrames];
        self.statusFrames = tempArray;
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];
        
        // 显示最新微博的数量(给用户一些友善的提示)
        [self showNewStatusCount:statusFrameArray.count];
    } failure:^(NSError *error) {
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];
    }];
}

- (void)showNewStatusCount:(int)count
{
    // 1.创建一个按钮
    UIButton *btn = [[UIButton alloc] init];
    // below : 下面  btn会显示在self.navigationController.navigationBar的下面
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    // 2.设置图片和文字
    btn.userInteractionEnabled = NO;
    [btn setBackgroundImage:[UIImage resizedImageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    if (count) {
        NSString *title = [NSString stringWithFormat:@"共有%d条新的微博", count];
        [btn setTitle:title forState:UIControlStateNormal];
    } else {
        [btn setTitle:@"没有新的微博数据" forState:UIControlStateNormal];
    }
    
    // 3.设置按钮的初始frame
    CGFloat btnH = 30;
    CGFloat btnY = 64 - btnH;
    CGFloat btnX = 2;
    CGFloat btnW = self.view.frame.size.width - 2 * btnX;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    // 4.通过动画移动按钮(按钮向下移动 btnH + 1)
    [UIView animateWithDuration:0.7 animations:^{
        
        btn.transform = CGAffineTransformMakeTranslation(0, btnH + 2);
        
    } completion:^(BOOL finished) { // 向下移动的动画执行完毕后
        
        // 建议:尽量使用animateWithDuration, 不要使用animateKeyframesWithDuration
        [UIView animateWithDuration:0.7 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            // 将btn从内存中移除
            [btn removeFromSuperview];
        }];
        
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
    if ([FXAccountTool account].name) {
        [titleButton setTitle:[FXAccountTool account].name forState:UIControlStateNormal];
    } else {
        [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    }
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
    NSLog(@"findFriend");
}

- (void)pop
{
    NSLog(@"pop");
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FXStatusCell *cell = [FXStatusCell cellWithTableview:tableView];
    cell.statusFrame = self.statusFrames[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FXStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;

}

@end
