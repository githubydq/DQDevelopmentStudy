//
//  DQDetailDao.h
//  DQStudy
//
//  Created by youdingquan on 16/5/2.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DQDetailModel;
@interface DQDetailDao : NSObject
+(BOOL)save:(DQDetailModel * )model;
+(BOOL)deleteAtModel:(DQDetailModel*)model;
+(BOOL)updateAtModel:(DQDetailModel*)model;
+(NSMutableArray*)findAtTitle:(NSString*)title;
+(NSMutableArray*)searchWithString:(NSString*)str From:(NSString*)title;
@end
