//
//  FXPhotosView.h
//  12.27  我的微博
//
//  Created by fanxi on 16/1/30.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
@class FXPhoto;

@interface FXPhotosView : UIView
/**
 *  需要展示的图片(数组里面装的都是IWPhoto模型)
 */
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic,strong)  FXPhoto  *photo;


/**
 *  根据图片的个数返回相册的最终尺寸
 */
+ (CGSize)photosViewSizeWithPhotosCount:(int)count;

@end
