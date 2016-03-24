//
//  FXStatusToolbar.m
//  12.27  我的微博
//
//  Created by fanxi on 16/1/25.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXStatusToolbar.h"
#import "UIImage+FX.h"
#import "fxstatus.h"

@interface FXStatusToolbar ()

@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic,strong) NSMutableArray *dividers;

@property (nonatomic,weak) UIButton *retweetBtn;
@property (nonatomic,weak) UIButton *commentBtn;
@property (nonatomic,weak) UIButton *attitudeBtn;


@end

@implementation FXStatusToolbar

- (NSArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
    
}

- (NSMutableArray *)dividers
{
    if (_dividers == nil) {
        _dividers = [NSMutableArray array];
    }

    return _dividers;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedImageWithName:@"timeline_card_bottom_background"];
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted"];
        
        
        self.retweetBtn = [self setupBtnWithTitle:@"转发" image:@"timeline_icon_retweet" bgImage:@"timeline_card_leftbottom_highlighted"];
        self.commentBtn = [self setupBtnWithTitle:@"评论" image:@"timeline_icon_comment" bgImage:@"timeline_card_middlebottom_highlighted"];
        self.attitudeBtn = [self setupBtnWithTitle:@"赞" image:@"timeline_icon_unlike" bgImage:@"timeline_card_rightbottom_highlighted"];
        
        
        [self setupDivider];
        [self setupDivider];
        
        
        
       
    }
    return self;
}

- (UIButton *)setupBtnWithTitle:(NSString *)title image:(NSString *)image bgImage:(NSString *)bgImage
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    btn.adjustsImageWhenHighlighted = NO;
    [btn setBackgroundImage:[UIImage resizedImageWithName:bgImage] forState:UIControlStateHighlighted];
    [self addSubview:btn];
    
    // 添加按钮到数组
    [self.btns addObject:btn];
    
    return btn;
}

- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    [self.dividers addObject:divider];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
  //1.设置按钮的frame
    int dividerCount = self.dividers.count;
    int btnCount = self.btns.count;
    CGFloat dividerW = 2;
    
    CGFloat btnY = 0;
    CGFloat btnH = self.frame.size.height;
    CGFloat btnW = (self.frame.size.width - dividerCount * dividerW)/btnCount;
    
    for (int i = 0; i<btnCount; i++) {
        UIButton *btn = self.btns[i];
        CGFloat btnX = i*(dividerW + btnW);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
 //2.设置divider的frame
    
    CGFloat dividerH = btnH;
    CGFloat dividerY = 0;
    for (int j = 0; j<dividerCount; j++) {
        UIImageView *divider = self.dividers[j];
        UIButton *btn = self.btns[j];
        CGFloat dividerX = CGRectGetMaxX(btn.frame);
        
        divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    }


}

- (void)setStatus:(FXStatus *)status
{
    _status = status;
    
    [self setupBtn:self.retweetBtn originalTitile:@"转发" count:status.reposts_count];
    [self setupBtn:self.commentBtn originalTitile:@"评论" count:status.comments_count];
    [self setupBtn:self.attitudeBtn originalTitile:@"赞" count:status.attitudes_count];

}

- (void)setupBtn:(UIButton *)btn originalTitile:(NSString *)originalTitle count:(int)count
{
    if (count) {
        NSString *title = nil;
        
        if (count<10000) {
            title = [NSString stringWithFormat:@"%d",count];
            
        }
        
        else {
            double countDouble = count/10000.0;
            title = [NSString stringWithFormat:@"%.1f万",countDouble];
        
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
            
           
            
        }
        
         [btn setTitle:title forState:UIControlStateNormal];
        
    }  else {
    
        [btn setTitle:originalTitle forState:UIControlStateNormal];
    }
    
//
//    if (count) { // 个数不为0
//        NSString *title = nil;
//        if (count < 10000) { // 小于1W
//            title = [NSString stringWithFormat:@"%d", count];
//        } else { // >= 1W
//            // 42342 / 1000 * 0.1 = 42 * 0.1 = 4.2
//            // 10742 / 1000 * 0.1 = 10 * 0.1 = 1.0
//            // double countDouble = count / 1000 * 0.1;
//            
//            // 42342 / 10000.0 = 4.2342
//            // 10742 / 10000.0 = 1.0742
//            double countDouble = count / 10000.0;
//            title = [NSString stringWithFormat:@"%.1f万", countDouble];
//            
//            // title == 4.2万 4.0万 1.0万 1.1万
//            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
//        }
//        [btn setTitle:title forState:UIControlStateNormal];
//    } else {
//        [btn setTitle:originalTitle forState:UIControlStateNormal];
//    }
//

}

@end
