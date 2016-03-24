//
//  FXRetweetStatusView.m
//  12.27  我的微博
//
//  Created by fanxi on 16/1/29.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXRetweetStatusView.h"
#import "UIImage+FX.h"
#import "FXStatus.h"
#import "FXStatusFrame.h"
#import "FXUser.h"
#import "FXPhoto.h"
#import "UIImageView+WebCache.h"

#import "FXPhotosView.h"

@interface FXRetweetStatusView ()

@property (nonatomic,weak) FXPhotosView *retweetPhotosView;   //转发的配图

@property (nonatomic,weak) UILabel *retweetNameLabel;       //被转发的昵称

@property (nonatomic,weak)  UILabel *retweetContentLabel;   //被转发的微博正文

@end

@implementation FXRetweetStatusView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         self.userInteractionEnabled = YES;
         self.image = [UIImage resizedImageWithName:@"timeline_retweet_background" left:0.9 top:0.5];
        
        //2.被转发的微博配图
        FXPhotosView *retweetPhotosView = [[FXPhotosView alloc] init];
        [self addSubview:retweetPhotosView];
        self.retweetPhotosView = retweetPhotosView;
        
        //3.被转发的微博昵称
        UILabel *retweetNameLabel = [[UILabel alloc] init];
        retweetNameLabel.backgroundColor = [UIColor clearColor];
        retweetNameLabel.textColor = FXColor(67, 107, 63);
        retweetNameLabel.font = FXRetweetStatusNameLabelFont;
        [self addSubview:retweetNameLabel];
        self.retweetNameLabel = retweetNameLabel;
        
        //4.被转发的微博正文
        UILabel *retweetContentLabel = [[UILabel alloc] init];
        retweetContentLabel.backgroundColor = [UIColor clearColor];
        retweetContentLabel.font = FXRetweerStatusContentLabelFont;
        retweetContentLabel.numberOfLines = 0;
        retweetContentLabel.textColor = FXColor(90, 90, 90);
        [self addSubview:retweetContentLabel];
        self.retweetContentLabel = retweetContentLabel;
        

    
    }
    return self;
}

- (void)setStatusFrame:(FXStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    FXStatus *retweetStatus = self.statusFrame.status.retweeted_status;
    FXUser *user = retweetStatus.user;
    
    
    // 2.昵称
    self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@", user.name];
    self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
    
    // 3.正文
    self.retweetContentLabel.text = retweetStatus.text;
    self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
    
    
    // 3.配图
    if (retweetStatus.pic_urls.count) {
        self.retweetPhotosView.hidden = NO;
        self.retweetPhotosView.frame = self.statusFrame.retweetPhotosViewF;
        self.retweetPhotosView.photos = retweetStatus.pic_urls;

    } else {
        self.retweetPhotosView.hidden = YES;
    }
}


@end
