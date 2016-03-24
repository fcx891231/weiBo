//
//  FXNewFutureController.m
//  12.27  我的微博
//
//  Created by fanxi on 16/1/2.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXNewFutureController.h"
#import "FXTabBarController.h"
#define FXImageCount 3

@interface FXNewFutureController () <UIScrollViewDelegate>
@property (nonatomic,weak) UIPageControl *pageControl;

@end

@implementation FXNewFutureController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupScrollView];
    [self setupPageControl];
    
    
}

- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];

    
    
    
    scrollView.contentSize = CGSizeMake(FXImageCount *self.view.frame.size.width,0 );
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
   
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH= scrollView.frame.size.height;
    
    for (int index = 0; index <FXImageCount; index++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",index+1];
        imageView.image = [UIImage imageNamed:name];
        CGFloat imageY = 0;
        CGFloat imageX = index *imageW;
        
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        
        if (index == FXImageCount -1) {
            [self setupLastImageView:imageView];
        }
        
        [scrollView addSubview:imageView];
    }
    



}

- (void)setupLastImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    
    //添加开始按钮
    UIButton *start = [[UIButton alloc] init];
    [start setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [start setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [start setTitle:@"开始微博" forState:UIControlStateNormal];
    [start setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    start.center = CGPointMake(w*0.5, h*0.6);
    start.bounds = (CGRect){CGPointZero,start.currentBackgroundImage.size};
    [start addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:start];

    //添加checkBox
    UIButton *checkBox = [[UIButton alloc] init];
    checkBox.selected = YES;
    [checkBox setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkBox setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    checkBox.bounds = CGRectMake(0, 0, 200, 30);
    checkBox.center = CGPointMake(w*0.5, h*0.5);
    
    checkBox.titleLabel.font = [UIFont systemFontOfSize:15];
    [checkBox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [checkBox setTitle:@"分享给大家" forState:UIControlStateNormal];
    [checkBox addTarget:start action:@selector(checkBoxClick:) forControlEvents:UIControlEventTouchUpInside];
    checkBox.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [imageView addSubview:checkBox];
    
    


}
- (void)start
{
    self.view.window.rootViewController = [[FXTabBarController alloc] init];


}

- (void)checkBoxClick:(UIButton *)checkBox
{

    checkBox.selected = !checkBox.isSelected;

}

- (void)setupPageControl
{   
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = FXImageCount;
    
    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    pageControl.center = CGPointMake(w*0.5, h-30);
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = [UIColor blackColor];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    


}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat w = self.view.frame.size.width;
   
    int page = (scrollView.contentOffset.x +w*0.5)/w;
    
    self.pageControl.currentPage = page;
   
}

@end
