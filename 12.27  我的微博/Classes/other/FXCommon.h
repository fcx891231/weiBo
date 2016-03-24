//
//  common.h
//  12.27  我的微博
//
//  Created by fanxi on 16/3/1.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

// 0.账号相关
#define IWAppKey @"2497360706";
#define IWAppSecret @"ec09eeafa2192e0c6ce935cf48997644"
#define IWRedirectURI @"http://www.baidu.com";

#define IWLoginURL [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", IWAppKey, IWRedirectURI]

// 2.获得RGB颜色
#define FXColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 3.自定义Log
#ifdef DEBUG
#define FXLog(...) NSLog(__VA_ARGS__)
#else
#define FXLog(...)
#endif

// 4.是否为4inch
#define fourInch ([UIScreen mainScreen].bounds.size.height == 568)

// 5.微博cell上面的属性
/** 昵称的字体 */
#define FXStatusNameFont [UIFont systemFontOfSize:15]
/** 被转发微博作者昵称的字体 */
#define FXRetweetStatusNameFont FXStatusNameFont

/** 时间的字体 */
#define FXStatusTimeFont [UIFont systemFontOfSize:12]
/** 来源的字体 */
#define FXStatusSourceFont FxStatusTimeFont

/** 正文的字体 */
#define FXStatusContentFont [UIFont systemFontOfSize:13]
/** 被转发微博正文的字体 */
#define FXRetweetStatusContentFont FXStatusContentFont

/** 表格的边框宽度 */
#define FXStatusTableBorder 5

/** cell的边框宽度 */
#define FXStatusCellBorder 10

// 6.微博cell内部相册
#define FXPhotoW 70
#define FXPhotoH 70
#define FXPhotoMargin 10

// 7.常用的对象
#define FXNotificationCenter [NSNotificationCenter defaultCenter]