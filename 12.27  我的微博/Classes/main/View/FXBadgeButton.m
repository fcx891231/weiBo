//
//  FXBadgeButton.m
//  12.27  我的微博
//
//  Created by fanxi on 16/1/1.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXBadgeButton.h"
#import "UIImage+FX.h"

@implementation FXBadgeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        UIImage *bg = [UIImage imageNamed:@"main_badge_os7"];
//        UIImage *strechImage = [bg stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5];
        
        [self setBackgroundImage:[UIImage resizedImageWithName:@"main_badge_os7"] forState:UIControlStateNormal];
      
        self.userInteractionEnabled = NO;
        self.hidden = YES;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{

    
    _badgeValue = [badgeValue copy];
    
    if (badgeValue && [badgeValue intValue] != 0) {
        self.hidden = NO;
        // 设置文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        // 设置frame
        CGRect frame = self.frame;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        if (badgeValue.length > 1) {
            // 文字的尺寸
            CGSize badgeSize = [badgeValue sizeWithFont:self.titleLabel.font];
            badgeW = badgeSize.width + 5;
        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
    } else {
        self.hidden = YES;
    }


}

@end
