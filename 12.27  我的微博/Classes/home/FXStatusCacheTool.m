//
//  FXStatusCacheTool.m
//  12.27  我的微博
//
//  Created by fanxi on 16/2/28.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXStatusCacheTool.h"
#import "FMDB.h"
#import "FXAccount.h"
#import "FXAccountTool.h"
#import "FXStatus.h"


@implementation FXStatusCacheTool

static FMDatabaseQueue *_queue;


+ (void)initialize
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"status.sqlite"];
   
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement,access_token text,idstr text,status blob);"];
    }];

}

+ (void)addStatus:(FXStatus *)status
{
    NSString *access_token = [FXAccountTool account].access_token;
    NSString *idstr = status.idstr;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:status];
    
    
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"insert into t_status (access_token,idstr,status) values (?,?,?)",access_token,idstr,data];
        // 2.存储数据
       
    }];


}

+ (void)addstatuses:(NSArray *)statusArray
{
    for (FXStatus *status in statusArray) {
        [self addStatus:status];
    }
}

+ (NSArray *)statusesWithParam:(FXHomeStatusParam *)param
{
 
    // 1.定义数组
    __block NSMutableArray *statusArray = nil;
    
    // 2.使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        statusArray = [NSMutableArray array];
        
        // accessToken
        NSString *accessToken = [FXAccountTool account].access_token;
        
        FMResultSet *rs = nil;
        if (param.since_id) { // 如果有since_id
            rs = [db executeQuery:@"select * from t_status where access_token = ? and idstr > ? order by idstr desc limit 0,?;", accessToken, param.since_id, param.count];
        } else if (param.max_id) { // 如果有max_id
            rs = [db executeQuery:@"select * from t_status where access_token = ? and idstr <= ? order by idstr desc limit 0,?;", accessToken, param.max_id, param.count];
        } else { // 如果没有since_id和max_id
            rs = [db executeQuery:@"select * from t_status where access_token = ? order by idstr desc limit 0,?;", accessToken, param.count];
        }
        
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"status"];
          FXStatus *status = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [statusArray addObject:status];
        }
    }];
    
    // 3.返回数据
    return statusArray;

}

@end
