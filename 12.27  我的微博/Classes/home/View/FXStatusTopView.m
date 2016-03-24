//
//  FXStatusTopView.m
//  12.27  我的微博
//
//  Created by fanxi on 16/1/29.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXStatusTopView.h"
#import "UIImage+FX.h"
#import "FXStatus.h"
#import "FXStatusFrame.h"
#import "FXUser.h"
#import "UIImageView+WebCache.h"
#import "FXRetweetStatusView.h"
#import "FXPhotosView.h"
#import "FXphoto.h"

@interface FXStatusTopView ()


@property (nonatomic,weak) UIImageView *iconView;  //头像

@property (nonatomic,weak) UIImageView *vipView;   //vip

@property (nonatomic,weak) FXPhotosView *photosView; //微博配图

@property (nonatomic,weak) UILabel *nameLabel;     //昵称

@property (nonatomic,weak) UILabel *timeLabel;     //时间

@property (nonatomic,weak) UILabel *sourceLabel;   //来源

@property (nonatomic,weak) UILabel *contentLabel;  //微博正文

@property (nonatomic,weak) FXRetweetStatusView *retweetView;        //转发的微博的view


@end

@implementation FXStatusTopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedImageWithName:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_top_background_highlighted"];
        
        //2.头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        //3.会员图标
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        //4.配图
        FXPhotosView *photosView = [[FXPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
        
        //5.昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = FXStatusNameLabelFont;
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        //6.时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = FXStatusTimeLabelFont;
        timeLabel.textColor = FXColor(240, 140, 19);
        timeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        //7.来源
        
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.font = FXStatusSourceLabelFont;
        sourceLabel.textColor = FXColor(135, 135, 135);
        sourceLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        //8.正文
        
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = FXStatusContentLabelFont;
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.numberOfLines = 0;
        contentLabel.textColor = FXColor(39, 39, 39);
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        //9.被转发的微博
      FXRetweetStatusView *retweetView = [[FXRetweetStatusView alloc] init];
        
        [self addSubview:retweetView];
        self.retweetView = retweetView;

        
       
    }
    return self;
}


- (void)setStatusFrame:(FXStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    FXStatus *status = self.statusFrame.status;
    FXUser *user = status.user;
    
    //1.topView
    self.frame = self.statusFrame.topViewF;
    
    //2.头像
    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.iconView.frame = self.statusFrame.iconViewF;
    
    //3.昵称
    
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    
    
    //4.vip
    if (user.mbrank) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]];
        self.nameLabel.textColor = [UIColor orangeColor];
        self.vipView.frame = self.statusFrame.vipViewF;
    }  else  {
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
        
        
    }
    
    //5.时间
    
    self.timeLabel.text = status.created_at;
    CGFloat timeLabelX = self.nameLabel.frame.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(self.statusFrame.nameLabelF) + FXStatusTableBorder;
    
    CGSize timeLabelSize = [status.created_at sizeWithFont:FXStatusTimeLabelFont];
    
    
    self.timeLabel.frame = (CGRect){{timeLabelX,timeLabelY},timeLabelSize};
    
    
    //    NSLog(@"%@",status.created_at);
    
    
    //6.来源
    
    
    
    
    self.sourceLabel.text = status.source;
    
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabel.frame) + FXStatusTableBorder;
    CGFloat sourceLabelY = timeLabelY;
    
    CGSize sourceLabelSize = [status.source sizeWithFont:FXStatusSourceLabelFont];
    
    self.sourceLabel.frame = (CGRect){{sourceLabelX,sourceLabelY},sourceLabelSize};
    
    
    
    
    //    NSLog(@"%@",status.source);
    
    
    //7.内容
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    
    //8.配图
    
    if (status.pic_urls.count) {
        self.photosView.hidden = NO;
        self.photosView.frame = self.statusFrame.photosViewF;
        self.photosView.photos = status.pic_urls;
     
//        [self setImageWithURL:[NSURL URLWithString:status.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    }else{
        self.photosView.hidden = YES;
    }
    
    // 9.被转发微博
    FXStatus *retweetStatus = status.retweeted_status;
    if (retweetStatus) {
        self.retweetView.hidden = NO;
        self.retweetView.frame = self.statusFrame.retweetViewF;
        
        // 传递模型数据
        self.retweetView.statusFrame = self.statusFrame;
    } else {
        self.retweetView.hidden = YES;
    }
}


@end
