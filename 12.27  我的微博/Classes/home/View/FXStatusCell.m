//
//  FXStatusCell.m
//  12.27  我的微博
//
//  Created by fanxi on 16/1/16.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXStatusCell.h"
#import "FXStatus.h"
#import "FXStatusFrame.h"
#import "FXUser.h"
#import "UIImage+FX.h"
#import "FXStatusToolbar.h"
#import "FXStatusTopView.h"

@interface FXStatusCell ()

@property (nonatomic,weak) FXStatusTopView *topView;   //顶部的imageView

@property (nonatomic,weak) FXStatusToolbar *statusToolBar;      //微博底部工具条

@end

@implementation FXStatusCell


+ (instancetype)cellWithTableview:(UITableView *)tableView
{
    static NSString *ID =@"status";
    FXStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FXStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return  cell;

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupTopView];//初始化原创微博所有子控件
       
        [self setupStatusToolBar];   //初始化底部工具条
        
     
    }
    return self;
}

- (void)setupTopView
{
    self.selectedBackgroundView = [[UIView alloc] init];
    
    //1.topview
    FXStatusTopView *topView = [[FXStatusTopView alloc] init];
    
    [self.contentView addSubview:topView];
    self.topView = topView;
    
       
}



- (void)setupStatusToolBar
{
    FXStatusToolbar *statusToolBar = [[FXStatusToolbar alloc] init];
    statusToolBar.image = [UIImage resizedImageWithName:@"timeline_card_bottom_background"];
    statusToolBar.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted"];
    [self.contentView addSubview:statusToolBar];
    self.statusToolBar = statusToolBar;
    
}


- (void)setStatusFrame:(FXStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    [self setupTopViewData];        //设置topView数据
    [self setupStatusToolbarData];  //设置底部工具条数据

}


- (void)setFrame:(CGRect)frame
{
    frame.origin.y += FXStatusTableBorder;
    frame.origin.x = FXStatusTableBorder;
    frame.size.width -= 2 * FXStatusTableBorder;
    frame.size.height -= FXStatusTableBorder;
    [super setFrame:frame];
}



- (void)setupTopViewData
{

    self.topView.frame = self.statusFrame.topViewF;
    
    self.topView.statusFrame = self.statusFrame;



}


- (void)setupStatusToolbarData
{
    self.statusToolBar.frame = self.statusFrame.statusToolbarF;
    self.statusToolBar.status = self.statusFrame.status;

}

@end
