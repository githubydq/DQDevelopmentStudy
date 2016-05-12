//
//  DQDetailDao.m
//  DQStudy
//
//  Created by youdingquan on 16/5/2.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQDetailDao.h"
#import "DQDetailModel.h"
#import "DQFMDBHelper.h"
#import <FMDB.h>
@implementation DQDetailDao
+(BOOL)save:(DQDetailModel * )model{
    FMDatabase * db = [DQFMDBHelper database];
    if ([db open]) {
        BOOL isSuccese = [db executeUpdate:@"insert into detail(date, title, name, detail, image) values(?, ?, ?, ?, ?)", model.date, model.title, model.name, model.detail, model.image];
        [db close];
        return isSuccese;
    }
    return NO;
}
+(BOOL)deleteAtModel:(DQDetailModel*)model{
    FMDatabase * db = [DQFMDBHelper database];
    if ([db open]) {
        BOOL isSuccese = [db executeUpdate:@"delete from detail where date=?",model.date];
        [db close];
        return isSuccese;
    }
    return NO;
}
+(BOOL)updateAtModel:(DQDetailModel*)model{
    FMDatabase * db = [DQFMDBHelper database];
    if ([db open]) {
        BOOL isSuccese = [db executeUpdate:@"update detail set name=?, detail=?, image=? where date=?",model.name, model.detail, model.image, model.date];
        [db close];
        return isSuccese;
    }
    return NO;
}
+(NSMutableArray*)findAtTitle:(NSString*)title{
    FMDatabase * db = [DQFMDBHelper database];
    if ([db open]) {
        NSMutableArray * listArray = [[NSMutableArray alloc] init];
        FMResultSet * rs = [db executeQuery:@"select * from detail where title=?",title];
        while (rs.next) {
            DQDetailModel * model = [[DQDetailModel alloc] init];
            model.date = [rs stringForColumnIndex:0];
            model.title = [rs stringForColumnIndex:1];
            model.name = [rs stringForColumnIndex:2];
            model.detail = [rs stringForColumnIndex:3];
            model.image = [rs stringForColumnIndex:4];
            [listArray insertObject:model atIndex:0];
        }
        [db close];
        return listArray;
    }
    return nil;
}

+(NSMutableArray *)searchWithString:(NSString *)str From:(NSString *)title{
    FMDatabase * db = [DQFMDBHelper database];
    if ([db open]) {
        NSMutableArray * resultArray = [[NSMutableArray alloc] init];
        FMResultSet * rs = [db executeQuery:@"select * from detail where title=?",title];
        while (rs.next) {
            if ([[rs stringForColumnIndex:2] containsString:str]) {
                DQDetailModel * model = [[DQDetailModel alloc] init];
                model.date = [rs stringForColumnIndex:0];
                model.title = [rs stringForColumnIndex:1];
                model.name = [rs stringForColumnIndex:2];
                model.detail = [rs stringForColumnIndex:3];
                model.image = [rs stringForColumnIndex:4];
                [resultArray addObject:model];
            }
        }
        [db close];
        return resultArray;
    }
    return nil;
}
@end
