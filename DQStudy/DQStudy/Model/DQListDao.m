//
//  DQListDao.m
//  DQStudy
//
//  Created by youdingquan on 16/5/2.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQListDao.h"
#import "DQListModel.h"
#import "DQFMDBHelper.h"
#import <FMDB.h>

@implementation DQListDao
+(BOOL)save:(DQListModel *)model{
    FMDatabase * db = [DQFMDBHelper database];
    if ([db open]) {
        BOOL isSuccese = [db executeUpdate:@"insert into list(title) values(?)",model.title];
        [db close];
        return isSuccese;
    }
    return NO;
}

+(BOOL)deleteAtModel:(DQListModel *)model{
    FMDatabase * db = [DQFMDBHelper database];
    if ([db open]) {
        BOOL isSuccese = [db executeUpdate:@"delete from list where id=?",model.myID];
        [db close];
        return isSuccese;
    }
    return NO;
}

+(NSMutableArray *)findAll{
    FMDatabase * db = [DQFMDBHelper database];
    if ([db open]) {
        NSMutableArray * listArray = [[NSMutableArray alloc] init];
        FMResultSet * rs = [db executeQuery:@"select * from list"];
        while (rs.next) {
            DQListModel * model = [[DQListModel alloc] init];
            model.myID = [rs intForColumnIndex:0];
            model.title = [rs stringForColumnIndex:1];
            [listArray addObject:model];
        }
        [db close];
        return listArray;
    }
    return nil;
}
@end
