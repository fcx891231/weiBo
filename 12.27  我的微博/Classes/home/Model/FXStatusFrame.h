//
//  FXStatusFrame.h
//  12.27  我的微博
//
//  Created by fanxi on 16/1/16.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FXStatusNameLabelFont [UIFont systemFontOfSize:15]
//微博昵称字体

#define FXStatusContentLabelFont [UIFont systemFontOfSize:13]
//微博正文字体

#define FXStatusTimeLabelFont [UIFont systemFontOfSize:12]
//微博时间字体

#define FXStatusSourceLabelFont FXStatusTimeLabelFont
//微博来源的字体

#define FXRetweetStatusNameLabelFont FXStatusNameLabelFont

#define FXRetweerStatusContentLabelFont FXStatusContentLabelFont

#define FXRetweetStatusTimeLabelFont FXStatusTimeLbelFont

/** 表格的边框宽度 */
#define FXStatusTableBorder 5

@class FXStatus;
@interface FXStatusFrame : NSObject

@property (nonatomic,assign,readonly) CGRect topViewF;  //顶部的view
@property (nonatomic,assign,readonly) CGRect iconViewF; //头像
@property (nonatomic,assign,readonly) CGRect vipViewF;  //会员图标
@property (nonatomic,assign,readonly) CGRect photosViewF; //配图
@property (nonatomic,assign,readonly) CGRect nameLabelF; // 昵称
@property (nonatomic,assign,readonly) CGRect timeLabelF; //时间
@property (nonatomic,assign,readonly) CGRect sourceLabelF;//来源
@property (nonatomic,assign,readonly) CGRect contentLabelF;//内容


@property (nonatomic,assign,readonly) CGRect retweetViewF; //被转发微博view
@property (nonatomic,assign,readonly) CGRect retweetNameLabelF; //被转发微博昵称
@property (nonatomic,assign,readonly) CGRect retweetContentLabelF; //被转发微博内容
@property (nonatomic,assign,readonly) CGRect retweetPhotosViewF; //被转发微博配图

@property (nonatomic,assign,readonly) CGRect statusToolbarF;  //底部工具条
@property (nonatomic,assign,readonly) CGFloat cellHeight;  // cell高度



@property (nonatomic,strong)  FXStatus  *status;


@end
