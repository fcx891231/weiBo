//
//  FXStatusFrame.m
//  12.27  我的微博
//
//  Created by fanxi on 16/1/16.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXStatusFrame.h"
#import "FXStatus.h"
#import "FXUser.h"
#import "FXPhotosView.h"

@implementation FXStatusFrame


- (void)setStatus:(FXStatus *)status
{

    _status = status;
    
    //cell宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2*FXStatusTableBorder;
    
    //1.topView
    CGFloat topViewW = cellW;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    CGFloat topViewH = 0;
    
    //2.头像
    
    CGFloat iconViewWH =35;
    CGFloat iconViewX = FXStatusTableBorder;
    CGFloat iconViewY = FXStatusTableBorder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    //3.昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + FXStatusTableBorder;
    CGFloat nameLabelY = iconViewY;
    CGSize nameLabelSize = [status.user.name sizeWithFont:FXStatusNameLabelFont];
    _nameLabelF = (CGRect){{nameLabelX,nameLabelY},nameLabelSize};
    
    //4.会员图标
    if (status.user.mbtype) {
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelF) + FXStatusTableBorder;
        CGFloat vipViewY = nameLabelY;
        CGFloat vipViewW = 14;
        CGFloat vipViewH = nameLabelSize.height;
        _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
        
    }
  
    //5.时间
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelF) + FXStatusTableBorder;
    
    CGSize timeLabelSize = [status.created_at sizeWithFont:FXStatusTimeLabelFont];
    _timeLabelF = (CGRect) {{timeLabelX,timeLabelY},timeLabelSize};
    
   //6.来源
    
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelF) + FXStatusTableBorder;
    CGFloat sourceLabelY = timeLabelY;
    
    CGSize sourceLabelSize = [status.source sizeWithFont:FXStatusSourceLabelFont];
    _sourceLabelF = (CGRect) {{sourceLabelX,sourceLabelY},sourceLabelSize};
    
    //7.微博内容
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_iconViewF), CGRectGetMaxY(_timeLabelF)) + FXStatusTableBorder;
    
    CGFloat contentLabelMaxW = topViewW - 2 *FXStatusTableBorder;
    CGSize contentLabelSize = [status.text sizeWithFont:FXStatusContentLabelFont constrainedToSize:CGSizeMake(contentLabelMaxW, MAXFLOAT)];
    
    _contentLabelF = (CGRect) {{contentLabelX,contentLabelY},contentLabelSize};
    
    //8.微博配图
    if (status.pic_urls.count) {
#warning 根据配图个数计算配图尺寸
        
        CGSize photosViewSize = [FXPhotosView photosViewSizeWithPhotosCount:status.pic_urls.count];
        CGFloat photosViewX = contentLabelX;
        CGFloat photosViewY = CGRectGetMaxY(_contentLabelF) + FXStatusTableBorder;
        _photosViewF = CGRectMake(photosViewX, photosViewY, photosViewSize.width, photosViewSize.height);
        
    }
    
