//
//  DQDetailModel.m
//  DQStudy
//
//  Created by youdingquan on 16/5/2.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQDetailModel.h"

@implementation DQDetailModel

-(NSString *)description{
    return [NSString stringWithFormat:@"%ld,%@,%@,%@,%@",self.myID,self.title, self.name, self.detail, self.image];
}

@end
