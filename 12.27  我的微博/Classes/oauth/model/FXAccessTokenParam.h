//
//  FXAccessTokenParam.h
//  12.27  我的微博
//
//  Created by fanxi on 16/2/28.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXAccessTokenParam : NSObject

@property (nonatomic,copy) NSString *client_id;
@property (nonatomic,copy) NSString *client_secret;
@property (nonatomic,copy) NSString *grant_type;
@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *redirect_uri;


/*   
 parameters[@"client_id"] = @"2497360706";
 parameters[@"client_secret"] = @"ec09eeafa2192e0c6ce935cf48997644";
 parameters[@"grant_type"] = @"authorization_code";
 parameters[@"code"] = code;
 parameters[@"redirect_uri"] = @"http://www.baidu.com";
 
 */

@end
