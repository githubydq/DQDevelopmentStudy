//
//  DQListDao.h
//  DQStudy
//
//  Created by youdingquan on 16/5/2.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DQListModel;
@interface DQListDao : NSObject
+(BOOL)save:(DQListModel * )model;
+(BOOL)deleteAtModel:(DQListModel*)model;
+(NSMutableArray*)findAll;
@end
