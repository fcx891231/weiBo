//
//  FXSettingCell.m
//  12.27  我的微博
//
//  Created by fanxi on 16/3/1.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXSettingCell.h"
#import "FXBadgeButton.h"
#import "FXSettingItem.h"
#import "FXSettingArrowItem.h"
#import "FXSettingSwitchItem.h"
#import "UIImage+FX.h"

@interface FXSettingCell ()


@property (nonatomic,strong) UIImageView *arrowView;
@property (nonatomic,strong) UISwitch *switchView;
@property (nonatomic,strong) FXBadgeButton *badgeButton;

@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,weak) UIImageView *bgView;
@property (nonatomic,weak) UIImageView *selectedBgView;


@end

@implementation FXSettingCell


- (UIImageView *)arrowView
{

    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    
    return _arrowView;

}

- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
    }
    return _switchView;
}

- (FXBadgeButton *)badgeButton
{
    if (_badgeButton == nil) {
       _badgeButton= [[FXBadgeButton alloc] init];
    }
    return _badgeButton;
}



+ (instancetype)cellWithTableView:(UITableView *)tableView
{  static NSString *ID = @"setting";
    FXSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FXSettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }

    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        //标题
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.highlightedTextColor = self.textLabel.textColor;
        self.textLabel.font = [UIFont systemFontOfSize:15];
        
        
        
        //创建背景
        UIImageView *bgView = [[UIImageView alloc] init];
        self.backgroundView = bgView;
        self.bgView = bgView;
        
        
        UIImageView *selectedBgView = [[UIImageView alloc] init];
        self.selectedBackgroundView = selectedBgView;
        self.selectedBgView = selectedBgView;
        
        
    }
    return self;
}

- (void)setItem:(FXSettingItem *)item
{
    _item = item;
    
    [self setupData];
    
    [self setupRightView];
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{

    _indexPath = indexPath;
    //设置背景图片
    int totalRows = [self.tableView numberOfRowsInSection:indexPath.section];
    NSString *bgName = nil;
    NSString *selectedBgName = nil;
    
    if (totalRows ==1) {
        bgName = @"common_card_background";
        selectedBgName = @"common_card_background_highlighted";
    }  else if (indexPath.row == 0) {
        bgName = @"common_card_top_background";
        selectedBgName = @"common_card_top_background_highlighted";
    
    }  else if (indexPath.row == totalRows -1) {
        bgName = @"common_card_bottom_background";
        selectedBgName = @"common_card_bottom_background_highlighted";
    
    }  else {
        bgName = @"common_card_background";
        selectedBgName = @"common_card_background_highlighted";
    
    }
    
    self.bgView.image = [UIImage resizedImageWithName:bgName];
    self.selectedBgView.image = [UIImage resizedImageWithName:selectedBgName];


}

/**
 *  调整cell的frame

 */
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -= 10;


    [super setFrame:frame];
}

- (void)setupData
{
    if (self.item.icon) {
        self.imageView.image = [UIImage imageNamed:self.item.icon];
    }
    self.textLabel.text = self.item.title;

}

- (void)setupRightView
{
    if (self.item.badgeValue) {
        self.accessoryView = self.badgeButton;
        self.badgeButton.badgeValue = self.item.badgeValue;
    }  else if ([self.item isKindOfClass:[FXSettingArrowItem class] ]) {
        self.accessoryView = self.arrowView;
    
    }  else if ([self.item isKindOfClass:[FXSettingSwitchItem class]]) {
    
        self.accessoryView = self.switchView;
    }  else  {
        self.accessoryView = nil;
    }


}

@end
