//
//  FXAccountTool.m
//  12.27  我的微博
//
//  Created by fanxi on 16/1/10.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXAccountTool.h"
#import "fxAccount.h"
#import "FXHttpTool.h"
#import "MJExtension.h"

@implementation FXAccountTool
#define FXAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

+ (void)saveAccount:(FXAccount *)account
{
  //计算过期时间
    NSDate *now = [NSDate date];
    
    account.expiresTime = [now dateByAddingTimeInterval:account.expires_in];
    
    
    [NSKeyedArchiver archiveRootObject:account toFile:FXAccountFile];
    

}

+ (FXAccount *)account
{

 
    
    FXAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:FXAccountFile];
    NSDate *now = [NSDate date];
    
    if ([now compare:account.expiresTime] == NSOrderedAscending) {
        return account;
    }   else
    
    { return nil;
    }

}

+ (void)accessTokenWithParam:(FXAccessTokenParam *)param success:(void (^)(FXAccessTokenResult *))success failure:(void (^)(NSError *))failure
{
    
    [FXHttpTool postWithURL:@"https://api.weibo.com/oauth2/access_token" params:param.keyValues

     success:^(id jason) {
         if (success) {
             FXAccessTokenResult *result = [FXAccessTokenResult objectWithKeyValues:jason];
             success(result);
         }
      } failure:^(NSError *error) {
          if (failure) {
              failure(error);
          }
      }];




}


@end
