//
//  FXComposetoolbar.h
//  12.27  我的微博
//
//  Created by fanxi on 16/2/10.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FXComposetoolbar;
typedef enum {
    FXComposetoolbarButtonTypeCamera,
    FXComposetoolbarButtonTypePicture,
    FXComposetoolbarButtonTypeMention,
    FXComposetoolbarButtonTypeTrend,
    FXComposetoolbarButtonTypeEmotion,

}FXComposetoolbarButtonType;

@protocol FXComposetoolbarDelegate <NSObject>

@optional

- (void)composeToolbar:(FXComposetoolbar *)toolbar didClickedButton:(FXComposetoolbarButtonType)buttonType;


@end

@interface FXComposetoolbar : UIView


@property (nonatomic,weak) id<FXComposetoolbarDelegate> delegate;

@end
