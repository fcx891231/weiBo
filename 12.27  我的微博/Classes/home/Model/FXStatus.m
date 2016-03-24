//
//  FXStatus.m
//  12.27  我的微博
//
//  Created by fanxi on 16/1/10.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXStatus.h"
#import "FXUser.h"
#import "FXPhoto.h"
#import "MJExtension.h"

@implementation FXStatus

MJCodingImplementation

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [FXPhoto class]};
}




//+ (instancetype)statusWithDict:(NSDictionary *)dict
//{
//    return  [[self alloc] initWithDict:dict];
//    
//}
//
//- (instancetype)initWithDict:(NSDictionary *)dict
//{
//    if (self = [super init]) {
//        self.text = dict[@"text"];
//        self.source = dict[@"source"];
//        self.idstr = dict[@"idstr"];
//        self.reposts_count = [dict[@"reposts_count"] intValue];
//        self.comments_count = [dict[@"comments_count"] intValue];
//        
//        self.user = [FXUser userWithDict:dict[@"user"]];
//        
//    }
//
//    return  self;
//}
//

//2016-01-17 16:53:46.208 12.27  我的微博[40683:607] <a href="http://app.weibo.com/t/feed/5kCfVp" rel="nofollow">天生会转 OPPO N3</a>
//2016-01-17 16:53:46.211 12.27  我的微博[40683:607] <a href="http://app.weibo.com/t/feed/3Eot6O" rel="nofollow">北京地铁微博统一平台</a>



- (void)setSource:(NSString *)source
{
  
//    NSLog(@"%@",source);
    _source = @"来自新浪微博";

}

- (NSString *)created_at
{

     return @"1分钟以前";

}
@end
