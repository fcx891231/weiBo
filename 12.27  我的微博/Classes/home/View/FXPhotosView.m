//
//  FXPhotosView.m
//  12.27  我的微博
//
//  Created by fanxi on 16/1/30.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXPhotosView.h"
#import "FXPhoto.h"
#import "UIImageView+WebCache.h"
#import "FXPhotoView.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#define FxPhotoW 70
#define FXPhotoH 70
#define FXPhotoMargin 10

@implementation FXPhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        for (int i = 0; i<9; i++) {
           FXPhotoView *photoView = [[FXPhotoView alloc] init];
            photoView.userInteractionEnabled = YES;
            photoView.tag = i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)];
            [photoView addGestureRecognizer:tap];
            
            [self addSubview:photoView];
        }
    }
    return self;
}

- (void)photoTap:(UIGestureRecognizer *)recognizer
{
    int count = self.photos.count;
    
    // 1.封装图片数据
    NSMutableArray *myphotos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 一个MJPhoto对应一张显示的图片
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        
        mjphoto.srcImageView = self.subviews[i]; // 来源于哪个UIImageView
        
        FXPhoto *fxphoto = self.photos[i];
        NSString *photoUrl = [fxphoto.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mjphoto.url = [NSURL URLWithString:photoUrl]; // 图片路径
        
        [myphotos addObject:mjphoto];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = recognizer.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = myphotos; // 设置所有的图片
    [browser show];
    
 


}

- (void)setPhotos:(NSArray *)photos
{

    _photos = photos;
    
    for (int i = 0; i<self.subviews.count; i++) {
    
    
       FXPhotoView *photoView = self.subviews[i];
        
        // 判断这个imageView是否需要显示数据
        if (i < photos.count) {
            // 显示图片
            photoView.hidden = NO;
            
            photoView.photo = photos[i];
            
            // 传递模型数据
            
            
            // 设置子控件的frame
            int maxColumns = (photos.count == 4) ? 2 : 3;
            int col = i % maxColumns;
            int row = i / maxColumns;
            CGFloat photoX = col * (FxPhotoW + FXPhotoMargin);
            CGFloat photoY = row * (FXPhotoH + FXPhotoMargin);
           photoView.frame = CGRectMake(photoX, photoY, FxPhotoW, FXPhotoH);
//           [photoView setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            // Aspect : 按照图片的原来宽高比进行缩
            // UIViewContentModeScaleAspectFit : 按照图片的原来宽高比进行缩放(一定要看到整张图片)
            // UIViewContentModeScaleAspectFill :  按照图片的原来宽高比进行缩放(只能图片最中间的内容)
            // UIViewContentModeScaleToFill : 直接拉伸图片至填充整个imageView
            
            if (photos.count == 1) {
               photoView.contentMode = UIViewContentModeScaleAspectFit;
               photoView.clipsToBounds = NO;
            } else {
               photoView.contentMode = UIViewContentModeScaleAspectFill;
               photoView.clipsToBounds = YES;
            }
        } else { // 隐藏imageView
              photoView.hidden = YES;
        }
    }

    

}


+ (CGSize)photosViewSizeWithPhotosCount:(int)count
{
    // 一行最多有3列
    int maxColumns = (count == 4) ? 2 : 3;
    
    //  总行数
    int rows = (count + maxColumns - 1) / maxColumns;
    // 高度
    CGFloat photosH = rows * FXPhotoH + (rows - 1) * FXPhotoMargin;
    
    // 总列数
    int cols = (count >= maxColumns) ? maxColumns : count;
    // 宽度
    CGFloat photosW = cols * FxPhotoW + (cols - 1) * FXPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
    /**
     一共60条数据 == count
     一页10条 == size
     总页数 == pages
     pages = (count + size - 1)/size;
     */
}

@end
