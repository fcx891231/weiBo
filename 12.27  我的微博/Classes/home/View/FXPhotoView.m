//
//  FXPhotoView.m
//  12.27  我的微博
//
//  Created by fanxi on 16/1/30.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXPhotoView.h"
#import "FXPhoto.h"
#import "UIImageView+WebCache.h"

@interface FXPhotoView ()

@property (nonatomic,weak) UIImageView *gifView;


@end

@implementation FXPhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return self;
}

- (void)setPhoto:(FXPhoto *)photo
{
    _photo = photo;
    
    self.gifView.hidden = ![photo.thumbnail_pic hasSuffix:@"gif"];  //控制gif的可见性
    
    [self setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.layer.anchorPoint = CGPointMake(1, 1);
    self.gifView.layer.position = CGPointMake(self.frame.size.width, self.frame.size.height);
    
}

@end
