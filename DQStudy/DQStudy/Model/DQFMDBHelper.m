//
//  DQFMDBHelper.m
//  DQStudy
//
//  Created by youdingquan on 16/5/2.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQFMDBHelper.h"
#import <FMDB.h>

static FMDatabase * db = nil;

@implementation DQFMDBHelper
+(FMDatabase *)database{
    if (!db) {
        NSString * documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString * path = [NSString stringWithFormat:@"%@/study.db",documents];
        NSLog(@"%@",path);
        db = [FMDatabase databaseWithPath:path];
        NSFileManager * filemanager = [NSFileManager defaultManager];
        if (![filemanager fileExistsAtPath:path]) {
            if ([db open]) {
                NSString * createList = @"create table list(title text primary key)";
                NSString * createDetail = @"create table detail(date text primary key, title text, name text, detail text, image text)";
                [db executeStatements:createList];
                [db executeStatements:createDetail];
                [db close];
            }
        }
    }
    return db;
}
@end