//    //9.被转发微博的view
//    if (status.retweeted_status) {
//        CGFloat retweetViewX = contentLabelX;
//        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF) + FXStatusTableBorder;
//        CGFloat retweetViewW = contentLabelMaxW;
//        CGFloat retweetViewH = 0;
//        
//        
//        
//    //10.被转发微博的昵称
//        
//        CGFloat retweetNameLabelX = FXStatusTableBorder;
//        CGFloat retweetNameLabelY = FXStatusTableBorder;
//        NSString *name = [NSString stringWithFormat:@"@%@",status.retweeted_status.user.name];
//        CGSize retweetNameLabelSize = [name sizeWithFont:FXRetweetStatusNameLabelFont];
//        _retweetNameLabelF = (CGRect){{retweetNameLabelX,retweetNameLabelY},retweetNameLabelSize};
//        
//        
//    //11.被转发微博的正文
//        CGFloat retweetContentLabelX = retweetNameLabelX;
//        CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelF) + FXStatusTableBorder;
//        
//        CGFloat retweetContentLabelMaxW = retweetViewW - 2*FXStatusTableBorder;
//        CGSize retweetContentLabelSize = [status.retweeted_status.text sizeWithFont:FXRetweerStatusContentLabelFont constrainedToSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT)];
//        _retweetContentLabelF = (CGRect){{retweetContentLabelX,retweetContentLabelY},retweetContentLabelSize};
//        
//    //12.转发微博配图
//        if (status.retweeted_status.thumbnail_pic) {
//            CGFloat retweetPhotoViewX = retweetContentLabelX;
//            CGFloat retweetPhotoViewY = CGRectGetMaxY(_retweetContentLabelF) +FXStatusTableBorder;
//            CGFloat RetweetPhotoViewWH = 70;
//            
//            _retweetPhotoViewF = CGRectMake(retweetPhotoViewX, retweetPhotoViewY, RetweetPhotoViewWH, RetweetPhotoViewWH);
//            
//            retweetViewH = CGRectGetMaxY(_retweetPhotoViewF);
//            
//        }  else {
//            retweetViewH = CGRectGetMaxY(_retweetContentLabelF);
//        }
//        
//        retweetViewH += FXStatusTableBorder;
//        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
//        
//        //有转发微博时
//        topViewH = CGRectGetMaxY(_retweetViewF);
//    }  else {//没有转发微博
//        if (status.thumbnail_pic) {
//            topViewH = CGRectGetMaxY(_photoViewF);
//        }  else {
//            topViewH = CGRectGetMaxY(_contentLabelF);
//        }
//        topViewH += FXStatusTableBorder;
//        _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
//        
//    
//    }
    
    // 9.被转发微博
    if (status.retweeted_status) {
        CGFloat retweetViewW = contentLabelMaxW;
        CGFloat retweetViewX = contentLabelX;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF) + FXStatusTableBorder;
        CGFloat retweetViewH = 0;
        
        // 10.被转发微博的昵称
        CGFloat retweetNameLabelX = FXStatusTableBorder;
        CGFloat retweetNameLabelY = FXStatusTableBorder;
        NSString *name = [NSString stringWithFormat:@"@%@", status.retweeted_status.user.name];
        CGSize retweetNameLabelSize = [name sizeWithFont:FXRetweetStatusNameLabelFont];
        _retweetNameLabelF = (CGRect){{retweetNameLabelX, retweetNameLabelY}, retweetNameLabelSize};
        
        // 11.被转发微博的正文
        CGFloat retweetContentLabelX = retweetNameLabelX;
        CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelF) + FXStatusTableBorder;
        CGFloat retweetContentLabelMaxW = retweetViewW - 2 *FXStatusTableBorder;
        CGSize retweetContentLabelSize = [status.retweeted_status.text sizeWithFont:FXRetweerStatusContentLabelFont constrainedToSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT)];
        _retweetContentLabelF = (CGRect){{retweetContentLabelX, retweetContentLabelY}, retweetContentLabelSize};
        
        // 12.被转发微博的配图
        if(status.retweeted_status.pic_urls.count) {
           
            CGSize retweetPhotosViewSize = [FXPhotosView photosViewSizeWithPhotosCount:status.retweeted_status.pic_urls.count];
            CGFloat retweetPhotosViewX = retweetContentLabelX;
            CGFloat retweetPhotosViewY = CGRectGetMaxY(_retweetContentLabelF) + FXStatusTableBorder;
            _retweetPhotosViewF = CGRectMake(retweetPhotosViewX, retweetPhotosViewY, retweetPhotosViewSize.width,retweetPhotosViewSize.height);
            
            retweetViewH = CGRectGetMaxY(_retweetPhotosViewF);
        } else { // 没有配图
            retweetViewH = CGRectGetMaxY(_retweetContentLabelF);
        }
        retweetViewH += FXStatusTableBorder;
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        // 有转发微博时topViewH
        topViewH = CGRectGetMaxY(_retweetViewF);
    } else { // 没有转发微博
        if (status.thumbnail_pic) { // 有图
            topViewH = CGRectGetMaxY(_photosViewF);
        } else { // 无图
            topViewH = CGRectGetMaxY(_contentLabelF);
        }
    }
    topViewH += FXStatusTableBorder;
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);

    
    
    //13.工具条
    
    CGFloat statusToolbarX = topViewX;
    CGFloat statusToolbarY = CGRectGetMaxY(_topViewF);
    CGFloat statusToolbarW = topViewW;
    CGFloat statusToolbarH = 35;
    
    _statusToolbarF = CGRectMake(statusToolbarX, statusToolbarY, statusToolbarW, statusToolbarH);
    
    _cellHeight = CGRectGetMaxY(_statusToolbarF) +FXStatusTableBorder;
    

   }

@end
